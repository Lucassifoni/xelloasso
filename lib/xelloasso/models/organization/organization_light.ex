defmodule Xelloasso.Models.Organization.OrganizationLight do
  use Ecto.Schema
  alias Xelloasso.Models.Enums.GlobalRole

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:logo, :string)
    field(:name, :string)
    field(:role, :string)
    field(:city, :string)
    field(:zipCode, :string)
    field(:description, :string)
    field(:updateDate, :string)
    field(:categoryJoId, :integer)
    field(:url, :string)
    field(:organizationSlug, :string)
  end

  def changeset(mod, attrs) do
    cast(mod, attrs, [
      :logo,
      :name,
      :role,
      :city,
      :zipCode,
      :description,
      :updateDate,
      :categoryJoId,
      :url,
      :organizationSlug
    ])
    |> validate_required([
      :logo,
      :name,
      :role,
      :city,
      :zipCode,
      :description,
      :updateDate,
      :categoryJoId,
      :url,
      :organizationSlug
    ])
    |> GlobalRole.valid?(:role)
  end

  def new(attrs) do
    changeset(%__MODULE__{}, attrs)
    |> Ecto.Changeset.apply_action!(:update)
  end
end
