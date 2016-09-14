defmodule Coursemology.LessonPlanItemController do
  use Coursemology.Web, :controller

  alias Coursemology.LessonPlanItem
  alias Coursemology.LessonPlanMilestone

  def index(conn, _params) do
    course = conn.assigns[:course]
    |> Coursemology.Repo.preload([lesson_plan_items: (from l in LessonPlanItem, order_by: l.start_at), lesson_plan_items: [assessment: [tab: :category]], lesson_plan_items: :event])
    |> Coursemology.Repo.preload(lesson_plan_milestones: (from m in LessonPlanMilestone, order_by: m.start_at))

    milestone_with_items = grouped_item_and_milestone(course.lesson_plan_items, course.lesson_plan_milestones)
    render(conn, "index.html", milestones: milestone_with_items)
  end

  defp grouped_item_and_milestone(items, milestones) do
    milestone_list = [List.first(milestones)]
    milestone_list = Enum.reduce milestones, milestone_list, fn m, milestone_list ->
      current = List.first(milestone_list)
      items_of_milestone = Enum.filter(items, fn(i) -> i.start_at >= current.start_at && i.start_at < m.start_at end)
      milestone_list ++ [%{milestone: m, items: items_of_milestone}]
      |> List.replace_at(0, m)
    end
    # Delete current milestone
    List.delete_at(milestone_list, 0)
  end
end
