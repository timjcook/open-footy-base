defmodule OpenFootyBase.Repo.Migrations.CreateMatch do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :starts_at, :datetime
      add :complete, :boolean

      add :home_score_goals, :integer
      add :home_score_behinds, :integer
      add :home_score_total, :integer

      add :away_score_goals, :integer
      add :away_score_behinds, :integer
      add :away_score_total, :integer

      add :round_id, references(:rounds, on_delete: :delete_all)
      add :home_team_id, references(:teams, on_delete: :nothing)
      add :away_team_id, references(:teams, on_delete: :nothing)
      add :ground_id, references(:grounds, on_delete: :nothing)

      timestamps()
    end
    create index(:matches, [:home_team_id])
    create index(:matches, [:away_team_id])
    create index(:matches, [:ground_id])

  end
end
