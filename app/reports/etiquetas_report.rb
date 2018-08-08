require 'barby/barcode/code_25_interleaved'
require 'barby/outputter/prawn_outputter'

class EtiquetasReport

  attr_accessor :offset, :show_price

  def initialize(data)
    @pages = data.in_groups_of(25, false)
    @pages = @pages.map { |p| p.in_groups_of(5, false) }
    @show_price = true
  end

  def render
    @pdf = Prawn::Document.new

    @pdf.define_grid(columns: 5, rows: 5, gutter: 1)
    #@pdf.grid.show_all

    @pages.each_with_index do |page, i|
      @pdf.start_new_page unless i==0
      render_page page
    end

    @pdf.render

  end

  def render_page(linhas)

    o = offset ? 5 - linhas.size : 0

    linhas.each_with_index do |linha, x|

      linha.each_with_index do |etiqueta, y|

        @pdf.grid(x + o, y).bounding_box do

          @pdf.move_down 34
          @pdf.text etiqueta.ref, align: :center, size: 8

          @pdf.move_down 0
          @pdf.text etiqueta.sub1, align: :center, size: 8

          @pdf.move_down 5

          # valor = @show_price ? etiqueta.valor : ' '
          # @pdf.text valor, align: :center, size: 11

          if @show_price
            @pdf.text etiqueta.valor, align: :center, size: 11
          else
            @pdf.move_down 12
          end

          bc = Barby::Code25Interleaved.new(etiqueta.barcode)
          out = Barby::PrawnOutputter.new(bc)

          out.annotate_pdf(@pdf, x:12, y: @pdf.cursor - 42, height: 35, xdim: 0.8)

          @pdf.move_down 43
          @pdf.text etiqueta.barcode, align: :center, size: 9

          @pdf.move_down 2
          if @show_price
            @pdf.text etiqueta.valor, align: :center, size: 8
          else
            @pdf.move_down 3
          end

          # @pdf.text valor, align: :center, size: 8

          @pdf.move_down -1
          @pdf.text etiqueta.sub2, align: :center, size: 7
        end

      end

    end
  end

end
