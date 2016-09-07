defmodule Coursemology.LayoutView do
  use Coursemology.Web, :view
  import Ecto.Query

  def current_user do
    # Myself, haha
    user = Coursemology.User
      |> Coursemology.Repo.get!(4710)
      |> Coursemology.Repo.preload(:courses)
  end

  def current_course(conn) do
    conn.assigns[:course]
  end

  def current_course_user(conn) do
    Coursemology.Repo.get_by(Coursemology.CourseUser, user_id: current_user.id, course_id: current_course(conn).id)
  end

  def course_layout?(conn) do
    !(controller_module(conn) == Elixir.Coursemology.CourseController && action_name(conn) == :index)
  end
end
