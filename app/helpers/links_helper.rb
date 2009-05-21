module LinksHelper
  def link_to_each(resources)
    resources.collect { |resource| link_to(h(resource.to_s), resource) }
  end
end
