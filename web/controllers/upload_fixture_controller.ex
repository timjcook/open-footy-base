require IEx
require OpenFootyBase.FixtureCSVParser
alias OpenFootyBase.FixtureCSVParser

defmodule OpenFootyBase.UploadFixtureController do
  use OpenFootyBase.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, %{"create_params" => %{ "year" => year, "fixture_file" => fixture } }) do
    
    FixtureCSVParser.parse(year, fixture)

    render conn, "index.html"
  end
end
