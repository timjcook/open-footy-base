defmodule OpenFootyBase.Repo.Migrations.CreateGround do
  use Ecto.Migration

  def change do
    create table(:grounds) do
      add :name, :string
      add :initial, :string
      add :state, :string

      timestamps()
    end
    create unique_index(:grounds, [:name])
  end
end
