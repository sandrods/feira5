module ApplicationHelper

  def page_header(title, sub = nil, back_to: nil, &block)
    _sub = sub ? "&nbsp;<small>#{sub}</small>" : ""

    actions = ''
    actions << link_to_back(back_to) if back_to.present?
    actions << capture(&block) if block_given?

    header = <<-HTML
      <div class="page-header">
          <h1>#{title} #{_sub}</h1>
          <div class="actions">#{actions}</div>
          <div class="line"></div>
      </div>
      <div class="flash-messages">
        #{flash_messages}
      </div>
    HTML
    header.html_safe
  end

  def modal_page_header(title, sub = nil, &block)
    _sub = sub ? "&nbsp;<small>#{sub}</small>" : ""
    actions = tag.div(class: 'actions', &block) if block_given?

    header = <<-HTML

    <div class="modal-header flex-column">

      <div class='d-flex w-100 justify-content-between'>
        <div class="page-header w-100">
            <h1>#{title} #{_sub}</h1>
            #{actions}
            <div class="line"></div>
        </div>

        <button type="button" class="close right" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="flash-messages w-100">
        #{flash_messages}
      </div>

    </div>

    HTML
    header.html_safe
  end

  def flash_messages
    _flashes = ""
    flash.each do |name, msg|
      case name.to_sym
        when :notice, :success
          _type = 'success'
        when :danger, :error, :alert
          _type = 'danger'
        when :warning
          _type = 'warning'
        when :info
          _type = 'info'
        end
      _flashes << alert(text: msg, type: _type, dismissable: true)
    end
    flash.discard
    _flashes.html_safe
  end

def fa(*names)
    names.map! { |name| name.to_s.gsub('_','-') }
    names.map! do |n|
      return n if n =~ /pull-(?:left|right)/

      if n =~ /^r-(.*)/
        pre = 'far'
        n = $1
      else
        pre = 'fas'
      end

      if n =~ /(.*)-(xs|sm|lg|\dx)$/
        "#{pre} fa-#{$1} fa-#{$2}"
      else
        "#{pre} fa-#{n}"
      end

    end

    tag.i class: names
  end

  def icn(_icon, text = nil, left = true)
    ic = fa(_icon)
    if text
      if left
        ic += ('&nbsp;&nbsp;'.html_safe + text)
      else
        ic = (text + '&nbsp;&nbsp;'.html_safe + ic)
      end
    end
    raw(ic)
  end

  def alert(text:, type:, icon: nil, dismissable: false, &block)
    txt = Array(text).join("<br/>").html_safe

    case type.to_s
    when 'success', 'notice'
      _icon = icn(:check_circle_2x)
      clazz = 'success'

    when 'warning'
      _icon = icn(:exclamation_circle_2x)
      clazz = 'warning'

    when 'error', 'danger'
      _icon = icn(:times_circle_2x)
      clazz = 'danger'

    when 'info'
      _icon = icn(:info_circle_2x)
      clazz = 'info'

    else
      raise "Invalid type: #{type} for alert helper"
    end

    ic = icon.present? ? icn("#{icon}_2x") : _icon

    content = tag.div(ic + tag.div(txt, class: 'text'), class: 'd-flex align-items-center')

    if block_given?
      content += tag.div(&block)
      tag.div content, class: "alert alert-#{clazz} d-flex justify-content-between"

    elsif dismissable
      d = tag.button '&times;'.html_safe, class: 'close', data: { dismiss: 'alert' }, 'aria-hidden': true
      tag.div d + content, class: "alert alert-#{clazz} alert-dismissable"

    else
      tag.div content, class: "alert alert-#{clazz}"

    end

  end

  def link_to_back(path = nil)
    link_to icn(:arrow_left, "Voltar"), (path || :back), class: 'btn btn-clean'
  end

  def modal(id:, &block)
    content = tag.div(class: 'modal-content', &block)

    modal = <<-HTML
      <div class="modal fade" id=#{id}>
        <div class="modal-dialog" role="document">
          #{content}
        </div>
      </div>
    HTML

    modal.html_safe
  end

  def link_to_delete(path)

    link_to icn(:trash),
            path,
            method: :delete,
            data: { confirm: "Confirma Exclusão?" },
            class: 'muted-danger'
  end

  def card_item(text, label)
    return unless text.present?

    <<-HTML.html_safe
      <label>#{label}</label>
      <p>#{text}</p>
    HTML
  end

  def curr(val)
    number_with_precision(val, precision: 2)
  end

  def index_count(count, text)

    _count = tag.span count, class: 'badge badge-info'
    _text  = tag.small text
    _space = "&nbsp;".html_safe

    tag.h5 _count + _space + _text, class: 'index_count'

  end
end
