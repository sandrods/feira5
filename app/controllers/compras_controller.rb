class ComprasController < ApplicationController
  before_action :set_compra, only: [:show, :edit, :update, :destroy]

  def index
    @search = Compra.search(params[:q])
    @compras = @search.result.order('id desc')
    set_back_from(:compra_show)
  end

  def show
  end

  def new
    @compra = Compra.new
  end

  def edit
  end

  def create
    @compra = Compra.new(compra_params)

    if @compra.save
      redirect_to @compra, notice: 'Compra criada com sucesso.'
    else
      render action: 'new'
    end
  end

  def update
    if @compra.update(compra_params)
      redirect_to @compra, notice: 'Compra atualizada com sucesso.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @compra.destroy
    redirect_to compras_path, notice: 'Compra apagada com sucesso.'
  end

  private
    def set_compra
      @compra = Compra.find(params[:id])
    end

    def compra_params
      params.require(:compra).permit(:fornecedor_id, :data, :desconto, :colecao_id)
    end
end
