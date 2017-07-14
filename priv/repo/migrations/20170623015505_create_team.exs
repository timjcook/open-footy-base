defmodule OpenFootyBase.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :nickname, :string
      add :home_ground_id, references(:grounds, on_delete: :nothing)

      timestamps()
    end
    create index(:teams, [:home_ground_id])
    create unique_index(:teams, [:name])
  end
end
