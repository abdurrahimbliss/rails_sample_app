module ApplicationHelper

  def full_title(page_title)
    base_title = 'Welcome to Tutorial'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def list_memberships(user)
    @lists = current_user.lists
    @user_list_memberships = @user.list_memberships
    @memberships = Hash.new(false)
    @lists.each do |list|
      @user_list_memberships.each do |membership|
        if list.id == membership.list_id
          @memberships[list.id] = membership.id
          break
        end
      end
    end

  end

end
