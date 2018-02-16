module SessionHelper

  def if_flash(attribute)
    if flash.now[:alert].present?
     flash.now[:alert][attribute.to_sym]
    end
  end
end
      