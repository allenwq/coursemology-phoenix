defmodule Coursemology.LessonPlanItemController do
  use Coursemology.Web, :controller

  alias Coursemology.LessonPlanItem
  alias Coursemology.LessonPlanMilestone

  def index(conn, _params) do
    course = conn.assigns[:course]
    |> Coursemology.Repo.preload(lesson_plan_items: (from l in LessonPlanItem, order_by: l.start_at))
    |> Coursemology.Repo.preload(lesson_plan_milestones: (from m in LessonPlanMilestone, order_by: m.start_at))

    milestone_with_items = grouped_item_and_milestone(course.lesson_plan_items, course.lesson_plan_milestones)
    render(conn, "index.html", milestones: milestone_with_items)
  end

  defp grouped_item_and_milestone(items, milestones) do
    ret = []
    ungrouped = []
    current_milestone = List.first(milestones)
    ret = for m <- milestones do
      IO.puts inspect(current_milestone)
      items_of_milestone = Enum.filter(items, fn(i) -> i.start_at >= current_milestone.start_at && i.start_at < m.start_at end)
      # ret = ret ++ [[milestone: current_milestone, items: items]]
      current_milestone = m
      items_of_milestone
    end
    ret
  end
end
