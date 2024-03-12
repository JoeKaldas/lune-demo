module ButtonHelper
  def submit_button(form_builder, options = {})
    text = options.delete(:text) || t("buttons.submit")
    classes = Array(options[:class]) + ["btn"]
    classes << if options.delete(:danger)
                 "btn-danger"
               elsif options.delete(:secondary)
                 "btn-secondary"
               elsif options.delete(:outline)
                 "btn-outline"
               else
                 "btn-primary"
               end

    options[:data] ||= {}
    options[:data][:disable_with] ||= text

    form_builder.submit(text, options.merge(class: classes.join(" ")))
  end

  def primary_button(form_builder, options = {})
    submit_button(form_builder, options.merge(success: true))
  end
  alias success_button primary_button

  def secondary_button(form_builder, options = {})
    submit_button(form_builder, options.merge(secondary: true))
  end

  def outline_button(form_builder, options = {})
    submit_button(form_builder, options.merge(outline: true))
  end

  def danger_button(form_builder, options = {})
    submit_button(form_builder, options.merge(danger: true))
  end

  def cancel_button(url = :back, key = "buttons.cancel", options = {})
    link_to(I18n.t(key), url, options.merge(class: "btn btn-secondary"))
  end

  def create_button(form_builder, text = I18n.t("buttons.create"))
    primary_button(form_builder, text:)
  end

  def update_button(form_builder, options = {})
    options[:text] ||= I18n.t("buttons.update")
    primary_button(form_builder, options)
  end

  def download_xls_button(text = I18n.t("misc.export.xls"), url: { format: :xlsx })
    link_to(url, class: "btn btn-outline nowrap", data: { turbo: false }) do
      text
    end
  end

  def download_link(text = I18n.t("misc.download"), url:)
    link_to(url, data: { turbo: false }, class: "btn sm btn-outline") do
      text
    end
  end

  def upload_button(url, key: "misc.upload")
    link_to(url, class: "btn btn-outline") do
      I18n.t(key)
    end
  end

  def add_button(url, text: I18n.t("buttons.add"))
    link_to(url, class: "btn btn btn-outline nowrap") do
      text
    end
  end

  def edit_button(url, key: "buttons.edit", turbo_frame: nil)
    link_to(url, class: "btn btn-secondary btn-sm", data: { turbo_frame: }) do
      I18n.t(key)
    end
  end

  def confirm_modal_link(text, target:)
    link_to(text, target, data: { bs_toggle: "modal" })
  end

  def delete_modal_button(target, classes: "ms-2", message: "Are you sure?")
    text = I18n.t("misc.delete")
    button_to(text, target, class: "btn btn-sm btn-secondary #{classes}", method: :delete, form: { class: "d-inline-block", data: { turbo_confirm: message } })
  end

  def dismiss_dialog_button
    tag.button("", class: "btn-close", aria_label: "Close")
  end

  def dismiss_modal_button
    tag.button("", class: "btn-close", data: { bs_dismiss: "modal" }, aria_label: "Close")
  end

  def cancel_modal_button(text = I18n.t("misc.never_mind"), classes: nil)
    link_to(text, "#", data: { bs_dismiss: "modal" }, class: "btn btn-secondary #{classes}")
  end
end
