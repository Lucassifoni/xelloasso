defmodule Xelloasso.Models.Enums.Enum do
  defmacro __using__(values) do
    quote do
      import Ecto.Changeset

      def valid?(changeset, field) do
        changeset
        |> validate_inclusion(field, unquote(values))
      end

      def valid_list?(changeset, field) do
        changeset |> Ecto.Changeset.validate_subset(field, unquote(values))
      end
    end
  end
end
