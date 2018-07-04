class NavBarComponent
  include ViewComponent

  def render

    add_menu "Produtos", %w(produtos estoque cores tamanhos linhas tipos) do |m|
      m.link "Produtos", produtos_path
      m.link "Etiquetas", etiquetas_path
      m.link "Estoque", estoque_index_path
      m.divider
      m.link "Cores", cores_path
      m.link "Tamanhos", tamanhos_path
      m.link "Linhas", linhas_path
      m.link "Tipos", tipos_path
    end

    add_menu "Compras", %w(compras fornecedores colecoes) do |m|
      m.link "Compras", compras_path, /compras/
      m.link "Fornecedores", fornecedores_path, /fornecedores/
      m.link "Coleções", colecoes_path, /colecoes/
    end

    add_menu "Vendas", %w(vendas clientes sacolas) do |m|
      m.link "Vendas", vendas_path, /vendas.*(?<!mensal)$/
      m.divider
      m.link "Sacolas", sacolas_path, /sacolas/
      m.link "Clientes", clientes_path, /clientes/
      m.divider
      m.link "Vendas Mensais", mensal_vendas_path, /mensal/
    end

    add_menu "Financeiro", %w(financeiro) do |m|
      m.link "Diário", financeiro_diario_path
      m.link "Anual", financeiro_anual_path
      m.divider
      m.link "Contas", root_path
      m.link "Categorias", root_path
      m.link "Formas de Pagto", root_path
    end

    render_result
  end

  private

  def add_link(*args)
    add Link.render(view, *args)
  end

  def add_menu(*args, &block)
     add Menu.render(view, *args, &block)
  end

  Link = Struct.new(:text, :url, :pattern) do
    include ViewComponent

    def render
      cls = 'nav-item nav-link'

      if pattern.present? && pattern.any? { |p| request.path.starts_with? "/#{p}" }
        cls << ' active'
      end

      link_to(text, url, class: cls)
    end

  end

  Menu = Struct.new(:text, :pattern) do
    include ViewComponent

    def link(text, url, pattern = nil)
      @itens ||= []
      @itens << { text: text, url: url, pattern: pattern }
    end

    def divider
      @itens ||= []
      @itens << { divider: true }
    end

    def render
      @active = pattern.present? && pattern.any? { |p| request.path.starts_with? "/#{p}"}

      yield self

      tag.div class: 'nav-item dropdown' do
        render_link + render_menu
      end

    end

    private

    def render_link
      cls = 'nav-link dropdown-toggle'
      cls << ' active' if @active

      link_to text, "http://example.com",
                    class: cls,
                    'data-toggle' => "dropdown",
                    'aria-haspopup' => "true",
                    'aria-expanded' => "false"
    end

    def render_menu
      tag.div class: 'dropdown-menu' do
        @itens.map { |i| render_item_menu(i) }.join("\n").html_safe
      end
    end

    def render_item_menu(item)
      if item[:divider]
        tag.div class: 'dropdown-divider'
      else
        cls = "dropdown-item"
        cls << ' active' if request.path =~ item[:pattern] && @active
        link_to item[:text], item[:url], class: cls
      end
    end

  end

end
