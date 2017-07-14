defmodule OpenFootyBase.Team do
  use OpenFootyBase.Web, :model

  schema "teams" do
    field :name, :string
    field :nickname, :string
    belongs_to :home_ground, OpenFootyBase.Ground
    # has_many :home_matches, OpenFootyBase.Match, related_key: :home_team_id
    # has_many :away_matches, OpenFootyBase.Match, related_key: :away_team_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :nickname])
    |> validate_required([:name, :nickname])
    |> unique_constraint(:name)
    |> unique_constraint(:nickname)
  end
end
