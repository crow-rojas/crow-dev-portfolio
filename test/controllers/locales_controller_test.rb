require "test_helper"

class LocalesControllerTest < ActionDispatch::IntegrationTest
  test "should update locale" do
    get switch_locale_path(locale: :es)
    assert_redirected_to root_path
    assert_equal "es", I18n.locale.to_s

    get switch_locale_path(locale: :en)
    assert_redirected_to root_path
    assert_equal "en", I18n.locale.to_s
  end
end
