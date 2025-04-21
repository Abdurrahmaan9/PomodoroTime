defmodule Pomodoro.SessionsTest do
  use Pomodoro.DataCase

  alias Pomodoro.Sessions

  describe "sessions" do
    alias Pomodoro.Sessions.Session

    import Pomodoro.SessionsFixtures

    @invalid_attrs %{type: nil, start_time: nil, end_time: nil, duration: nil}

    test "list_sessions/0 returns all sessions" do
      session = session_fixture()
      assert Sessions.list_sessions() == [session]
    end

    test "get_session!/1 returns the session with given id" do
      session = session_fixture()
      assert Sessions.get_session!(session.id) == session
    end

    test "create_session/1 with valid data creates a session" do
      valid_attrs = %{type: "some type", start_time: ~N[2025-04-20 11:48:00], end_time: ~N[2025-04-20 11:48:00], duration: 42}

      assert {:ok, %Session{} = session} = Sessions.create_session(valid_attrs)
      assert session.type == "some type"
      assert session.start_time == ~N[2025-04-20 11:48:00]
      assert session.end_time == ~N[2025-04-20 11:48:00]
      assert session.duration == 42
    end

    test "create_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sessions.create_session(@invalid_attrs)
    end

    test "update_session/2 with valid data updates the session" do
      session = session_fixture()
      update_attrs = %{type: "some updated type", start_time: ~N[2025-04-21 11:48:00], end_time: ~N[2025-04-21 11:48:00], duration: 43}

      assert {:ok, %Session{} = session} = Sessions.update_session(session, update_attrs)
      assert session.type == "some updated type"
      assert session.start_time == ~N[2025-04-21 11:48:00]
      assert session.end_time == ~N[2025-04-21 11:48:00]
      assert session.duration == 43
    end

    test "update_session/2 with invalid data returns error changeset" do
      session = session_fixture()
      assert {:error, %Ecto.Changeset{}} = Sessions.update_session(session, @invalid_attrs)
      assert session == Sessions.get_session!(session.id)
    end

    test "delete_session/1 deletes the session" do
      session = session_fixture()
      assert {:ok, %Session{}} = Sessions.delete_session(session)
      assert_raise Ecto.NoResultsError, fn -> Sessions.get_session!(session.id) end
    end

    test "change_session/1 returns a session changeset" do
      session = session_fixture()
      assert %Ecto.Changeset{} = Sessions.change_session(session)
    end
  end
end
