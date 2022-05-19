defmodule LiveRating.Repo do
  use Ecto.Repo,
    otp_app: :live_rating,
    adapter: Ecto.Adapters.Postgres
end
