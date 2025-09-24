require "test_helper"

class HeavyMarkdownEditorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get heavy_markdown_editor_url
    assert_response :success
  end
end
