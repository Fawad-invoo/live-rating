defmodule LiveRating.Account do
  import Ecto.Query, warn: false
  alias LiveRating.Repo

  alias LiveRating.Account.User

  def get_user_by_email(email) when is_binary(email) do
    Repo.get_by(User, email: email)
  end

  def register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def change_user_registration(%User{} = user, attrs \\ %{}) do
    User.registration_changeset(user, attrs, hash_password: false)
  end

  def get_all_users(nil) do
    Repo.all(User) |> update_users_map()
  end

  def get_all_users(sort_by) do
    query =
      from User,
        order_by: [desc: ^sort_by]

    Repo.all(query) |> update_users_map()
  end

  def update_users_map(users) do
    Enum.map(users, fn user ->
      %{
        email: user.email,
        id: user.id,
        password: user.password,
        ratings: user.ratings
      }
    end)
  end
end
