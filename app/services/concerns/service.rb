module Service
  extend ActiveSupport::Concern

  included do
    attr_accessor :infos
    attr_accessor :errors
    attr_accessor :warnings
  end

  class_methods do

    def run(*args)
      service = new(*args)
      service.run

      return service

    rescue Service::Error => e
      return service
    end

    def run!(*args)
      service = new(*args)
      service.run

      service
    end

  end

  def compose(service_class, *args)
    service_instance = service_class.run(*args)
    add_errors service_instance.errors
    add_warnings service_instance.warnings

    service_instance
  end

  def compose!(service_class, *args)
    service_instance = compose(service_class, *args)

    if service_instance.success?
      service_instance
    else
      raise Error
    end
  end

  def add_error(msg)
    @errors ||=[]
    @errors += Array(msg)
  end
  alias_method :add_errors, :add_error

  def add_warning(msg)
    @warnings ||=[]
    @warnings += Array(msg)
  end
  alias_method :add_warnings, :add_warning

  def add_info(msg)
    @infos ||=[]
    @infos += Array(msg)
  end
  alias_method :add_infos, :add_info

  def fail!(msg)
    add_error msg
    raise Error, msg
  end

  def error_messages html: true
    msgs from: @errors, html: html
  end

  def warning_messages html: true
    msgs from: @warnings, html: html
  end

  def info_messages html: true
    msgs from: @infos, html: html
  end

  def success?
    @errors.blank?
  end

  def warning?
    @warnings.present?
  end

  def logger
    Rails.logger
  end

  class Error < StandardError; end

  private

  def msgs from:, html: false
    return unless from.present?

    if html
      from.join("<br/>").html_safe
    else
      from.join("\n")
    end
  end

end
