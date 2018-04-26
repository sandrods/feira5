class NavBarComponent
  include ViewComponent

  def render

    add_menu "Produtos", %w(cores) do |m|
      m.link "Cores", cores_path
      m.link "Tamanhos", tamanhos_path
      m.link "Linhas", linhas_path
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
        @itens.map { |i| link_to i[:text], i[:url], class: 'dropdown-item' }.join("\n").html_safe
      end

    end

  end

end
