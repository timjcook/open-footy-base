defmodule OpenFootyBase.Ground do
  use OpenFootyBase.Web, :model

  schema "grounds" do
    field :name, :string
    field :initial, :string
    field :state, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :state])
    |> validate_required([:name, :state])
  end
end
