defmodule LiveTraining.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def change do
    create table(:ratings) do
      add :rating, :integer
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :game_id, references(:games, on_delete: :delete_all), null: false

      timestamps()
    end

    create_if_not_exists index(:ratings, [:user_id])
    create_if_not_exists index(:ratings, [:game_id])
    create_if_not_exists unique_index(:ratings, [:user_id, :game_id])
  end
end
