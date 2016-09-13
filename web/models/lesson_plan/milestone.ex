defmodule Coursemology.LessonPlanMilestone do
  use Coursemology.Web, :model

  schema "course_lesson_plan_milestones" do
    belongs_to(:course, Coursemology.Course)
    field :title, :string
    field :description, :string
    field :start_at, Ecto.DateTime
    belongs_to(:creator, Coursemology.User)
    belongs_to(:updater, Coursemology.User)
    timestamps inserted_at: :created_at
  end
end
