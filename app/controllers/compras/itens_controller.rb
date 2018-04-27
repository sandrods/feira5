class Compras::ItensController < ApplicationController
  include BelongsToCompra

  def create
    @item = @compra.adiciona_item!(params[:barcode])
  end

  def destroy
    @compra.itens.find(params[:id]).destroy!
  end

end
