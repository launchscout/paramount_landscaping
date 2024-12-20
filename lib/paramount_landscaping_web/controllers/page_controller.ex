defmodule ParamountLandscapingWeb.PageController do
  use ParamountLandscapingWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def whitesheet(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :whitesheet, layout: false)
  end

end
