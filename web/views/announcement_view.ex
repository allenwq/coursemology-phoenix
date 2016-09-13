defmodule Coursemology.AnnouncementView do
  use Coursemology.Web, :view

  def started?(record) do
    !record.start_at || record.start_at <= :os.system_time(:milli_seconds)
  end

  def currently_active?(record) do
    started?(record) && !ended?(record)
  end

  def ended?(record) do
    record.end_at && :os.system_time(:milli_seconds) > record.end_at
  end
end
