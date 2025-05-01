# Pomodoro Timer

this a basic Pomodoro Timer built with Elixir/Phoenix, take a look at the current feature and future plans and feel free to suggest/ Contribute to the development 😁🥲.

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:5000`](http://localhost:5000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

# PomodoroTimer
Status of the current application and future plans for the application

# Current Features
  <!-- Current Feature: -->
    * stating a 25 minute work session
    * 5 Minute Break After the 25 Minuter work session
    * Pausing of a session
    * Resuming of a paused session/break
    * Browser notifications
    * Database to store the completed session/breaks with the start_time/end_time and task_type(work or break)
    * Implement browser notifications for session completion (requires JavaScript in LiveView).

# Future Feature Consideration
  <!-- Future Feature Consideration: -->
    * custom task names
    * adding user accounts using mix phx.gen.auth to associate sessions with users.
    * User management to ensure storing the user session data
    * adding dashboard with statistics (e.g., total work time) using Ecto queries.
