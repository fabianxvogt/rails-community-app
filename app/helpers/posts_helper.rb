# frozen_string_literal: true

require "auto_html"

# Adds helper methods to be used in context of a post
module PostsHelper
  include UserSessionsHelper

  FB_POST_FIELDS = %w[id type icon story name message
                      permalink_url link full_picture
                      description created_time].freeze

  # Returns the feed title.
  def feed_title(feed_title = "")
    if feed_title.empty?
      I18n.t("feed_header")
    else
      feed_title
    end
  end

  # Returns most recent posts per page
  def feed(page = 1, per_page = 3, only_admin = true)
    query = Post.includes(:user).where(users: { admin: only_admin })
    if current_user
      following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
      query = query.or(Post.includes(:user)
                         .where(users: { admin: !only_admin })
                         .where("user_id IN (#{following_ids}) OR user_id = :user_id",
                                user_id: current_user.id))
    end
    query.page(page).per(per_page)
  end

  # Returns a composition of filters that transforms input by passing the output
  # of one filter as input for the next filter in line.
  #
  # Note that the order of filters is important - ie you want 'Image' before
  # 'Link' filter so that URL of the image gets transformed to
  # 'img' tag and not 'a' tag.
  def format_pipeline
    AutoHtml::Pipeline
      .new(AutoHtml::Image.new,
           AutoHtml::Link.new(target: "_blank", rel: "noopener"))
  end

  # Returns simple format of text with html tags
  def auto_format_html(text)
    simple_format format_pipeline.call(text)
  end
end
