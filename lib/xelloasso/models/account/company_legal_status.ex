defmodule Xelloasso.Models.Account.CompanyLegalStatus do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :integer, []}
  embedded_schema do
    field(:label, :string)
  end

  def changeset(mod, attrs) do
    cast(mod, attrs, [:id, :label])
    |> validate_required([:id, :label])
  end

  def new(attrs) do
    changeset(%__MODULE__{}, attrs)
    |> Ecto.Changeset.apply_action!(:update)
  end
end
