class EstoqueController < ApplicationController

  def index

    if params[:q]
      params.delete(:q) if params[:q].values.all? { |v| v.blank? }
      session[:itens_q] = params[:q]
    else
      params[:q] = session[:itens_q] if session[:itens_q]
    end

    if params[:q]
      @search = Item.search(params[:q])
      @itens = @search
                .result
                .includes(:tamanho, :cor, produto: [:fornecedor, :colecao])
                .order('fornecedores.nome, produtos.ref, itens.tamanho_id')

      @produtos = @itens.group_by { |i| i.produto }
    else
      @search = Item.search
      @itens = Item.none
      @produtos = Item.none
    end
  end

end
