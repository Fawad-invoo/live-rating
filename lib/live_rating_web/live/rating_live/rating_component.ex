defmodule LiveRatingWeb.RatingLive.RatingComponent do
  use LiveRatingWeb, :live_component
  alias LiveRating.Games
  # Optionally also bring the HTML helpers
  # use Phoenix.HTML
  def render(assigns) do
    ~H"""
    <div class="rating">
    <p>Hello, <%= assigns.email %> Add Rating for game</p>
   
    <form action="#" phx-submit="add_rate" phx-value-user_id = {@user_id} >
      <select name="game_id">
      <%= for game <- @games do %>
        <option value= {game.id} ><%= game.game_name %></option>
        <% end %>
      </select>

      <select name="rating">
      <%= for rate <- @ratings do %>
        <option value= {rate} ><%= rate %></option>
      <%= end %>
      </select>


      <button type="submit">Add Rate</button>
    </form>

    </div>
    """
  end

  def update(assigns, socket) do
    ratings= [1,2,3,4,5]
    socket=socket
     |> assign(assigns)
     {:ok,
     socket
     |> assign(games: Games.get_all_games(), ratings: ratings)}
  end

  def handle_event("add_rate", params, socket) do
    IO.inspect(params, label: "add_rate_f")
    {:noreply, socket}
  end
end
