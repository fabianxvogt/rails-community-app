# frozen_string_literal: true

require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = I18n.t("community.name")
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", @base_title.to_s
  end

  test "should get imprint" do
    get imprint_path
    assert_response :success
    assert_select "title", "Imprint | #{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

  test "should get administration pages" do
    user = users(:lana)
    log_in_as(user)
    # administration menu all users
    get users_path
    assert_select "title", "All users | #{@base_title}"
  end

  test "should get membership application link" do
    get root_path
    assert_select "a[href=?]", membership_application_url,
      text: I18n.t("community.about_membership_application_link_html",
        community_name: I18n.t("community.name"))
    assert_select "a[href=?]", membership_application_url, target: "_blank"
  end
end
