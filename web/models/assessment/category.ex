defmodule Coursemology.AssessmentCategory do
  use Coursemology.Web, :model

  schema "course_assessment_categories" do
    belongs_to(:course, Coursemology.Course)
    field :title, :string
  end
end
