defmodule ParamountLandscaping.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    field :name, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :provider, :token, :name])
    |> validate_required([:email, :provider])
    |> unique_constraint(:email)
  end
end
