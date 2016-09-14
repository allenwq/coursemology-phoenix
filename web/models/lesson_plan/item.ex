defmodule Coursemology.LessonPlanItem do
  use Coursemology.Web, :model

  schema "course_lesson_plan_items" do
    field :actable_id, :integer
    field :actable_type, :string
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

  def specific(item) do
    case item.actable_type do
      "Course::LessonPlan::Event" ->
        Coursemology.LessonPlanEvent.for_item(item)
      "Course::Assessment" ->
        Coursemology.Assessment.for_item(item)
    end
  end
end
