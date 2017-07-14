defmodule OpenFootyBase.Repo.Migrations.CreateSeason do
  use Ecto.Migration

  def change do
    create table(:seasons) do
      add :year, :integer

      timestamps()
    end
    create unique_index(:seasons, [:year])
  end
end
