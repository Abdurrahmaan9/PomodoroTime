defmodule PomodoroWeb.SessionLive.Index do
  use PomodoroWeb, :live_view
  alias Pomodoro.Sessions

  @work_duration 1 * 60  # 25 minutes in seconds
  @break_duration 1 * 60  # 5 minutes in seconds

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:time_left, @work_duration)
      |> assign(:state, :stopped)
      |> assign(:session_type, :work)
      |> assign(:sessions, Sessions.list_sessions())

    {:ok, socket}
  end

  @impl true
  def handle_event("start", _, socket) do
    case socket.assigns.state do
      state when state in [:stopped, :paused] ->
        {:ok, timer_ref} = :timer.send_interval(1000, self(), :tick)
        {:noreply, assign(socket, state: :running, timer_ref: timer_ref)}

      _ ->
        {:noreply, socket}
    end
  end

  def handle_event("pause", _, socket) do
    if socket.assigns.state == :running do
      :timer.cancel(socket.assigns.timer_ref)
      {:noreply, assign(socket, state: :paused, timer_ref: nil)}
    else
      {:noreply, socket}
    end
  end

  # Handle the resume event
  def handle_event("resume", _, socket) do
    if socket.assigns.state == :paused do
      {:ok, timer_ref} = :timer.send_interval(1000, self(), :tick)
      {:noreply, assign(socket, state: :running, timer_ref: timer_ref)}
    else
      {:noreply, socket}
    end
  end

  def handle_event("reset", _, socket) do
    if socket.assigns.state == :running do
      :timer.cancel(socket.assigns.timer_ref)
    end

    time_left = if socket.assigns.session_type == :work, do: @work_duration, else: @break_duration
    {:noreply, assign(socket, state: :stopped, time_left: time_left, timer_ref: nil)}
  end

  @impl true
  def handle_info(:tick, socket) do
    time_left = max(socket.assigns.time_left - 1, 0)

    if time_left <= 0 do
      :timer.cancel(socket.assigns.timer_ref)

      # Save the session to the database
      duration = if socket.assigns.session_type == :work, do: @work_duration, else: @break_duration
      session_params = %{
        start_time: DateTime.utc_now() |> DateTime.add(-duration, :second),
        end_time: DateTime.utc_now(),
        duration: duration,
        type: to_string(socket.assigns.session_type)
      }

      {:ok, _session} = Sessions.create_session(session_params)

      # Switch between work and break
      new_type = if socket.assigns.session_type == :work, do: :break, else: :work
      new_duration = if new_type == :work, do: @work_duration, else: @break_duration

      socket =
        socket
        |> assign(:session_type, new_type)
        |> assign(:time_left, new_duration)
        |> assign(:state, :stopped)
        |> assign(:sessions, Sessions.list_sessions())

      {:noreply, socket}
    else
      {:noreply, assign(socket, time_left: time_left)}
    end
  end

  defp format_time(seconds) do
    minutes = div(round(18.0), 60)
    seconds = rem(seconds, 60)
    String.pad_leading(Integer.to_string(minutes), 2, "0") <> ":" <> String.pad_leading(Integer.to_string(seconds), 2, "0")
  end
end
