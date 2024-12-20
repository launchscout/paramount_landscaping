defmodule ParamountLandscapingWeb.LiveAuth do
  import Phoenix.Component

  def on_mount(:default, _params, session, socket) do
    if user_id = session["user_id"] do
      user = ParamountLandscaping.Accounts.get_user!(user_id)
      {:cont, assign(socket, current_user: user)}
    else
      {:cont, assign(socket, current_user: nil)}
    end
  end
end
