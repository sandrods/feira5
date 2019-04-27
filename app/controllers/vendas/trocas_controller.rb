class Vendas::TrocasController < ApplicationController
  include BelongsToVenda

  def create
    @item = @venda.adiciona_troca!(params[:barcode])
  end

  def destroy
    @venda.trocas.find(params[:id]).destroy!
  end

  def edit
    @item = @venda.trocas.find(params[:id])
    render layout: false
  end

  def update
    @item = @venda.trocas.find(params[:id])
    @item.set_valor item_params[:valor]
  end

  private

  def item_params
    params.require(:item_estoque)
          .permit(:desconto, :valor)
          .delocalize(desconto: :number, valor: :number)
  end

end
