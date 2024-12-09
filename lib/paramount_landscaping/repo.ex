defmodule ParamountLandscaping.Repo do
  use Ecto.Repo,
    otp_app: :paramount_landscaping,
    adapter: Ecto.Adapters.Postgres
end
