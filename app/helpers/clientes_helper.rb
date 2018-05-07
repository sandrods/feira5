module ClientesHelper

  def links_letras
    lis = Cliente.letras.map do |letra|
      active = (params[:letra] == letra) ? 'active' : ''
      tag.li class: "page-item #{active}" do
        link_to letra, clientes_path(letra: letra), class: 'page-link'
      end
    end

    tag.ul lis.join("\n").html_safe, class: 'pagination justify-content-center mb-4'
  end

end
