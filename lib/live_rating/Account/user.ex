defmodule LiveRating.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string
    field :hashed_password, :string

    has_many :ratings, LiveRating.Survey.Rating

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :hashed_password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
  end

  def registration_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:email, :password, :hashed_password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)

    # |> encrypt_and_put_password()
  end

  def encrypt_and_put_password(user) do
    with password <- fetch_field!(user, :password) do
      encrypt_password = Bcrypt.hash_pwd_salt(password)
      put_change(user, :hashed_password, encrypt_password)
    end
  end
end
