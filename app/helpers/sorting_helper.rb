module SortingHelper
  def sort_menu(search, *args, key: "default")
    links = args.map do |attr|
      sort_link(search, attr, key:)
    end
    items = tag.div(safe_join(links), class: "dropdown-menu")
    tag.div(toggle + items, class: "dropdown sort-dropdown dropbottom")
  end

  def sort_menu_from_filter(filter, key = "default")
    sort_menu(filter.search, *filter.sort_fields, key:)
  end

  private

  def toggle
    tag.a(t("sorting.default.label"),
          class: "dropdown-toggle",
          href: "#",
          data: { bs_toggle: "dropdown" })
  end

  def sort_link(search, attr, key:)
    sort_attr = search.sorts.first&.name || "name"
    sort_dir = search.sorts.first&.dir || "asc"
    selected = attr.to_s == sort_attr.to_s
    dir = selected ? dirs[sort_dir] : "asc"
    tag.li(class: "dropdown-item clickable", data: { attr:, dir:, action: "click->search#sortRecords" }) do
      safe_join([t("sorting.#{key}.#{attr}"), (icon_tag("arrow-#{sort_dir}", classes: "ms-2") if selected)].compact)
    end
  end

  def dirs
    { asc: "desc", desc: "asc" }.with_indifferent_access
  end
end
