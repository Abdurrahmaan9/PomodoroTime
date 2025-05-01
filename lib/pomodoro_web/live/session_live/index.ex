defmodule PomodoroWeb.SessionLive.Index do
  use PomodoroWeb, :live_view
  alias Pomodoro.Sessions

  @work_duration 25 * 60
  @break_duration 5 * 60

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:time_left, @work_duration)
      |> assign(:state, :stopped)
      |> assign(:session_type, :work)
      |> assign(:sessions, Sessions.list_sessions())
      |> assign(theme: "bg-sky-950")  # default (Tomorrow Night Blue)

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

  def handle_event("reset", _, socket) do
    if socket.assigns.state == :running do
      :timer.cancel(socket.assigns.timer_ref)
    end

    time_left = if socket.assigns.session_type == :work, do: @work_duration, else: @break_duration
    {:noreply, assign(socket, state: :stopped, time_left: time_left, timer_ref: nil)}
  end

  # setting the theme for the application
  @impl true
  def handle_event("set_theme", %{"theme" => theme} = _params, socket) do
    {:noreply, assign(socket, :theme, theme)}
  end

  @impl true
  def handle_info(:tick, socket) do
    time_left = socket.assigns.time_left - 1
    # Handling the browser notifications
    session_type = to_string(socket.assigns.session_type) |> String.capitalize()

    socket =
      # session notifications
      cond do
        time_left == 1499 ->
          push_event(socket, "notify", %{
            session_type: session_type,
            message: "#{session_type} Session Started!"
          })

        time_left == 299 ->
          push_event(socket, "notify", %{
            session_type: session_type,
            message: "#{session_type} Session Stated!"
          })

        time_left == 60 ->
          push_event(socket, "notify", %{
            session_type: session_type,
            message: "1 minute left!"
          })

        time_left <= 0 ->
          push_event(socket, "notify", %{
            session_type: session_type,
            message: "#{session_type} Session Complete!"
          })

        true ->
          socket
      end

    if time_left <= 0 do
      :timer.cancel(socket.assigns.timer_ref)

      session_params = %{
        start_time: NaiveDateTime.utc_now() |> NaiveDateTime.add(-if(socket.assigns.session_type == :work, do: @work_duration, else: @break_duration), :second),
        end_time: NaiveDateTime.utc_now(),
        duration: if(socket.assigns.session_type == :work, do: @work_duration, else: @break_duration),
        type: to_string(socket.assigns.session_type)
      }

      {:ok, _session} = Sessions.create_session(session_params)

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
    seconds = trunc(seconds)
    minutes = div(seconds, 60)
    seconds = rem(seconds, 60)
    String.pad_leading(Integer.to_string(minutes), 2, "0") <> ":" <> String.pad_leading(Integer.to_string(seconds), 2, "0")
  end
end
