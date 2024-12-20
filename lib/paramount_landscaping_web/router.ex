defmodule ParamountLandscapingWeb.Router do
  use ParamountLandscapingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ParamountLandscapingWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :require_authenticated_user do
    plug ParamountLandscapingWeb.AuthPlug
  end

  scope "/", ParamountLandscapingWeb do
    pipe_through [:browser, :require_authenticated_user]
    live "/jobs", JobLive.Index, :index
    live "/jobs/new", JobLive.Index, :new
    live "/jobs/:id/edit", JobLive.Index, :edit

    live "/jobs/:id", JobLive.Show, :show
    live "/jobs/:id/show/edit", JobLive.Show, :edit
    live "/", JobLive.Index, :index
    get "/whitesheet", PageController, :whitesheet

    live "/line_items", LineItemLive.Index, :index
    live "/line_items/new", LineItemLive.Index, :new
    live "/line_items/:id/edit", LineItemLive.Index, :edit

    live "/line_items/:id", LineItemLive.Show, :show
    live "/line_items/:id/show/edit", LineItemLive.Show, :edit

    live "/labors", LaborLive.Index, :index
    live "/labors/new", LaborLive.Index, :new
    live "/labors/:id/edit", LaborLive.Index, :edit

    live "/labors/:id", LaborLive.Show, :show
    live "/labors/:id/show/edit", LaborLive.Show, :edit
  end

  scope "/auth", ParamountLandscapingWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    delete "/signout", AuthController, :signout
  end

  # Other scopes may use custom stacks.
  # scope "/api", ParamountLandscapingWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:paramount_landscaping, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ParamountLandscapingWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
