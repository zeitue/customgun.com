require 'test_helper'

class ShowcaseControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get showcase_about_url
    assert_response :success
  end

  test "should get alchemist_series" do
    get showcase_alchemist_series_url
    assert_response :success
  end

  test "should get boddington_rifle_project" do
    get showcase_boddington_rifle_project_url
    assert_response :success
  end

  test "should get bracelet_helpers" do
    get showcase_bracelet_helpers_url
    assert_response :success
  end

  test "should get contact" do
    get showcase_contact_url
    assert_response :success
  end

  test "should get custom_rifles" do
    get showcase_custom_rifles_url
    assert_response :success
  end

  test "should get engraving" do
    get showcase_engraving_url
    assert_response :success
  end

  test "should get events" do
    get showcase_events_url
    assert_response :success
  end

  test "should get finishes" do
    get showcase_finishes_url
    assert_response :success
  end

  test "should get gun_fitting" do
    get showcase_gun_fitting_url
    assert_response :success
  end

  test "should get gun_parts" do
    get showcase_gun_parts_url
    assert_response :success
  end

  test "should get guns_for_sale" do
    get showcase_guns_for_sale_url
    assert_response :success
  end

  test "should get gunsmithing" do
    get showcase_gunsmithing_url
    assert_response :success
  end

  test "should get home" do
    get showcase_home_url
    assert_response :success
  end

  test "should get key_chains" do
    get showcase_key_chains_url
    assert_response :success
  end

  test "should get leather_wrap_pads" do
    get showcase_leather_wrap_pads_url
    assert_response :success
  end

  test "should get media" do
    get showcase_media_url
    assert_response :success
  end

  test "should get payment_and_shipping" do
    get showcase_payment_and_shipping_url
    assert_response :success
  end

  test "should get pens" do
    get showcase_pens_url
    assert_response :success
  end

  test "should get pistols" do
    get showcase_pistols_url
    assert_response :success
  end

  test "should get restoration" do
    get showcase_restoration_url
    assert_response :success
  end

  test "should get shotguns" do
    get showcase_shotguns_url
    assert_response :success
  end

  test "should get stock_work" do
    get showcase_stock_work_url
    assert_response :success
  end

  test "should get synthetic_rifles" do
    get showcase_synthetic_rifles_url
    assert_response :success
  end

  test "should get taylors_pens_and_gifts" do
    get showcase_taylors_pens_and_gifts_url
    assert_response :success
  end

  test "should get trophy_room" do
    get showcase_trophy_room_url
    assert_response :success
  end

  test "should get wine_stoppers" do
    get showcase_wine_stoppers_url
    assert_response :success
  end

end
