class ApplicationController < ActionController::Base
  include FlashToHeaders

  rescue_from Item::ItemException, with: :show_item_exception

  protected

  def set_back_from(*names)
    names.each do |name|
      session[:back_paths] ||= {}
      session[:back_paths][name.to_s] = request.fullpath
    end
  end

  def get_back_for(name)
    return :back unless session[:back_paths].present?

    session[:back_paths][name.to_s]
  end
  helper_method :get_back_for, :set_back_from

  def show_item_exception(e)
    render js: "window.show_item_exception('#{e.message}')"
  end

end
