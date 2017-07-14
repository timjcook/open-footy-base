defmodule OpenFootyBase.TeamView do
  use OpenFootyBase.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :nickname]

  has_one :home_ground, type: "ground", include: false
end
