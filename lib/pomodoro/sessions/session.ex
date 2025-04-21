defmodule Pomodoro.Sessions.Session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions" do
    field :type, :string
    field :start_time, :naive_datetime
    field :end_time, :naive_datetime
    field :duration, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:start_time, :end_time, :duration, :type])
    |> validate_required([:start_time, :end_time, :duration, :type])
  end
end
