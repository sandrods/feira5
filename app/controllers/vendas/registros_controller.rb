class Vendas::RegistrosController < ApplicationController
  include BelongsToVenda

  def create
    defaults = {
      descricao: "Venda #{@venda.id} - #{@venda.nome}",
      categoria_id: Categoria::VENDAS
    }
    parcelas = params[:parcelas].to_i

    if parcelas > 1
      args = registro_params.merge(defaults)

      args[:valor] = ((registro_params[:valor].to_f / parcelas) * 100).to_i.to_f / 100

      args[:data] = registro_params[:data].to_date

      parcelas.times do |i|
        args[:descricao] = defaults[:descricao] + " (#{i+1}/#{parcelas})"
        @registro = @venda.pagamentos.create! args
        args[:data] = args[:data].next_month
      end

    else
      @registro = @venda.pagamentos.create! registro_params.merge(defaults)
    end
  end

  def destroy
    @venda.pagamentos.find(params[:id]).destroy!
  end

 private

  def registro_params
    params.require(:registro)
          .permit(:data, :valor, :forma_id)
          .delocalize(data: :date, valor: :number)
  end

end
