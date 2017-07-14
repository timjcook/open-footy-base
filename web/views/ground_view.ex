defmodule OpenFootyBase.GroundView do
  use OpenFootyBase.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :initial, :nickname]
end
