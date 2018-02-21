module ApplicationHelper

  def if_user_path
    if params[:user_id].present?
      tag("input", :type => "hidden", :name=> "user_id",:value => params[:user_id])
    end
  end

end
