defmodule ErrorTracker.Web.Helpers do
  @moduledoc false

  @doc false
  def sanitize_module(<<"Elixir.", str::binary>>), do: str
  def sanitize_module(str), do: str

  @doc false
  def format_datetime(%DateTime{} = dt), do: Calendar.strftime(dt, "%c %Z")

  @doc false
  def format_relative_datetime(%DateTime{} = dt) do
    diff = DateTime.diff(DateTime.utc_now(), dt, :second)

    cond do
      diff < 60 -> "just now"
      diff < 120 -> "1 minute ago"
      diff < 3600 -> "#{div(diff, 60)} minutes ago"
      diff < 7200 -> "1 hour ago"
      diff < 86_400 -> "#{div(diff, 3600)} hours ago"
      diff < 172_800 -> "1 day ago"
      diff < 2_592_000 -> "#{div(diff, 86_400)} days ago"
      diff < 5_184_000 -> "1 month ago"
      diff < 31_536_000 -> "#{div(diff, 2_592_000)} months ago"
      diff < 63_072_000 -> "1 year ago"
      true -> "#{div(diff, 31_536_000)} years ago"
    end
  end

  def format_relative_datetime(nil), do: "-"
end
