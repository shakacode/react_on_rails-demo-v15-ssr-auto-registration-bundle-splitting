class HeavyMarkdownEditorController < ApplicationController
  def index
    # In a real application, this would come from a database:
    # @article = Article.find(params[:id] || 1)
    # @heavy_markdown_editor_props = {
    #   initialText: @article.content,
    #   title: @article.title,
    #   author: @article.author.name,
    #   lastModified: @article.updated_at
    # }

    @heavy_markdown_editor_props = {
      initialText: load_demo_content,
      title: "React on Rails Demo Article",
      author: "Demo System",
      lastModified: Time.current
    }
  end

  private

  def load_demo_content
    # Simulate loading from database by reading from file
    # In production, this would be: Article.find(id).content
    content_file = File.join(__dir__, "heavy_markdown_editor_content.md")
    File.read(content_file)
  rescue Errno::ENOENT => e
    Rails.logger.warn "Demo content file not found: #{e.message}"
    "# Demo content not available\n\nPlease check the content file exists."
  end
end
