defmodule Coursemology.LessonPlanItem do
  use Coursemology.Web, :model

  schema "course_lesson_plan_items" do
    belongs_to(:course, Coursemology.Course)
    field :title, :string
    field :description, :string
    field :draft, :boolean
    field :base_exp, :integer
    field :time_bonus_exp, :integer
    field :extra_bonus_exp, :integer
    field :start_at, Ecto.DateTime
    field :end_at, Ecto.DateTime
    field :bonus_end_at, Ecto.DateTime
    belongs_to(:creator, Coursemology.User)
    belongs_to(:updater, Coursemology.User)
    timestamps inserted_at: :created_at
  end
end
