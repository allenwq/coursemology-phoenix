defmodule Coursemology.LoadAbility do
  import Plug.Conn

  alias Coursemology.Ability

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    conn
    |> load_ability()
  end

  defp load_ability(conn) do
    user = conn.assigns.current_user
    ability = %Ability{role: user && user.role}
    assign(conn, :current_ability, ability)
  end
end
