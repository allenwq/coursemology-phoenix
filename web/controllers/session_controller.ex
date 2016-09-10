defmodule Coursemology.SessionController do
  use Coursemology.Web, :controller

  alias Coursemology.Auth

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Auth.login(conn, email, password, repo: Repo) do
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

  def delete(conn, _) do
    conn |> Auth.logout() |> redirect(to: page_path(conn, :index))
  end
end
