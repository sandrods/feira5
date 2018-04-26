class AjustesController < ApplicationController
  before_action :set_ajuste, only: [:show, :edit, :update, :destroy]

  def index
    @search = Ajuste.search(params[:q])
    @ajustes = @search.result.order(:tipo)
    set_back_from(:ajuste_show)
  end

  def show
    @itens =  @ajuste.itens
                    .includes(item: [:tamanho, :cor, produto: [:fornecedor, :colecao]])
                    .order('colecoes.id desc, produtos.ref, itens.tamanho_id')
  end

  def new
    @ajuste = Ajuste.new
  end

  def edit
  end

  def create
    @ajuste = Ajuste.new(ajuste_params)

    if @ajuste.save
      redirect_to ajustes_path, notice: 'Ajuste criado com sucesso.'
    else
      render action: 'new'
    end
  end

  def update
    if @ajuste.update(ajuste_params)
      redirect_to ajustes_path, notice: 'Ajuste atualizado com sucesso.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @ajuste.destroy
    redirect_to ajustes_path, notice: 'Ajuste apagado com sucesso.'
  end

  private
    def set_ajuste
      @ajuste = Ajuste.find(params[:id])
    end

    def ajuste_params
      params.require(:ajuste).permit(:tipo, :obs)
    end
end
