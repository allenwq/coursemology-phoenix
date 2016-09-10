defmodule Coursemology.SessionController do
  use Coursemology.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Coursemology.Auth.login(conn, email, password, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: "/")
      {:error, _reason, conn} ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render("new.html")
    end
  end
end
