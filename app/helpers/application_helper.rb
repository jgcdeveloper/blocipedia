module ApplicationHelper
  def user_gem_display
    if current_user.role == 'admin'
      image_tag('red-diamond.png', size: '24x20')
    elsif current_user.role == 'premium'
      image_tag('blue-diamond.png', size: '24x20')
    else
      image_tag('black-diamond.png', size: '24x20')
    end
  end

  def markdown(input)
    options = {
      filter_html:          true,
      hard_wrap:            true,
      fenced_code_blocks:   true,
      space_after_headers:  true,
    }

    extensions = {
      autolink:                       true,
      superscript:                    true,
      disable_indented_code_blocks:   true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(input).html_safe
  end
end
