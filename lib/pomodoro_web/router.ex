defmodule PomodoroWeb.Router do
  use PomodoroWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PomodoroWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PomodoroWeb do
    pipe_through :browser
    # live_session :user_theme, on_mount: [{PomodoroWeb.ThemeLive, :load_theme}] do

    live "/", SessionLive.Index, :index
    live "/sessions/new", SessionLive.FormComponent, :new
    live "/sessions/:id", SessionLive.Show, :show
    live "/sessions/:id/edit", SessionLive.FormComponent, :edit
    live "/sessions/:id/show/edit", SessionLive.Show, :edit
    # end
  end

  # Other scopes may use custom stacks.
  # scope "/api", PomodoroWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:pomodoro, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PomodoroWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
