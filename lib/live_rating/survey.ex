defmodule LiveRating.Survey do
    @moduledoc """
    The Catalog context.
    """
  
    import Ecto.Query, warn: false
    alias LiveRating.Repo
    alias LiveRating.Survey.Rating
    alias LiveRating.Games.Game
  
    def change_rating(rating, attrs \\ %{}) do
      Rating.changeset(rating, attrs)
    end
  
    def create_update_rating(%{"game_id" => game_id,"user_id" => user_id} = rating_params) do
  
        query = from(
            r in Rating, 
            where: r.user_id == ^user_id,
            where: r.game_id == ^game_id
            )
        ratings=Repo.all(query)
        IO.inspect(ratings)
        add_rating(ratings,rating_params)

    end

    def add_rating([],%{"game_id" => game_id, "rating" => rating, "user_id" => user_id} = _rating_params) do
  
        %Rating{}
        |> Rating.changeset(%{game_id: game_id, rating: rating, user_id: user_id})
        |> Repo.insert()
      end

    def add_rating(_,%{"game_id" => game_id, "rating" => rating, "user_id" => user_id}) do
        from(r in Rating, where: r.user_id == ^user_id and r.game_id == ^game_id)
        |> Repo.update_all(set: [rating: rating])
    end

    def get_all_ratings(id) do
        query = from(r in Rating, where: r.user_id == ^id)
        Game
        |> Repo.all()
        |> Repo.preload([ratings: query])
    end
  end
  