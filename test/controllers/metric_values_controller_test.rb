require 'test_helper'

class MetricValuesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get metric_values_index_url
    assert_response :success
  end

  test "should get edit" do
    get metric_values_edit_url
    assert_response :success
  end

  test "should get update" do
    get metric_values_update_url
    assert_response :success
  end

end
