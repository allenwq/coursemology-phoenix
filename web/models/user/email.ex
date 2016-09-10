defmodule Coursemology.User.Email do
  use Coursemology.Web, :model

  schema "user_emails" do
    field :primary, :boolean
    field :email, :string
    field :confirmation_token, :string
    field :confirmed_at, Ecto.DateTime
    field :confirmation_sent_at, Ecto.DateTime
    field :unconfirmed_email, :string
    timestamps inserted_at: :created_at

    belongs_to(:user, Coursemology.User)
  end
end
