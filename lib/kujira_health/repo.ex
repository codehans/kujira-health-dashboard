defmodule KujiraHealth.Repo do
  use Ecto.Repo,
    otp_app: :kujira_health,
    adapter: Ecto.Adapters.Postgres
end
