defmodule LiveRatingWeb.UserRegistrationController do
  use LiveRatingWeb, :controller

  alias LiveRating.Account
  alias LiveRating.Account.User


  def new(conn, _params) do
    changeset = Account.change_user_registration(%User{})
    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    password = Map.get(user_params, "password", "")
    user_params = Map.put(user_params, "hashed_password", password)
    IO.inspect(user_params)

    case Account.register_user(user_params) do
      {:ok, user} ->
        user

        conn
        |> put_flash(:info, "User created successfully.")


      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end
end
