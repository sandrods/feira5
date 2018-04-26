class RomaneioReport

  def initialize(sacola)
    @sacola = sacola
  end

  def generate
    @report = ODFReport::Report.new(Rails.root.join('app', 'reports', 'romaneio.odt')) do |r|
      fill_report(r)
    end
    @report.generate
  end

  private

  def fill_report(r)
    r.add_field(:data_hora, Time.now.strftime("%d/%m/%Y %H:%M"))
    r.add_field(:cliente, @sacola.nome)

    r.add_table("T_ITENS", @sacola.itens.incluidos.includes(item: :produto).order('produtos.ref')) do |t|
      t.add_column(:codigo) { |i| i.barcode }
      t.add_column(:ref) { |i| i.produto.ref }
      t.add_column(:tam) { |i| i.tamanho.nome }
      t.add_column(:cor) { |i| i.cor.nome }
      t.add_column(:valor) { |i| curr(i.valor) }
    end

    r.add_field(:num, @sacola.itens.incluidos.count)
    r.add_field(:total, curr(@sacola.total))
  end

  def curr(valor)
    ActiveSupport::NumberHelper.number_to_currency(valor, unit: '')
  end

end
