defmodule LiveTraining.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :game_name, :string, null: false

      timestamps()
    end
  end
end
