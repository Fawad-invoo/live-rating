defmodule LiveRatingWeb.GameController do
  use LiveRatingWeb, :controller

  alias LiveRating.Games
  alias LiveRating.Games.Game

  def new(conn, _params) do
    changeset = Games.change_game_registration(%Game{})
    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"game" => game}) do
    IO.inspect(game, label: "game params")
    # register_game
    case Games.register_game(game) do
      {:ok, game} ->
        game

        conn
        |> put_flash(:info, "game created successfully.")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end
end
