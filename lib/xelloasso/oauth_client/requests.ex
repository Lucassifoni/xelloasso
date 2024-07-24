defmodule Xelloasso.OauthClient.Requests do
  alias Xelloasso.OauthClient.Responses.Token
  alias Xelloasso.OauthClient.Responses

  @prod_url "https://api.helloasso.com/"
  @sandbox_url "https://api.helloasso-sandbox.com/"

  if Mix.env() == :prod do
    defp get_root_url(), do: Application.get_env(:xelloasso, :api_url) || @prod_url
  else
    defp get_root_url(), do: Application.get_env(:xelloasso, :api_url) || @sandbox_url
  end

  defp get_oauth_endpoint(), do: get_root_url() <> "oauth2/"

  def client_credentials(client_id, client_secret) do
    {:ok, response} =
      Req.post(get_oauth_endpoint() <> "token",
        form: [
          client_id: client_id,
          client_secret: client_secret,
          grant_type: "client_credentials"
        ]
      )

    case response.body do
      %{"token_type" => _} = body ->
        %Token{} = t = Responses.parse_token_response(client_id, body)
        t

      _ ->
        :error
    end
  end

  def refresh_token(%Token{} = previous_token) do
    {:ok, response} =
      Req.post(get_oauth_endpoint() <> "token",
        form: [
          client_id: previous_token.client_id,
          grant_type: "refresh_token",
          refresh_token: previous_token.refresh_token
        ]
      )

    case response.body do
      %{"token_type" => _} = body ->
        %Token{} = t = Responses.parse_token_response(previous_token.client_id, body)
        t

      _ ->
        :error
    end
  end
end
