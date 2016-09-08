defmodule Coursemology.AnnouncementControllerTest do
  use Coursemology.ConnCase

  alias Coursemology.Announcement
  @valid_attrs %{content: "some content", course_id: 42, creator_id: 42, end_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, start_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, sticky: true, title: "some content", updater_id: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, announcement_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing course announcements"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, announcement_path(conn, :new)
    assert html_response(conn, 200) =~ "New announcement"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, announcement_path(conn, :create), announcement: @valid_attrs
    assert redirected_to(conn) == announcement_path(conn, :index)
    assert Repo.get_by(Announcement, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, announcement_path(conn, :create), announcement: @invalid_attrs
    assert html_response(conn, 200) =~ "New announcement"
  end

  test "shows chosen resource", %{conn: conn} do
    announcement = Repo.insert! %Announcement{}
    conn = get conn, announcement_path(conn, :show, announcement)
    assert html_response(conn, 200) =~ "Show announcement"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, announcement_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    announcement = Repo.insert! %Announcement{}
    conn = get conn, announcement_path(conn, :edit, announcement)
    assert html_response(conn, 200) =~ "Edit announcement"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    announcement = Repo.insert! %Announcement{}
    conn = put conn, announcement_path(conn, :update, announcement), announcement: @valid_attrs
    assert redirected_to(conn) == announcement_path(conn, :show, announcement)
    assert Repo.get_by(Announcement, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    announcement = Repo.insert! %Announcement{}
    conn = put conn, announcement_path(conn, :update, announcement), announcement: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit announcement"
  end

  test "deletes chosen resource", %{conn: conn} do
    announcement = Repo.insert! %Announcement{}
    conn = delete conn, announcement_path(conn, :delete, announcement)
    assert redirected_to(conn) == announcement_path(conn, :index)
    refute Repo.get(Announcement, announcement.id)
  end
end
