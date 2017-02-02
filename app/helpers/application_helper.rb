module ApplicationHelper

  def user_gem_display
    if current_user.role == "admin"
      image_tag("red-diamond.png", :size => "24x20")
    elsif current_user.role == "premium"
      image_tag("blue-diamond.png", :size => "24x20")
    else
      image_tag("black-diamond.png", :size => "24x20")
    end
  end
end
