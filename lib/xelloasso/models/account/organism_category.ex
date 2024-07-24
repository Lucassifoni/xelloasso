defmodule Xelloasso.Models.Account.OrganismCategory do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :integer, []}
  embedded_schema do
    field(:label, :string)
    field(:shortLabel, :string)
  end

  def changeset(mod, attrs) do
    cast(mod, attrs, [:id, :label, :shortLabel])
    |> validate_required([:id, :label, :shortLabel])
  end

  def new(attrs) do
    changeset(%__MODULE__{}, attrs)
    |> Ecto.Changeset.apply_action!(:update)
  end
end
