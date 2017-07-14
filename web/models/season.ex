defmodule OpenFootyBase.Season do
  use OpenFootyBase.Web, :model

  schema "seasons" do
    field :year, :integer
    has_many :rounds, OpenFootyBase.Round

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(season, params \\ %{}) do
    season
    |> cast(params, [:year])
    |> validate_required([:year])
    |> validate_inclusion(:year, 1897..2100)
    |> unique_constraint(:year)
  end
end
