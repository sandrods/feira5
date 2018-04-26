class CoresController < ApplicationController
  before_action :set_cor, only: [:show, :edit, :update, :destroy]

  def index
    @search = Cor.search(params[:q])
    @cores = @search.result.order(:nome)
  end

  def show
  end

  def new
    @cor = Cor.new
  end

  def edit
  end

  def create
    @cor = Cor.new(cor_params)

    if @cor.save
      redirect_to cores_path, notice: 'Cor was successfully created.'
    else
      render action: 'new'
    end

  end

  def update
    if @cor.update(cor_params)
      redirect_to cores_path, notice: 'Cor was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    if @cor.destroy
      redirect_to cores_path, notice: 'Cor apagada com sucesso.'
    else
      flash[:error] = "Não foi possível apagar esta Cor"
      render action: 'edit'
    end
  end

  private

    def set_cor
      @cor = Cor.find(params[:id])
    end

    def cor_params
      params.require(:cor).permit(:nome)
    end
end
