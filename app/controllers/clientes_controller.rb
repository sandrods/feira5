# coding: UTF-8
class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy, :arquivar]

  def index
    params[:q] = { arquivado_eq: false } unless params[:q]

    if params[:letra]
      @search = Cliente.search(params[:q])
      @clientes = @search.result.por_letra(params[:letra]).order(:nome)
    else
      @search = Cliente.search(params[:q])
      @clientes = @search.result.order(:nome)
    end
    set_back_from(:cliente_show)
  end

  def show
    set_back_from(:venda_show)
  end

  def new
    @cliente = Cliente.new
  end

  def edit
  end

  def create
    @cliente = Cliente.new(cliente_params)

    if @cliente.save
      redirect_to @cliente, notice: 'Cliente criado com sucesso.'
    else
      render action: 'new'
    end
  end

  def update
    if @cliente.update(cliente_params)
      redirect_to @cliente, notice: 'Cliente atualizado com sucesso.'
    else
      render action: 'edit'
    end
  end

  def destroy
    if @cliente.destroy
      redirect_to clientes_path, notice: 'Cliente apagado com sucesso.'
    else
      flash[:error] = "Não foi possível apagar este cliente"
      render action: 'edit'
    end
  end

  def arquivar
    @cliente.arquivar! params[:desarquivar].blank?
    notice = params[:desarquivar].blank? ? "Arquivada" : "Desarquivada"
    redirect_to clientes_path, notice: "#{@cliente.nome} <b>#{notice}</b> com sucesso."
  end

  private

  def set_cliente
    @cliente = Cliente.find(params[:id])
  end

  def cliente_params
    params.require(:cliente)
          .permit(:nome, :email, :fone_res, :fone_com, :fone_cel, :endereco, :bairro, :cep, :cidade, :uf, :obs, :aniversario)
  end

end
