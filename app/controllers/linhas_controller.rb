# coding: UTF-8
class LinhasController < ApplicationController
  before_action :set_linha, only: [:show, :edit, :update, :destroy]

  def index
    @linhas = Linha.all.order(:descricao)
  end

  def show
  end

  def new
    @linha = Linha.new
  end

  def edit
  end

  def create
    @linha = Linha.new(linha_params)

    if @linha.save
      redirect_to linhas_path, notice: 'Linha criada com sucesso.'
    else
      render action: 'new'
    end
  end

  def update
    if @linha.update(linha_params)
      redirect_to linhas_path, notice: 'Linha atualizada com sucesso.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @linha.destroy
    redirect_to linhas_path, notice: 'Linha apagada com sucesso.'
  end

  private
    def set_linha
      @linha = Linha.find(params[:id])
    end

    def linha_params
      params.require(:linha).permit(:descricao)
    end
end
