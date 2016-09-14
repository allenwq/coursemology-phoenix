defmodule Coursemology.Assessment do
  use Coursemology.Web, :model

  schema "course_assessments" do
    belongs_to(:tab, Coursemology.AssessmentTab)
    field :display_mode, :integer
    field :autograded, :boolean
    timestamps inserted_at: :created_at

    belongs_to(:creator, Coursemology.User)
    belongs_to(:updater, Coursemology.User)
  end

  def for_item(item) do
    assessment = Coursemology.Repo.get!(Coursemology.Assessment, item.actable_id)
    Coursemology.Repo.preload(assessment, [tab: :category])
  end
end
