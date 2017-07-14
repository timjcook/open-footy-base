defmodule OpenFootyBase.Round do
  use OpenFootyBase.Web, :model

  schema "rounds" do
    field :round_number, :integer
    belongs_to :season, OpenFootyBase.Season
    has_many :matches, OpenFootyBase.Match

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:round_number])
    |> validate_required([:round_number])
  end
end
