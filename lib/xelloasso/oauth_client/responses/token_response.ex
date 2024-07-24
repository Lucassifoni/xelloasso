defmodule Xelloasso.OauthClient.Responses.TokenResponse do
  defstruct [:client_id, :access_token, :expires_in, :refresh_token, :token_type]

  def new(%{
        "client_id" => client_id,
        "access_token" => access_token,
        "expires_in" => expires_in,
        "refresh_token" => refresh_token,
        "token_type" => token_type
      }) do
    %__MODULE__{
      client_id: client_id,
      access_token: access_token,
      expires_in: expires_in,
      refresh_token: refresh_token,
      token_type: token_type
    }
  end

  def new(%__MODULE__{} = t), do: t
end
