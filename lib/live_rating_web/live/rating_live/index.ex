defmodule LiveRatingWeb.RatingLive.Index do
  use Phoenix.Component
  use Phoenix.HTML

  # alias LiveviewsApp.RatingLive

  def games(assigns) do
    ~H"""
    <div class="survey-component-container" >
      <.heading games={@games} />
      <.list games={@games} current_user={@current_user} />
    </div>
    """
  end

  def heading(assigns) do
    ~H"""
      <br>
      <h2>
        Ratings
        <%= if ratings_complete?(@games), do: raw "&#x2713;" %>
      </h2>
    """
  end

  def list(assigns) do
    ~H"""
    <%= if @games != [] do %>
    <%= for {game, index} <- Enum.with_index(@games) do %>
      <%= if rating = List.first(game.ratings) do %>
        <LiveRatingWeb.RatingLive.Show.stars rating={rating} game={game} />
      <% else %>
        <p> Rating not set for <%= game.game_name %> </p>
      <% end %>
    <% end %>
    <%= else %>
        <p> No Record Found</p>
    <%= end %>
    """
  end

  defp ratings_complete?(games) do
    Enum.all?(games, fn game ->
      length(game.ratings) == 1
    end)
  end
end
