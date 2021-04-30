# frozen_string_literal: true

# A static pages controller to manage static pages like home or contact page
class StaticPagesController < ApplicationController
  skip_authorization_check
  include PostsHelper

  def home
    @post = current_user.posts.build if can? :create, Post
    @feed = feed(params[:page])
    @contact = Contact.new
  end

  def about; end

  def imprint; end
end
