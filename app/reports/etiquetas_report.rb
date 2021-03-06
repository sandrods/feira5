require 'barby/barcode/code_25_interleaved'
require 'barby/outputter/prawn_outputter'
require "prawn/measurement_extensions"

class EtiquetasReport

  ROWS = 11
  COLS = 3

  attr_accessor :offset, :show_price

  def initialize(data)
    @pages = data.in_groups_of(ROWS * COLS, false)
    @pages = @pages.map { |p| p.in_groups_of(COLS, false) }
    @show_price = true
  end

  def render
    @pdf = Prawn::Document.new page_size: 'A4',
                               left_margin: 8.mm,
                               right_margin: 7.mm,
                               top_margin: 9.mm,
                               bottom_margin: 9.mm

    @pdf.define_grid(columns: COLS, rows: ROWS, column_gutter: 3.mm, row_gutter: 0)
    # @pdf.grid.show_all

    @pages.each_with_index do |page, i|
      @pdf.start_new_page unless i==0
      render_page page
    end

    @pdf.render

  end

  def render_page(linhas)

    o = offset ? ROWS - linhas.size : 0

    linhas.each_with_index do |linha, x|

      linha.each_with_index do |etiqueta, y|

        @pdf.grid(x + o, y).bounding_box do

          bc = Barby::Code25Interleaved.new(etiqueta.barcode)
          out = Barby::PrawnOutputter.new(bc)

          out.annotate_pdf(@pdf, x:8, y: 22, height: 30, xdim: 0.9)

          @pdf.draw_text etiqueta.descricao_short, size: 9, at: [10, 58]

          @pdf.draw_text etiqueta.barcode, size: 9, at: [25, 12]

          @pdf.draw_text etiqueta.fornecedor.nome, size: 9, at: [105, 43]
          @pdf.draw_text etiqueta.sub1, size: 8, at: [105, 33]

          if @show_price
            @pdf.draw_text etiqueta.valor, size: 12, style: :bold, at: [105, 12]
          end

        end

      end

    end
  end

end
