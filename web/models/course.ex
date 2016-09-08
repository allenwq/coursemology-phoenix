defmodule Coursemology.Course do
  use Coursemology.Web, :model

  schema "courses" do
    field :title, :string
    field :description, :string
    field :status, :integer
    field :registration_key, :string
    field :start_at, Ecto.DateTime
    field :end_at, Ecto.DateTime
    timestamps inserted_at: :created_at

    has_many(:course_users, Coursemology.CourseUser)
    has_many(:announcements, Coursemology.Announcement)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :status, :registration_key, :start_at, :end_at])
    |> validate_required([:title, :description, :status, :start_at])
  end
end
