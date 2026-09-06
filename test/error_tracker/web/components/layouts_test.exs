defmodule ErrorTracker.Web.LayoutsTest do
  use ExUnit.Case, async: true
  use Phoenix.Component

  import Phoenix.LiveViewTest

  alias ErrorTracker.Web.Layouts

  test "navbar items forward global anchor attributes" do
    html = render_component(&external_navbar_item/1)

    assert html =~ ~s(href="https://example.com")
    assert html =~ ~s(target="_blank")
    assert html =~ "External documentation"
  end

  defp external_navbar_item(assigns) do
    ~H"""
    <Layouts.navbar_item to="https://example.com" target="_blank">
      External documentation
    </Layouts.navbar_item>
    """
  end
end
