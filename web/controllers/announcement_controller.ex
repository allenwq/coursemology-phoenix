defmodule Coursemology.AnnouncementController do
  use Coursemology.Web, :controller

  alias Coursemology.Announcement

  def index(conn, _params) do
    course = conn.assigns[:course]
    |> Coursemology.Repo.preload([announcements: (from a in Announcement, order_by: [desc: a.sticky, desc: a.start_at]), announcements: :creator])
    render(conn, "index.html", announcements: course.announcements)
  end

  def new(conn, _params) do
    changeset = Announcement.changeset(%Announcement{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"announcement" => announcement_params}) do
    changeset = Announcement.changeset(%Announcement{}, announcement_params)

    case Repo.insert(changeset) do
      {:ok, _announcement} ->
        conn
        |> put_flash(:info, "Announcement created successfully.")
        |> redirect(to: course_announcement_path(conn, :index, 2))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    announcement = Repo.get!(Announcement, id)
    render(conn, "show.html", announcement: announcement)
  end

  def edit(conn, %{"id" => id}) do
    announcement = Repo.get!(Announcement, id)
    changeset = Announcement.changeset(announcement)
    render(conn, "edit.html", announcement: announcement, changeset: changeset)
  end

  def update(conn, %{"id" => id, "announcement" => announcement_params}) do
    announcement = Repo.get!(Announcement, id)
    changeset = Announcement.changeset(announcement, announcement_params)

    case Repo.update(changeset) do
      {:ok, announcement} ->
        conn
        |> put_flash(:info, "Announcement updated successfully.")
        |> redirect(to: course_announcement_path(conn, :show, 2, announcement))
      {:error, changeset} ->
        render(conn, "edit.html", announcement: announcement, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    announcement = Repo.get!(Announcement, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(announcement)

    conn
    |> put_flash(:info, "Announcement deleted successfully.")
    |> redirect(to: course_announcement_path(conn, :index, 2))
  end
end
