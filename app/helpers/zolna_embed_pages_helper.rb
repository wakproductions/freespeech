module ZolnaEmbedPagesHelper
  def select_favorite_class(page)
    if page.favorite?
      'btn btn-warning'
    else
      'btn btn-default'
    end
  end
end
