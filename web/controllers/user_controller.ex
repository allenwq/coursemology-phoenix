defmodule Coursemology.UserController do
  use Coursemology.Web, :controller

  alias Coursemology.User

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end
end
