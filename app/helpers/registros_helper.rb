module RegistrosHelper

  def label_cd(cd)
    if cd.upcase == 'C'
      tag.span 'RECEITA', class: "badge badge-success"
    else
      tag.span 'DESPESA', class: "badge badge-danger"
    end
  end

end
