class ItensSacolaController < ApplicationController
  before_action :set_sacola

  def create
    @item = @sacola.adiciona_item!(params[:barcode])
  end

  def destroy
    @sacola.itens.find(params[:id]).destroy!
  end

  def devolver
    @item = ItemSacola.devolve(params[:barcode_d], @sacola.id)
  end

 private

  def set_sacola
    @sacola = Sacola.find(params[:sacola_id]) if params[:sacola_id]
  end

end
