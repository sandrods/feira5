module ColecoesHelper

  def progress(value)
    color = (value >= 100) ? 'bg-success' : ''
    <<-HTML
    <div class="progress">
      <div class="progress-bar #{color}" role="progressbar" style="width: #{value}%">
      </div>
    </div>
    HTML
    .html_safe
  end

end
