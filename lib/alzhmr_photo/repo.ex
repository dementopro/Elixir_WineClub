defmodule AlzhmrPhoto.Repo do
  use Ecto.Repo,
    otp_app: :alzhmr_photo,
    adapter: Ecto.Adapters.Postgres
end
