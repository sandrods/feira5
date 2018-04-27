class Ajustes::ItensController < ApplicationController

  before_action :set_ajuste

  def create
    @item = @ajuste.adiciona_item!(params[:barcode])
  end

  def destroy
    @ajuste.itens.find(params[:id]).destroy!
  end

 private

  def set_ajuste
    @ajuste = Ajuste.find(params[:ajuste_id]) if params[:ajuste_id]
  end

end
