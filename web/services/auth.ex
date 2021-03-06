defmodule Coursemology.Auth do
  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2 , dummy_checkpw: 0]

  use Coursemology.Web, :model
  alias Coursemology.User
  alias Coursemology.User.Email

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(User, user_id) |> repo.preload(:courses)
    assign(conn, :current_user, user)
  end

  def login(conn, email, password, opts) do
    repo = Keyword.fetch!(opts, :repo)
    email = String.downcase(email)
    user = repo.one(
      from u in User,
        join: e in Email, where: e.user_id == u.id and e.email == ^email
    )

    cond do
      user && checkpw(password, user.encrypted_password) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end
end
