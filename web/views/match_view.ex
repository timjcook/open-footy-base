defmodule OpenFootyBase.MatchView do
  use OpenFootyBase.Web, :view
  use JaSerializer.PhoenixView

  attributes [:starts_at, :complete]

  has_one :home_team, type: "team", include: false
  has_one :away_team, type: "team", include: false
  has_one :ground, type: "ground", include: false
  has_one :round, type: "round", include: false
end
