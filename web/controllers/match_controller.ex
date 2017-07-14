defmodule OpenFootyBase.MatchController do
  use OpenFootyBase.Web, :controller

  alias OpenFootyBase.Season
  alias OpenFootyBase.Round
  alias OpenFootyBase.Match

  def index(conn, _params) do
    matches = Repo.all(Match)
    render(conn, "index.json", matches: matches)
  end

  def create(conn, %{"data" => %{ "attributes" => match_params } }) do
    changeset = Match.changeset(%Match{}, match_params)

    case Repo.insert(changeset) do
      {:ok, match} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", match_path(conn, :show, match))
        |> render("show.json", match: match)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(OpenFootyBase.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    match = Match |> Repo.get(id) |> Repo.preload([:home_team, :away_team, :ground, :round])
    render(conn, "show.json-api", match: match)
  end

  def update(conn, %{"id" => id, "match" => match_params}) do
    match = Repo.get!(Match, id)
    changeset = Match.changeset(match, match_params)

    case Repo.update(changeset) do
      {:ok, match} ->
        render(conn, "show.json", match: match)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(OpenFootyBase.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    match = Repo.get!(Match, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(match)

    send_resp(conn, :no_content, "")
  end
end
