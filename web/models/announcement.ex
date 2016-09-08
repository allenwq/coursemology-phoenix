defmodule Coursemology.Announcement do
  use Coursemology.Web, :model

  schema "course_announcements" do
    field :course_id, :integer
    field :title, :string
    field :content, :string
    field :sticky, :boolean, default: false
    field :start_at, Ecto.DateTime
    field :end_at, Ecto.DateTime
    timestamps inserted_at: :created_at

    belongs_to(:creator, Coursemology.User)
    belongs_to(:updater, Coursemology.User)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:course_id, :title, :content, :sticky, :start_at, :end_at, :creator_id, :updater_id])
    |> validate_required([:course_id, :title, :content, :sticky, :start_at, :end_at, :creator_id, :updater_id])
  end
end
