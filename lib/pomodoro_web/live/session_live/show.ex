defmodule PomodoroWeb.SessionLive.Show do
  use PomodoroWeb, :live_view
  alias Pomodoro.Sessions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    session = Sessions.get_session!(id)
    socket =
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:session, session)
    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    session = Sessions.get_session!(id)
    {:ok, _} = Sessions.delete_session(session)
    {:noreply,
     socket
     |> put_flash(:info, "Session deleted successfully")
     |> push_navigate(to: ~p"/")}
  end

  defp page_title(:show), do: "Show Session"
  defp page_title(:edit), do: "Edit Session"
end
