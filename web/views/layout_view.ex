defmodule Coursemology.LayoutView do
  use Coursemology.Web, :view

  def current_course(conn) do
    conn.assigns[:course]
  end

  def current_course_user(conn) do
    conn.assigns[:course_user]
  end

  def course_layout?(conn) do
    controller = controller_module(conn)
    if controller in [Coursemology.SessionController, Coursemology.PageController] do
      false
    else
      !(controller == Coursemology.CourseController && action_name(conn) == :index)
    end
  end
end
