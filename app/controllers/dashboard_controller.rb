class DashboardController < ApplicationController

  def index
    @vendas = Venda::Periodo.new(days: params[:days] || 7)

    set_back_from(:venda_show)
  end

end
