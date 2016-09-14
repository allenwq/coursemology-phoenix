defmodule Coursemology.AssessmentTab do
  use Coursemology.Web, :model

  schema "course_assessment_tabs" do
    belongs_to(:category, Coursemology.AssessmentCategory)
    field :title, :string
  end
end
