defmodule Coursemology.CourseUser do
  use Coursemology.Web, :model

  schema "course_users" do
    belongs_to(:course, Coursemology.Course)
    belongs_to(:user, Coursemology.User)
    field :role, :integer
    field :name, :string
    field :phantom, :boolean
  end
end
