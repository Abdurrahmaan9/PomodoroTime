defmodule Pomodoro.Repo do
  use Ecto.Repo,
    otp_app: :pomodoro,
    adapter: Ecto.Adapters.Postgres
end
