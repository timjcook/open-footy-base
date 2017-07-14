defmodule OpenFootyBase.Match do
  use OpenFootyBase.Web, :model

  schema "matches" do
    field :starts_at, Ecto.DateTime
    field :complete, :boolean

    field :home_score_goals, :integer
    field :home_score_behinds, :integer
    field :home_score_total, :integer

    field :away_score_goals, :integer
    field :away_score_behinds, :integer
    field :away_score_total, :integer

    belongs_to :home_team, OpenFootyBase.Team
    belongs_to :away_team, OpenFootyBase.Team
    belongs_to :ground, OpenFootyBase.Ground
    belongs_to :round, OpenFootyBase.Round

    timestamps()
  end

  @doc """
  Returns all matches for a specific round
  """
  def for_round(query, round) do
    from m in query,
      join: r in assoc(m, :round),
      where: r.id == ^round.id
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:starts_at])
    |> validate_required([:starts_at])
  end
end
