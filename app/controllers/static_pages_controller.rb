class StaticPagesController < ApplicationController
  def about
    render 'static_pages/about'
  end
end