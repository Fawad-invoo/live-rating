defmodule LiveRatingWeb.RatingLive.Show do
  use Phoenix.Component
  use Phoenix.HTML

  def stars(assigns) do
    # IO.inspect assigns, label: "assigns from RatingLive.Show.star"
    stars =
      filled_stars(assigns.rating.rating)
      |> Enum.concat(unfilled_stars(assigns.rating.rating))
      |> Enum.join(" ")

    ~H"""
    <div>
      <h4>
        <%= @game.game_name %>:<br/>
        <%= raw stars %>
      </h4>
    </div>
    """
  end

  def filled_stars(stars) do
    List.duplicate("&#x2605;", stars)
  end

  def unfilled_stars(stars) do
    List.duplicate("&#x2606;", 5 - stars)
  end
end
