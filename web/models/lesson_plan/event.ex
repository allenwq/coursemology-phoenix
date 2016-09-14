defmodule Coursemology.LessonPlanEvent do
  use Coursemology.Web, :model

  schema "course_lesson_plan_events" do
    field :location, :string
    field :event_type, :integer
  end

  def for_item(item) do
    Coursemology.Repo.get!(Coursemology.LessonPlanEvent, item.actable_id)
  end
end
