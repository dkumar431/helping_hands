class PagesController < ApplicationController

  def about_us
    article = Content.where(id: 2).first
    @title = article.title
    @content = article.content
  end

  def contact_us
    article = Content.where(id: 1).first
    @title = article.title
    @content = article.content
  end

end
