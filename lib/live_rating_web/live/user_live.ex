defmodule LiveRatingWeb.UserLive do
  # use Phoenix.LiveView
  use LiveRatingWeb, :live_view
  alias LiveRating.Account
  alias LiveRatingWeb.RatingLive.RatingComponent
  alias LiveRating.Survey

  

  def mount(_params, _session, socket) do
    users = Account.get_all_users()

    {
      :ok,
      socket |> assign(users: users, user_id: nil, state: "close")
    }
  end

  def render(assigns) do
    ~H"""
    <table>
    <tbody id="users">
      <%= for user <- @users do %>
      <tr>    
        <td><%= user.id %></td>
        <td><%= user.email %></td>

        <td class="w-1/12 whitespace-no-wrap">
        <button phx-click="open" phx-value-id= {user.id} phx-value-email= {user.email} > show </button>
        <button phx-click="close" > close </button>
        </td>
      </tr>
      <% end %>
    </tbody>
    </table>
    <%= if @state=="open" do %>

    <.live_component module={RatingComponent} id="rating" user_id={@user_id} email= {@email}/>
    <section class="row">
    <h2>Survey</h2>

        <LiveRatingWeb.RatingLive.Index.games games={@games} current_user={@user_id} />
    </section>
    <%= end %>
    """
  end

  def handle_event("close", _, socket) do
    {:noreply, assign(socket, :state, "close")}
  end

  def handle_event("open", %{"id" => id,"email"=> email}, socket) do
    games=Survey.get_all_ratings(id)
    IO.inspect(games, label: "games")
    {:noreply, socket |> assign(user_id: id,email: email ,games: games, state: "open")}
  end

  def handle_event("add_rate", params, socket) do
    
    user_id = Map.get(socket.assigns, :user_id)
    params=Map.put(params,"user_id",user_id)
    IO.inspect(params, label: "add_rate")
    Survey.create_update_rating(params)
    games=Survey.get_all_ratings(user_id)
    {:noreply, socket |> assign(games: games)}
  end

end
