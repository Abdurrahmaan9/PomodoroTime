defmodule Pomodoro.Repo do
  use Ecto.Repo,
    otp_app: :pomodoro,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
  
end
