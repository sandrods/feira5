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
      m.link "Compras", compras_path
      m.link "Fornecedores", fornecedores_path
      m.link "Coleções", colecoes_path
    end

    add_menu "Vendas", %w(vendas) do |m|
      m.link "Vendas", root_path
      m.divider
      m.link "Sacolas", root_path
      m.link "Clientes", clientes_path
      m.divider
      m.link "Vendas Mensais", root_path
    end

    add_menu "Financeiro", %w(vendas) do |m|
      m.link "Diário", root_path
      m.link "Anual", root_path
      m.divider
      m.link "Contas", root_path
      m.link "Categorias", root_path
      m.link "Formas de Pagto", root_path
    end
    # add_link "Lançamento",
    #          lancamento_propostas_path,
    #          %w(lancamento)) if current_user.role?("admin_proposta")

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

    def link(text, url)
      @itens ||= []
      @itens << { text: text, url: url }
    end

    def divider
      @itens ||= []
      @itens << { divider: true }
    end

    def render
      yield self

      tag.div class: 'nav-item dropdown' do
        render_link + render_menu
      end

    end

    private

    def render_link
      cls = 'nav-link dropdown-toggle'

      if pattern.present? && pattern.any? { |p| request.path.starts_with? "/#{p}"}
        cls << ' active'
      end

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
        link_to item[:text], item[:url], class: 'dropdown-item'
      end
    end

  end

end
