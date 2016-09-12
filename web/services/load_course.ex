defmodule Coursemology.LoadCourse do
  import Plug.Conn
  use Coursemology.Web, :model

  alias Coursemology.Course
  alias Coursemology.Ability

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    course_id = conn.params["course_id"] || conn.params["id"]
    conn |> load_course(course_id) |> load_user_course() |> update_course_user_ability()
  end

  defp load_course(conn, course_id) do
    course_id = course_id || conn.params["course_id"]
    course = course_id && Coursemology.Repo.get!(Course, course_id)
    assign(conn, :course, course)
  end

  defp load_user_course(conn) do
    user = conn.assigns[:current_user]
    course = conn.assigns[:course]
    course_user = Coursemology.Repo.get_by(
      Coursemology.CourseUser, user_id: user.id, course_id: course.id
    )
    assign(conn, :course_user, course_user)
  end

  defp update_course_user_ability(conn) do
    ability = conn.assigns.current_ability
    course_user = conn.assigns.course_user
    ability = %Ability{ability | course_role: course_user && course_user.role}

    assign(conn, :current_ability, ability)
  end
end
