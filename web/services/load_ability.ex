defmodule Coursemology.LoadAbility do
  import Plug.Conn

  alias Coursemology.Ability

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    user = conn.assigns.current_user
    ability = %Ability{role: user && user.role}

    assign(conn, :current_ability, ability)
  end
end
