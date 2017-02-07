class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def admin_required
    if !current_user.admin?
      flash[:notice] = "您还不是管理员，没有该权限！"
      redirect_to "/"
    end
  end

  helper_method :current_cart

  def current_cart
    @current_cart ||= find_cart
  end

  private

  def find_cart
    cart = Cart.find_by(id: session[:card_id])
    if cart.blank?
      cart = Cart.create
    end
    session[:cart_id] = cart
    return cart
  end
end
