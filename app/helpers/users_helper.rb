module UsersHelper
  def follow_toggle_button(user)
    if current_user.following? user
      link_to 'Unfollow', unfollow_user_path(user), class: 'btn btn-danger'
    else
      link_to 'Follow', follow_user_path(user), class: 'btn btn-success'
    end
  end

  def block_toggle_button(user)
    if current_user.blocked? user
      link_to 'Unblock', unblock_user_path(user), class: 'btn btn-success'
    else
      link_to 'Block', block_user_path(user), class: 'btn btn-danger'
    end
  end
end
