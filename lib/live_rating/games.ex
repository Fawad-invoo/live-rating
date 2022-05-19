defmodule LiveRating.Games do
  import Ecto.Query, warn: false
  alias LiveRating.Repo

  alias LiveRating.Games.Game

  def register_game(attrs) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  def change_game_registration(%Game{} = game, attrs \\ %{}) do
    Game.view_changeset(game, attrs)
  end

  def get_all_games() do
    Repo.all(Game) |> update_list()
  end

  def update_list(games) do
    Enum.map(games, fn game ->
      %{
        id: game.id,
        game_name: game.game_name
      }
    end)
  end
end
