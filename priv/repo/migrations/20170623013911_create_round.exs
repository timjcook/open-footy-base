defmodule OpenFootyBase.Repo.Migrations.CreateRound do
  use Ecto.Migration

  def change do
    create table(:rounds) do
      add :round_number, :integer
      add :season_id, references(:seasons, on_delete: :delete_all)

      timestamps()
    end
    create index(:rounds, [:season_id])
    create unique_index(:rounds, [:season_id, :round_number])
  end
end
