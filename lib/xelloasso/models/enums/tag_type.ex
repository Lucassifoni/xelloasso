defmodule Xelloasso.Models.Enums.TagType do
  import Ecto.Changeset

  def valid?(changeset, field) do
    changeset |> validate_format(field, ~r/Explore|Internal/)
  end
end
