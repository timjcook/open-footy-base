defmodule OpenFootyBase.RoundView do
  use OpenFootyBase.Web, :view
  use JaSerializer.PhoenixView

  attributes [:round_number]
  has_many :matches, type: "match", include: false
end
