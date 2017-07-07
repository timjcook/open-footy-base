defmodule OpenFootyBase.PageController do
  use OpenFootyBase.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
