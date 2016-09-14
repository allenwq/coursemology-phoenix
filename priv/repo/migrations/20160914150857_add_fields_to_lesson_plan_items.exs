defmodule Coursemology.Repo.Migrations.AddFieldsToLessonPlanItems do
  use Ecto.Migration
  import Ecto.Query

  alias Coursemology.Repo
  def change do
    alter table(:course_lesson_plan_items) do
      add :event_id, references(:course_lesson_plan_events)
      add :assessment_id, references(:course_assessments)
    end

    flush

    from(p in Coursemology.LessonPlanItem, where: p.actable_type == "Course::LessonPlan::Event", update: [set: [event_id: p.actable_id]])
    |> Repo.update_all([])

    from(p in Coursemology.LessonPlanItem, where: p.actable_type == "Course::Assessment", update: [set: [assessment_id: p.actable_id]])
    |> Repo.update_all([])
  end
end
