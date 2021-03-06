class RegistrosController < ApplicationController

  def index
    params[:q] = { data_gteq: 30.days.ago.to_date } unless params[:q]
    @search = Registro.order('data desc').search(params[:q])
  end

  def new
    @registro = Registro.new(cd: params[:cd])
    render layout: false
  end

  def create
    @registro = Registro.new registro_params
    if @registro.save
    else
      flash[:error] = "Não foi possível salvar registro: #{@registro.errors.full_messages}"
    end

    redirect_to financeiro_diario_path(mes: @registro.data)
  end

  def edit
    @registro = Registro.find params[:id]

    redirect_to edit_transferencia_path(@registro) and return if @registro.transferencia?

    render layout: false
  end

  def update
    @registro = Registro.find params[:id]

    if @registro.update registro_params
    else
      flash[:error] = "Não foi possível salvar registro: #{@registro.errors.full_messages}"
    end

    redirect_to financeiro_diario_path(mes: @registro.data)
  end

  def destroy
    @registro = Registro.find params[:id]

    @registro.destroy!

    redirect_to financeiro_diario_path(mes: @registro.data)
  end

  def duplicate
    @registro = Registro.find params[:id]

    new_reg = @registro.duplicate!

    redirect_to financeiro_diario_path(mes: new_reg.data)
  end

  private

   def registro_params
     params.require(:registro)
           .permit(:data, :valor, :conta_id, :forma_id, :descricao, :pago, :cd, :categoria_id, :colecao_id)
           .delocalize(data: :date, valor: :number)
   end

end
