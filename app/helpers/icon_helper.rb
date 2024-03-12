module IconHelper
  def icon_tag(name, classes: nil, style: nil)
    tag.i("", class: "icon icon-#{name} #{classes}", style:, aria: { hidden: true })
  end

  def icon_with_tooltip(name, icon_classes: nil, style: nil, translation_params: {}, key: "tooltips.icons")
    title = I18n.t("#{key}.#{name}", **translation_params)
    tag.span(icon_tag(name.split(".", 2).first, classes: icon_classes, style:), data: { controller: "tooltip", bs_toggle: "tooltip", title: })
  end
end
