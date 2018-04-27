class ColecoesController < ApplicationController
  before_action :set_colecao, only: [:show, :edit, :update, :destroy]

  def index
    @colecoes = Colecao.order(:descricao)
  end

  def show
    @resultado = Colecao::Resultado.new(@colecao)
  end

  def new
    @colecao = Colecao.new
  end

  def edit
  end

  def create
    @colecao = Colecao.new(colecao_params)

    if @colecao.save
      redirect_to colecoes_path, notice: 'Coleção criada com sucesso.'
    else
      render action: 'new'
    end
  end

  def update
    if @colecao.update(colecao_params)
      redirect_to colecoes_path, notice: 'Coleção atualizada com sucesso.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @colecao.destroy
    redirect_to colecoes_path, notice: 'Coleção apagada com sucesso.'
  end

  private
    def set_colecao
      @colecao = Colecao.find(params[:id])
    end

    def colecao_params
      params.require(:colecao).permit(:descricao)
    end
end
