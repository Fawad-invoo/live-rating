defmodule LiveRating.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :game_name, :string

    has_many :ratings, LiveRating.Survey.Rating

    timestamps()
  end

  def changeset(game, attrs, _opts \\ []) do
    game
    |> cast(attrs, [:game_name])
    |> validate_required([:game_name])
  end

  def view_changeset(game, attrs, _opts \\ []) do
    game
    |> cast(attrs, [:game_name])
  end
end
