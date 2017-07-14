defmodule OpenFootyBase.GroundControllerTest do
  use OpenFootyBase.ConnCase

  alias OpenFootyBase.Ground
  @valid_attrs %{name: "some content", state: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, ground_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    ground = Repo.insert! %Ground{}
    conn = get conn, ground_path(conn, :show, ground)
    assert json_response(conn, 200)["data"] == %{"id" => ground.id,
      "name" => ground.name,
      "state" => ground.state}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, ground_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, ground_path(conn, :create), ground: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Ground, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, ground_path(conn, :create), ground: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    ground = Repo.insert! %Ground{}
    conn = put conn, ground_path(conn, :update, ground), ground: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Ground, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    ground = Repo.insert! %Ground{}
    conn = put conn, ground_path(conn, :update, ground), ground: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    ground = Repo.insert! %Ground{}
    conn = delete conn, ground_path(conn, :delete, ground)
    assert response(conn, 204)
    refute Repo.get(Ground, ground.id)
  end
end
