module BelongsToCompra
  extend ActiveSupport::Concern

  included do
    before_action :load_compra
  end

  def load_compra
    @compra = Compra.find params[:compra_id] if params[:compra_id]
  end

end
