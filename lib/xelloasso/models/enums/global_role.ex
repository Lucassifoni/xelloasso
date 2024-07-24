defmodule Xelloasso.Models.Enums.GlobalRole do
  import Ecto.Changeset

  def valid?(changeset, field) do
    changeset |> validate_format(field, ~r/OrganizationAdmin|FormAdmin/)
  end
end
