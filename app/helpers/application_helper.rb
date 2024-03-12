module ApplicationHelper
  include Pagy::Frontend

  def loading_tag(text = t("misc.loading"))
    tag.div(class: "loading") do
      tag.span(class: "me-2 fas fa-spinner fa-spin", role: "status") +
        tag.span(text)
    end
  end

  def card_linked_to(url, options = {})
    link_to tag.span, url, options.merge(class: "primary-link", rel: "nofollow")
  end

  def card_toggle_icon(clickable = true)
    if clickable
      tag.i(class: "ms-1 fa fa-ellipsis-v text-secondary")
    else
      tag.span(" ", class: "ms-2")
    end
  end

  def anchor_link(id, &)
    tag.h3(
      capture(&),
      class: "anchor",
      id:
    )
  end

  def search_reset_tag
    tag.span(
      link_to(t("shared.search.reset"), "", class: "text-decoration-none"),
      data: { bs_toggle: "collapse", bs_target: "#filter-modal", action: "click->search#reset" }
    )
  end

  def boolean_options
    [[t("misc.yes"), "1"], [t("misc.no"), "0"]]
  end

  def i18n_status_options(klass, key: nil, statuses: nil)
    # We want returned key to be underscored for I18n
    key ||= klass.to_s.underscore
    statuses ||= klass.statuses
    # Using |k,v| this instead of |status| as some enums are integers not strings
    statuses.map { |k, v| [I18n.t("statuses.#{key}.#{k}"), v] }
  end
end
