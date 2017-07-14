defmodule OpenFootyBase.GroundController do
  use OpenFootyBase.Web, :controller

  alias OpenFootyBase.Ground

  def index(conn, _params) do
    grounds = Repo.all(Ground)
    render(conn, "index.json", grounds: grounds)
  end

  def create(conn, %{"ground" => ground_params}) do
    changeset = Ground.changeset(%Ground{}, ground_params)

    case Repo.insert(changeset) do
      {:ok, ground} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ground_path(conn, :show, ground))
        |> render("show.json", ground: ground)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(OpenFootyBase.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ground = Repo.get!(Ground, id)
    render(conn, "show.json", ground: ground)
  end

  def update(conn, %{"id" => id, "ground" => ground_params}) do
    ground = Repo.get!(Ground, id)
    changeset = Ground.changeset(ground, ground_params)

    case Repo.update(changeset) do
      {:ok, ground} ->
        render(conn, "show.json", ground: ground)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(OpenFootyBase.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ground = Repo.get!(Ground, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(ground)

    send_resp(conn, :no_content, "")
  end
end
