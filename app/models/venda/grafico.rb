class Venda::Grafico

  attr_accessor :calendar

  delegate :year, to: :calendar

  def initialize(year = Date.today.year)
    @calendar = Calendar.new(year: year)
    @vendas = Venda.where(data: @calendar.range)
    @itens = ItemEstoque.vendidos.where(movimento_id: @vendas.pluck(:id))

    @itens_por_mes = @itens.to_a.group_by_month { |i| i.movimento.data }
  end

  def quantidade_por_mes
    all_months @itens_por_mes.map { |k, v| [k, v.count] }
  end

  def valor_por_mes
    all_months @itens_por_mes.map { |k, v| [k, v.sum(&:valor)] }
  end

  def last_year
    @last ||= Venda::Grafico.new @calendar.last_year
  end

  def all_months(serie)
    ret = {}
    hash = Hash[serie]
    (1..12).each do |mes|
      dt = Date.new(@calendar.year, mes, 1)
      dt_fmt = dt.strftime('%b %Y')
      ret[dt_fmt] = hash.fetch(dt, 0)
    end
    ret
  end

end
