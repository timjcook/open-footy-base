defmodule OpenFootyBase.FixtureCSVParser do

  alias OpenFootyBase.Repo
  alias OpenFootyBase.Season
  alias OpenFootyBase.Round
  alias OpenFootyBase.Match
  alias OpenFootyBase.Team
  alias OpenFootyBase.Ground

  def parse(year, fixture) do
    IO.inspect year
    IO.inspect fixture

    season = find_or_create_season(year)
    IO.inspect season

    fixture_rows = fixture.path
    |> Path.expand(__DIR__)
    |> File.stream!
    |> CSV.decode

    fixture_rows
    |> Enum.each(fn(row) -> parse_row(season, row) end)
  end

  def find_or_create_season(year) do
    case Repo.get_by(Season, year: year) do
      nil -> create_and_save_season(year)
      season -> season
    end
  end

  def create_and_save_season(year) do
    case Repo.insert(Season.changeset(%Season{}, %{ "year" => year })) do
      {:ok, season} -> season
    end
  end

  def parse_row(season, {_status, [ round_number, match_date, home_team_name, away_team_name, ground, match_time ]}) do
    current_round = find_or_create_round(season, String.to_integer(round_number))
    # IO.inspect current_round

    home_team = find_team(home_team_name)
    # IO.inspect home_team

    away_team = find_team(away_team_name)
    # IO.inspect away_team

    starts_at = create_starts_at_datetime(match_date, match_time)
    # IO.inspect starts_at

    match_ground = find_ground(ground)
    # IO.inspect match_ground

    match = create_and_save_match(current_round, home_team, away_team, match_ground, starts_at)
    IO.inspect match
  end

  def create_starts_at_datetime(starts_at_date, starts_at_time) do
    time_details = case String.contains?(starts_at_time, "am") do
      true -> String.replace(starts_at_time, ~r/am|pm/, "")
      |> String.split(":")
      |> Enum.concat(["am"])
      false -> String.replace(starts_at_time, ~r/am|pm/, "")
      |> String.split(":")
      |> Enum.concat(["pm"])
    end

    starts_at_time = case time_details do
      ["12", minute, "pm"] -> Enum.join(["12", minute, "00"], ":")
      [hour, minute, "pm"] -> Enum.join([Integer.to_string(String.to_integer(hour) + 12), minute, "00"], ":")
      [hour, minute, _] -> Enum.join([hour, minute, "00"], ":")
    end

    case Ecto.DateTime.cast(Enum.join([starts_at_date, starts_at_time], " ")) do
      {:ok, starts_at} -> starts_at
    end
  end

  def find_or_create_round(season, round_number) do
    case Repo.get_by(Round, round_number: round_number) do
      nil -> create_and_save_round(season, round_number)
      current_round -> current_round
    end
  end
  
  def create_and_save_round(season, round_number) do
    case Repo.insert(Ecto.build_assoc(season, :rounds, round_number: round_number)) do
      { :ok, current_round } -> current_round
    end
  end

  def create_and_save_match(current_round, home_team, away_team, ground, starts_at) do
    case Repo.insert(Ecto.build_assoc(current_round, :matches, home_team: home_team, away_team: away_team, ground: ground, starts_at: starts_at, complete: false)) do
      { :ok, match } -> match
    end
  end

  def find_team(team_name) do
    Repo.get_by!(Team, name: team_name)
  end

  def find_ground(initial) do
    Repo.get_by!(Ground, initial: initial)
  end

end
