defmodule OpenFootyBase.SeasonView do
  use OpenFootyBase.Web, :view
  use JaSerializer.PhoenixView

  attributes [:year]
  has_many :rounds, type: "round", include: false

end
