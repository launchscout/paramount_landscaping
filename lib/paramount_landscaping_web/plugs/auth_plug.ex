defmodule ParamountLandscapingWeb.AuthPlug do
  import Plug.Conn
  import Phoenix.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    if user_id = get_session(conn, :user_id) do
      current_user = ParamountLandscaping.Accounts.get_user!(user_id)
      assign(conn, :current_user, current_user)
    else
      conn
      |> put_flash(:error, "You must be logged in to access this page")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
