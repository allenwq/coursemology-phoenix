defmodule Coursemology.User do
  use Coursemology.Web, :model

  schema "users" do
    field :name, :string
    field :role, :integer
    field :time_zone, :string
    field :encrypted_password, :string
    timestamps inserted_at: :created_at

    has_many(:emails, Coursemology.User.Email)
    has_many(:course_users, Coursemology.CourseUser)
    has_many(:courses, through: [:course_users, :course])
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :role, :time_zone])
    |> validate_required([:name, :role])
  end
end
