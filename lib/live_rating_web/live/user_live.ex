defmodule LiveRatingWeb.UserLive do
  # use Phoenix.LiveView
  use LiveRatingWeb, :live_view
  alias LiveRating.Account
  alias LiveRatingWeb.RatingLive.RatingComponent
  alias LiveRating.Survey

  def mount(_params, _session, socket) do
    users = Account.get_all_users(nil)

    {
      :ok,
      socket |> assign(users: users, user_id: nil, state: "close")
    }
  end

  def render(assigns) do
    ~H"""
    <table>
    <%= live_patch "sort", to: Routes.live_path(@socket, LiveRatingWeb.UserLive, %{sort_by: :email}) %>
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

  def handle_params(params, _uri, socket) do
    IO.inspect(params["sort_by"], label: "sort")

    sort_by =
      case params["sort_by"] do
        sort_by when sort_by in ~w(email id) -> String.to_atom(sort_by)
        _ -> nil
      end

    users = Account.get_all_users(sort_by)
    {:noreply, socket |> assign(users: users)}
  end

  def handle_event("close", _, socket) do
    {:noreply, assign(socket, :state, "close")}
  end

  def handle_event("open", %{"id" => id, "email" => email}, socket) do
    games = Survey.get_all_ratings(id)
    {:noreply, socket |> assign(user_id: id, email: email, games: games, state: "open")}
  end

  def handle_info({:get_rating, updated_rating}, socket) do
    {:noreply, socket |> assign(games: updated_rating)}
  end

  def load_users(socket) do
  end
end
