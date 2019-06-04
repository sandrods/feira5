class VendasController < ApplicationController
  before_action :set_venda, only: [:show, :edit, :update, :destroy]

  def index
    @search = Venda.search(params[:q])

    if params[:q] || params[:all]
      @vendas = @search.result.order('id desc')
    else
      @vendas = Venda.where('data > ?', 6.months.ago).order('id desc')
      redirect_to vendas_path(all: true) if @vendas.blank?
    end

    set_back_from(:venda_show)
  end

  def show
  end

  def new
    @venda = Venda.new
    @venda.data = Date.today
  end

  def edit
  end

  def create

    from_sacola and return if params[:sacola_id]

    @venda = Venda.new(venda_params)

    if @venda.save
      redirect_to @venda, notice: 'Venda criada com sucesso.'
    else
      render action: 'new'
    end

  end

  def update
    if @venda.update(venda_params)
      redirect_to @venda, notice: 'Venda atualizada com sucesso.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @venda.destroy
    redirect_to vendas_path, notice: 'Venda apagada com sucesso.'
  end

  def mensal
    @vendas = Venda::Periodo.new date: params[:mes]
    @graf = Venda::Grafico.new
  end

  private
    def set_venda
      @venda = Venda.find(params[:id])
    end

    def venda_params
      params.require(:venda)
            .permit(:cliente_id, :desconto, :data, :tipo, :obs)
    end

    def from_sacola
      @venda = Venda.from_sacola(params[:sacola_id])
      redirect_to @venda, notice: 'Venda criada com sucesso.'
    end

end
