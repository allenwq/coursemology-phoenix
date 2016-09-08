defmodule Coursemology.AnnouncementTest do
  use Coursemology.ModelCase

  alias Coursemology.Announcement

  @valid_attrs %{content: "some content", course_id: 42, creator_id: 42, end_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, start_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, sticky: true, title: "some content", updater_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Announcement.changeset(%Announcement{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Announcement.changeset(%Announcement{}, @invalid_attrs)
    refute changeset.valid?
  end
end
