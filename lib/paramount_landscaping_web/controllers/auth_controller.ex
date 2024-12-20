defmodule ParamountLandscapingWeb.AuthController do
  use ParamountLandscapingWeb, :controller
  plug Ueberauth

  alias ParamountLandscaping.Accounts
  alias ParamountLandscaping.Repo

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{
      token: auth.credentials.token,
      email: auth.info.email,
      name: auth.info.name,
      provider: "google"
    }

    changeset = Accounts.User.changeset(%Accounts.User{}, user_params)

    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: ~p"/")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: ~p"/")
    end
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: ~p"/")
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(Accounts.User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end
end
