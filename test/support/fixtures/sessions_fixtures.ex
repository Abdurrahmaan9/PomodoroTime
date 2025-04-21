defmodule Pomodoro.SessionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pomodoro.Sessions` context.
  """

  @doc """
  Generate a session.
  """
  def session_fixture(attrs \\ %{}) do
    {:ok, session} =
      attrs
      |> Enum.into(%{
        duration: 42,
        end_time: ~N[2025-04-20 11:48:00],
        start_time: ~N[2025-04-20 11:48:00],
        type: "some type"
      })
      |> Pomodoro.Sessions.create_session()

    session
  end
end
