module ApplicationHelper
  def follow_unfollow_button(user)
    if current_user.following? user
      link_to 'Unfollow', unfollow_user_path(user), class: 'btn btn-danger'
    else
      link_to 'Follow', follow_user_path(user), class: 'btn btn-success'
    end
  end
end
