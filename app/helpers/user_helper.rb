module UserHelper

  def nested_route?
    request.parameters.keys.include?("user_id")
  end

  def current_user_path?
      request.original_fullpath == user_recipes_path(current_user)
  end

  def display_user_name
    if nested_route? && !current_user_path?
      @user = User.find_by(:id => request.parameters[:user_id]) 
      @user.name
    end
  end

  def method_or_error(method)
    if @user.try(:method).messages[method.to_sym].first
      method.to_sym
    end
  end


end
