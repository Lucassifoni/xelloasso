defmodule Xelloasso.Models.Tags.InternalTag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :integer, []}
  embedded_schema do
    field(:name, :string)
    field(:formCount, :integer)
    field(:organizationCount, :integer)
    field(:tagType, :string)
    embeds_one(:tagParent, __MODULE__)
    field(:amountCollected, :integer)
  end

  def changeset(mod, attrs) do
    cast(mod, attrs, [
      :id,
      :name,
      :formCount,
      :organizationCount,
      :tagType,
      :amountCollected
    ])
    |> cast_embed(:tagParent, __MODULE__)
    |> validate_required([
      :id,
      :name,
      :formCount,
      :organizationCount,
      :tagType,
      :amountCollected
    ])
  end

  def new(attrs) do
    changeset(%__MODULE__{}, attrs)
    |> Ecto.Changeset.apply_action!(:update)
  end
end
