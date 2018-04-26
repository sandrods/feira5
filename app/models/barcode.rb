class Barcode

  attr_accessor :produto, :cor, :tam

  def initialize(bc)
    raise ItemException.new("Código de Barras Inválido: #{bc}") unless bc =~ /(\d{2})(\d{2})(\d{6})/
    cor_id, tam_id, ref = $1, $2, $3

    @produto = Produto.find(ref.to_i) rescue nil
    @cor     = Cor.find(cor_id.to_i) rescue nil
    @tam     = Tamanho.find(tam_id.to_i) rescue nil

    raise ItemException.new("Produto Inválido: #{ref}") unless @produto
    raise ItemException.new("Cor Inválida: #{cor_id}") unless @cor
    raise ItemException.new("Tamanho Inválido: #{tam_id}") unless @tam

  end

  def find_item
    Item.where(cor_id: @cor.id, tamanho_id: @tam.id, produto_id: @produto.id).first
  end

end
