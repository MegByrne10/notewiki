module WikiHelper
  def show_private_checkbox(wiki)
    if wiki.new_record?
      current_user.subscribed 
    else 
      wiki.user == current_user && current_user.subscribed
    end
  end

  def choose_collaborators(wiki)
    if wiki.new_record?
      current_user.subscribed
    else
      wiki.user == current_user && current_user.subscribed
    end
  end
end
