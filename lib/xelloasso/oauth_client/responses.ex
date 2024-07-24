defmodule Xelloasso.OauthClient.Responses do
  alias Xelloasso.OauthClient.Responses.TokenResponse

  def parse_token_response(client_id, %{
        "access_token" => at,
        "expires_in" => expires,
        "refresh_token" => refresh,
        "token_type" => "bearer"
      }) do
    %TokenResponse{
      client_id: client_id,
      access_token: at,
      expires_in: expires,
      refresh_token: refresh,
      token_type: "bearer"
    }
  end
end
