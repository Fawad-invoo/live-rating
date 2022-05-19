# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LiveRating.Repo.insert!(%LiveRating.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias LiveRating.Account

# Account.register_user(%{"email" => "jack@gmail.com", "password" => "1234"})
