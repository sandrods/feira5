module ColecoesHelper

  def progress(value)
    <<-HTML
    <div class="progress">
      <div class="progress-bar progress-bar-striped" role="progressbar" style="width: #{value}%">
      </div>
    </div>
    HTML
    .html_safe
  end

end
