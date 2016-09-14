defmodule Coursemology.LessonPlanItemView do
  use Coursemology.Web, :view

  def render_item(item) do
    case item.actable_type do
      "Course::LessonPlan::Event" ->
        event = Coursemology.LessonPlanEvent.for_item(item)
        render "_event.html", event: event, item: item
      "Course::Assessment" ->
        assessment = Coursemology.Assessment.for_item(item)
        Coursemology.Repo.preload(assessment, [tab: :category])
        render "_assessment.html", assessment: assessment, item: item
    end
  end

  def display_event_type(event) do
    case event.event_type do
      0 ->
        "Other"
      1 ->
        "Lecture"
      2 ->
        "Recitation"
      3 ->
        "Tutorial"
    end
  end
end
