module BelongsToVenda
  extend ActiveSupport::Concern

  included do
    before_action :load_venda
  end

  def load_venda
    @venda = Venda.find params[:venda_id] if params[:venda_id]
  end

end
