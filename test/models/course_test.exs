defmodule Coursemology.CourseTest do
  use Coursemology.ModelCase

  alias Coursemology.Course

  @valid_attrs %{description: "some content", end_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, registration_key: "some content", start_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, status: 42, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Course.changeset(%Course{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Course.changeset(%Course{}, @invalid_attrs)
    refute changeset.valid?
  end
end
