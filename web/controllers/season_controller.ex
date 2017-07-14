defmodule OpenFootyBase.SeasonController do
  use OpenFootyBase.Web, :controller

  alias OpenFootyBase.Season

  def index(conn, _params) do
    seasons = Repo.all(Season)
    render(conn, "index.json-api", data: seasons)
  end

  def create(conn, %{"data" => %{ "attributes" => season_params } }) do
    changeset = Season.changeset(%Season{}, season_params)

    case Repo.insert(changeset) do
      {:ok, season} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", season_path(conn, :show, season))
        |> render("show.json-api", season: season)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(OpenFootyBase.ChangesetView, "errors.json-api", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    season = Repo.get!(Season, id) |> Repo.preload([:rounds])
    render(conn, "show.json-api", season: season)
  end

  def update(conn, %{"id" => id, "season" => season_params}) do
    season = Repo.get!(Season, id)
    changeset = Season.changeset(season, season_params)

    case Repo.update(changeset) do
      {:ok, season} ->
        render(conn, "show.json-api", season: season)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(OpenFootyBase.ChangesetView, "errors.json-api", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    season = Repo.get!(Season, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(season)

    send_resp(conn, :no_content, "")
  end
end
