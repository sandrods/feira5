class SacolasController < ApplicationController
  before_action :set_sacola, only: [:show, :edit, :update, :destroy, :print]

  def index
    @search = Sacola.search(params[:q])
    @sacolas = @search.result.order('id desc')
  end

  def show
  end

  def new
    @sacola = Sacola.new
  end

  def edit
  end

  def create
    @sacola = Sacola.new(sacola_params)
    @sacola.tipo = 'C'

    if @sacola.save
      redirect_to @sacola, notice: 'Sacola criada com sucesso.'
    else
      render action: 'new'
    end
  end

  def update
    if @sacola.update(sacola_params)
      redirect_to @sacola, notice: 'Sacola atualizada com sucesso.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @sacola.destroy
    redirect_to sacolas_path, notice: 'Sacola apagada com sucesso.'
  end

  def print

    report = RomaneioReport.new(@sacola)

    send_data report.generate,
              filename: "romaneio_#{@sacola.id}.odt",
              disposition: 'attachment'

  end

  private
    def set_sacola
      @sacola = Sacola.find(params[:id])
    end

    def sacola_params
      params.require(:sacola).permit(:cliente_id)
    end
end
