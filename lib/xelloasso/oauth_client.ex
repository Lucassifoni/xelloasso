defmodule Xelloasso.OauthClient do
  alias Xelloasso.OauthClient.Responses
  alias Xelloasso.OauthClient.Responses.TokenResponse

  @sandbox_url "https://api.helloasso-sandbox.com/"
  @oauth_endpoint @sandbox_url <> "oauth2/"
  @base_url @sandbox_url <> "v5"

  use GenServer

  @impl true
  def init(options) do
    case options do
      %{client_id: _client_id, client_secret: _client_secret, callback: _cb} ->
        {:ok, nil, {:continue, {:oauth_flow, options}}}

      {%TokenResponse{} = t, callback} ->
        {:ok, {t, callback}}
    end
  end

  def start_link(options) do
    GenServer.start_link(__MODULE__, options, name: __MODULE__)
  end

  @impl true
  def handle_continue({:oauth_flow, credentials}, _state) do
    {:ok, response} =
      Req.post(@oauth_endpoint <> "token",
        form: [
          client_id: credentials.client_id,
          client_secret: credentials.client_secret,
          grant_type: "client_credentials"
        ]
      )

    case response.body do
      %{"token_type" => _} = body ->
        %TokenResponse{} = t = Responses.parse_token_response(credentials.client_id, body)
        credentials.callback.(t)
        send(self(), :refresh_token)
        {:noreply, {t, credentials.callback}}

      _ ->
        :stop
    end
  end

  @impl true
  def handle_info(:refresh_token, {state, callback}) do
    {:ok, response} =
      Req.post(@oauth_endpoint <> "token",
        form: [
          client_id: state.client_id,
          grant_type: "refresh_token",
          refresh_token: state.refresh_token
        ]
      )

    case response.body do
      %{"token_type" => _} = body ->
        %TokenResponse{} = t = Responses.parse_token_response(state.client_id, body)
        callback.(t)
        Process.send_after(self(), :refresh_token, t.expires_in * 900)
        {:noreply, {t, callback}}

      _ ->
        :stop
    end
  end

  def run_flow(client_id, client_secret, token_refresh_callback) do
    start_link(%{
      client_id: client_id,
      client_secret: client_secret,
      callback: token_refresh_callback
    })
  end

  defp schedule_refresh() do
    send(__MODULE__, :refresh_token)
  end

  def restore_flow(params, token_refresh_callback) do
    {:ok, pid} = start_link({TokenResponse.new(params), token_refresh_callback})
    schedule_refresh()
    {:ok, pid}
  end
end
