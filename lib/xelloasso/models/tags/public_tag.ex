defmodule Xelloasso.Models.Tags.PublicTag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:name, :string)
    field(:score, :float)
  end

  def changeset(mod, attrs) do
    cast(mod, attrs, [:name, :score])
    |> validate_required([:name, :score])
  end

  def new(attrs) do
    changeset(%__MODULE__{}, attrs)
    |> Ecto.Changeset.apply_action!(:update)
  end
end
