class Compras::ItensController < ApplicationController
  include BelongsToCompra

  def create
    @item = @compra.adiciona_item!(params[:barcode])
  end

  def destroy
    @compra.itens.find(params[:id]).destroy!
  end

  def edit
    @item = @compra.itens.find(params[:id])
    render layout: false
  end

  def update
    @item = @compra.itens.find(params[:id])
    @item.update! item_params
  end

  private

  def item_params
    params.require(:item_estoque)
          .permit(:valor)
          .delocalize(valor: :number)
  end

end
