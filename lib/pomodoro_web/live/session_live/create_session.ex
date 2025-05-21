defmodule PomodoroWeb.SessionLive.CreateSession do
  use PomodoroWeb, :live_view
  alias Pomodoro.Sessions

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "Create Custom Session")
      |> assign(:session, %Sessions.Session{})
      |> assign(:changeset, Sessions.change_session(%Sessions.Session{}))
    {:ok, socket}
  end
  # TODO make this module start working correctly together with the main module
  @impl true
  def handle_event("save", %{"session" => session_params}, socket) do
    case Sessions.create_session(session_params) do
      {:ok, session} ->
        {:noreply,
         socket
         |> put_flash(:info, "Session created successfully")
         |> push_redirect(to: ~p"/sessions")}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="container mx-auto p-4">
      <h1 class="text-2xl font-bold mb-4">Create Custom Session</h1>

      <.form for={@changeset} id="create-session-form" phx-submit="save">
          <div class="mb-4">
            <%= @form.label :name, "Session Name", class: "block text-sm font-medium text-gray-700" %>
            <%= @form.text_input :name, class: "mt-1 block w-full border-gray-300 rounded-md shadow-sm" %>
            <%= @form.error_tag :name %>
          </div>

          <div class="mb-4">
            <%= @form.label :description, "Description", class: "block text-sm font-medium text-gray-700" %>
            <%= @form.textarea :description, class: "mt-1 block w-full border-gray-300 rounded-md shadow-sm" %>
            <%= @form.error_tag :description %>
          </div>

          <div class="mb-4">
            <%= @form.label :type, "Session Type", class: "block text-sm font-medium text-gray-700" %>
            <%= @form.select :type, ["work", "break"], class: "mt-1 block w-full border-gray-300 rounded-md shadow-sm" %>
            <%= @form.error_tag :type %>
          </div>

          <div class="mb-4">
            <%= @form.label :duration, "Duration (seconds)", class: "block text-sm font-medium text-gray-700" %>
            <%= @form.number_input :duration, class: "mt-1 block w-full border-gray-300 rounded-md shadow-sm" %>
            <%= @form.error_tag :duration %>
          </div>

          <div class="space-x-4">
            <%= @form.submit "Create Session", class: "bg-green-500 text-white px-4 py-2 rounded" %>
          <%= live_redirect "Cancel", to: ~p"/sessions", class: "bg-gray-500 text-white px-4 py-2 rounded" %>
        </div>
      </.form>
    </div>
    """
  end
end
