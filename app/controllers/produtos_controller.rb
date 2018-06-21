# coding: UTF-8
class ProdutosController < ApplicationController
  before_action :set_produto, only: [:show, :edit, :update, :destroy]

  def index

    if params[:q]
      params.delete(:q) if params[:q].values.all? { |v| v.blank? }
      session[:prod_q] = params[:q]
    else
      params[:q] = session[:prod_q] if session[:prod_q]
    end

    if params[:q]
      @search = Produto.search(params[:q])
      @produtos = @search.result.includes(:fornecedor).order('fornecedores.nome, ref')
    else
      @search = Produto.search
      @produtos = Produto.none
    end
  end

  def show
    set_back_from(:compra_show, :venda_show, :ajuste_show)
  end

  def new
    @produto = Produto.new

    if params[:like]
      like = Produto.find params[:like]
      @produto.colecao_id     = like.colecao_id
      @produto.fornecedor_id  = like.fornecedor_id
      @produto.linha_id       = like.linha_id
      @produto.tipo_id        = like.tipo_id
    end

  end

  def edit
  end

  def create
    @produto = Produto.new(produto_params)

    if @produto.save
      flash[:notice] = 'Produto criado com sucesso.'
      redirect_to @produto
    else
      render action: 'new'
    end
  end

  def update
    if @produto.update(produto_params)
      redirect_to produto_path(@produto), notice: 'Produto atualizado com sucesso.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @produto.destroy
    redirect_to produtos_path, notice: 'Produto apagado com sucesso.'
  end

  def lucro
    custo = params[:custo].gsub(',', '.').to_f
    valor = params[:valor].gsub(',', '.').to_f

    @lucro = Produto.lucro(valor, custo)
    @rentab = Produto.rentabilidade(valor, custo)

    render json: { lucro: view_context.number_to_currency(@lucro),
                   rentabilidade: view_context.number_to_percentage(@rentab) }
  end

  private

    def set_produto
      @produto = Produto.find(params[:id])
    end

    def produto_params
      params.require(:produto)
            .permit(:ref, :colecao_id, :tipo_id, :fornecedor_id, :linha_id, :custo, :valor)
            .delocalize(valor: :number, custo: :number)
    end
end
