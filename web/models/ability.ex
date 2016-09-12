defmodule Coursemology.Ability do
  defstruct role: nil, instance_role: nil, course_role: nil
end

alias Coursemology.Ability

# enum role: { normal: 0, administrator: 1, auto_grader: 2 }
defimpl Canada.Can, for: Ability do
  def can?(%Ability{role: 1}, action, _)
    when action in [:update, :read, :delete], do: true

  def can?(_, action, _) do
    false
  end
end
