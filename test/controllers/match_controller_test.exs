defmodule OpenFootyBase.MatchControllerTest do
  use OpenFootyBase.ConnCase

  alias OpenFootyBase.Match
  @valid_attrs %{starts_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, match_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    match = Repo.insert! %Match{}
    conn = get conn, match_path(conn, :show, match)
    assert json_response(conn, 200)["data"] == %{"id" => match.id,
      "starts_at" => match.starts_at,
      "home_team_id" => match.home_team_id,
      "away_team_id" => match.away_team_id,
      "ground_id" => match.ground_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, match_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, match_path(conn, :create), match: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Match, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, match_path(conn, :create), match: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    match = Repo.insert! %Match{}
    conn = put conn, match_path(conn, :update, match), match: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Match, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    match = Repo.insert! %Match{}
    conn = put conn, match_path(conn, :update, match), match: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    match = Repo.insert! %Match{}
    conn = delete conn, match_path(conn, :delete, match)
    assert response(conn, 204)
    refute Repo.get(Match, match.id)
  end
end
