defmodule PomodoroWeb.ThemeLive do
  use PomodoroWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:theme, "bg-sky-950") # default (Tomorrow Night Blue)

    {:ok, socket}
  end


  def on_mount(:load_theme, _params, session, socket) do
    theme = Map.get(session, "theme", :theme) # default theme
    {:cont, assign(socket, :theme, theme)}
  end
end
