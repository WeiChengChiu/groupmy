module GroupsHelper
  # format
  def render_group_description(group)
    simple_format(group.description)
  end

  def render_group_updated_at(group)
    group.updated_at.to_s(:long)
  end

  # truncate
  def render_group_title(group)
    truncate(group.try(:title), length: 15)
  end

  # buttons
  def render_group_button(group)
    link_to(render_group_title(group), group_path(group.id))
  end

  def render_group_new_button
    link_to("New group", new_group_path, class: "btn btn-mini btn-primary pull-right")
  end

  def render_group_edit_button(group)
    if current_user && group.editable_by?(current_user)
       link_to("Edit", edit_group_path(group))
    end
  end

  def render_group_management_button(group)
    if current_user && group.editable_by?(current_user)
       link_to("Edit", edit_group_path(group), class: "btn btn-mini") + " / " +
       link_to("Delete", group_path(group), class: "btn btn-mini", method: :delete, data: { confirm: "Are you sure?" })
    end
  end

  def render_group_join_or_quit_button(group)
    if current_user && current_user.is_member_of?(group)
       link_to("Quit Group", quit_group_path(group), method: :post, class: "btn btn-mini")
    elsif current_user
       link_to("Join Group", join_group_path(group), method: :post, class: "btn btm-mini")
    end
  end
end
