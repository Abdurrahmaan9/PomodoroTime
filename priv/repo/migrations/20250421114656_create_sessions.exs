defmodule Pomodoro.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime
      add :duration, :integer
      add :type, :string

      timestamps(type: :utc_datetime)
    end
  end
end
