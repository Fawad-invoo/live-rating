defmodule LiveRatingWeb.UserRegistrationLive.New do
  alias LiveRating.Account
  alias LiveRating.Account.User
  use LiveRatingWeb, :live_view

  def mount(_params, _session, socket) do
    changeset = Account.change_user_registration(%User{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns),
    do: Phoenix.View.render(LiveRatingWeb.UserRegistrationView, "index.html", assigns)
end
