import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "custo", "valor", "lucro", "rentabilidade" ]

  reload() {
    $.getJSON("/produtos/lucro", {
      custo: this.custoTarget.value,
      valor: this.valorTarget.value
    })
    .done((data) => {
      this.lucroTarget.innerHTML = data.lucro;
      this.rentabilidadeTarget.innerHTML = data.rentabilidade;
    })
  }
}
