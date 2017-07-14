require IEx;
defmodule OpenFootyBase.RoundController do
  use OpenFootyBase.Web, :controller

  alias OpenFootyBase.Season
  alias OpenFootyBase.Round
  alias OpenFootyBase.Match

  def index(conn, _params) do
    rounds = Repo.all(Round)
    render(conn, "index.json-api", rounds: rounds)
  end

  def create(conn, %{"data" => %{ "attributes" => round_params } }) do
    changeset = Round.changeset(%Round{}, round_params)

    case Repo.insert(changeset) do
      {:ok, round} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", round_path(conn, :show, round))
        |> render("show.json-api", round: round)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(OpenFootyBase.ChangesetView, "errors.json-api", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    round = Repo.get!(Round, id) 
    |> Repo.preload matches: from(m in Match, order_by: m.starts_at)

    render(conn, "show.json-api", round: round)
  end

  def update(conn, %{"id" => id, "round" => round_params}) do
    round = Repo.get!(Round, id)
    changeset = Round.changeset(round, round_params)

    case Repo.update(changeset) do
      {:ok, round} ->
        render(conn, "show.json-api", round: round)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(OpenFootyBase.ChangesetView, "errors.json-api", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    round = Repo.get!(Round, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(round)

    send_resp(conn, :no_content, "")
  end
end
