defmodule OpenFootyBase.PageView do
  use OpenFootyBase.Web, :view

  def render("index.json", %{seasons: seasons}) do
    %{
      data: %{
        attributes: render_many(seasons, OpenFootyBase.PageView, "season.json")
      }
    }
  end
end
