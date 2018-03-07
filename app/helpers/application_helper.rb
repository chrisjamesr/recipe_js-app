module ApplicationHelper

  def if_user_path
    if params[:user_id].present?
      tag("input", :type => "hidden", :name=> "user_id",:value => params[:user_id])
    end
  end

  def svg(name)
    file_path = "#{Rails.root}/app/assets/images/#{name}.svg"
    return File.read(file_path).html_safe if File.exists?(file_path)
    '(not found)'
  end

end
