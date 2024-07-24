defmodule Xelloasso.OauthClient do
  alias Xelloasso.OauthClient.Requests
  alias Xelloasso.OauthClient.Responses.Token

  use GenServer

  @impl true
  def init(options) do
    case options do
      %{client_id: _client_id, client_secret: _client_secret, callback: _cb} ->
        {:ok, nil, {:continue, {:oauth_flow, options}}}

      {%Token{} = t, callback} ->
        {:ok, {t, callback}}
    end
  end

  def start_link(options) do
    GenServer.start_link(__MODULE__, options, name: __MODULE__)
  end

  @impl true
  def handle_continue({:oauth_flow, options}, _state) do
    case Requests.client_credentials(options.client_id, options.client_secret) do
      :error ->
        {:stop, :normal, nil}

      %Token{} = t ->
        options.callback.(t)
        send(self(), :refresh_token)
        {:noreply, {t, options.callback}}
    end
  end

  @impl true
  def handle_info(:refresh_token, {state, callback}) do
    case Requests.refresh_token(state) do
      :error ->
        {:stop, :normal, {state, callback}}

      %Token{} = t ->
        callback.(t)
        Process.send_after(self(), :refresh_token, t.expires_in * 900)
        {:noreply, {t, callback}}
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
    {:ok, pid} = start_link({Token.new(params), token_refresh_callback})
    schedule_refresh()
    {:ok, pid}
  end
end
