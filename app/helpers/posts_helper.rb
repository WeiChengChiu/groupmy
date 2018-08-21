module PostsHelper
  # format
  def render_post_updated_at(post)
    post.updated_at.to_s(:long)
  end

  def render_post_created_at(post)
    post.created_at.to_s(:long)
  end

  # buttons
  def render_post_show_button_of_group(group, post)
    link_to(post.content, group_post_path(group, post), class: "btn btn-mini")
  end

  def rende_new_post_button_of_group(group)
    if current_user
      link_to("New Post", new_group_post_path(@group), class: "btn btn-mini btn-primary")
    end
  end

  def render_post_management_button_of_group(group, post)
    if current_user && post.editable_by?(current_user)
      link_to("Edit", edit_group_post_path(post.group, post), class: "btn btn-mini") + " / " +
      link_to("Delete", group_post_path(post.group, post), method: :delete, data: { confirm: "Are you sure?" })
    end
  end
end
