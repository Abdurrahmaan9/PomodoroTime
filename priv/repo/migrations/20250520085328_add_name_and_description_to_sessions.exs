defmodule Pomodoro.Repo.Migrations.AddNameAndDescriptionToSessions do
  use Ecto.Migration

  def change do
    alter table(:sessions) do
      add :name, :string
      add :description, :text
    end
  end
end
