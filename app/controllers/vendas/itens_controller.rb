class Vendas::ItensController < ApplicationController
  include BelongsToVenda

  def create
    @item = @venda.adiciona_item!(params[:barcode])
  end

  def destroy
    @venda.itens.find(params[:id]).destroy!
  end

  def edit
    @item = @venda.itens.find(params[:id])
    render layout: false
  end

  def update
    @item = @venda.itens.find(params[:id])

    if params[:commit] == 'Salvar Desconto'
      @item.set_desconto item_params[:desconto]
    else
      @item.set_valor item_params[:valor]
    end

  end

  private

  def item_params
    params.require(:item_estoque)
          .permit(:desconto, :valor)
          .delocalize(desconto: :number, valor: :number)
  end

end
