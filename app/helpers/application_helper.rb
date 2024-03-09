# frozen_string_literal: true

# :nodoc:
module ApplicationHelper
  def model_title(model, attribute_name, default: nil)
    title = model.try(attribute_name)
    return title if title.present?

    default || "#{model.model_name.human} ##{model.id}"
  end

  def model_value(model, attribute_name, default: '---')
    value = model.try(attribute_name)

    value.presence || default
  end

  def model_date_value(model, attribute_name, default: '---')
    value = model.try(attribute_name)

    value.present? ? I18n.l(value, format: :template_date) : default
  end

  def model_datetime_value(model, attribute_name, default: '---')
    value = model.try(attribute_name)

    value.present? ? I18n.l(value, format: :template_datetime) : default
  end
  alias model_timestamp_value model_datetime_value

  def model_time_value(model, attribute_name, default: '---')
    value = model.try(attribute_name)

    value.present? ? I18n.l(value, format: :template_time) : default
  end

  def default_image_tag(image, variant: nil)
    file = variant ? image.variant(variant) : image
    filename = file.filename.sanitized
    image_tag file, alt: filename, title: filename
  end

  def delete_button_with_dialog(message, button_text, resource, class:)
    render partial: 'application/delete_button_with_dialog', locals: { message:, button_text:, resource:, class: }
  end
end
