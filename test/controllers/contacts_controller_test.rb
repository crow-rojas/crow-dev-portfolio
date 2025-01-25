require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should create contact and send email" do
    assert_difference("Contact.count") do
      assert_emails 1 do
        post contacts_path, params: {
          contact: {
            name: "Test User",
            email: "test@example.com",
            message: "Hello, this is a test message"
          }
        }, headers: { "Accept" => "text/vnd.turbo-stream.html" }
      end
    end

    assert_response :success
    assert_match /<turbo-stream action="replace" target="contact_form">/, @response.body
  end

  test "should not create invalid contact" do
    assert_no_difference("Contact.count") do
      assert_no_emails do
        post contacts_path, params: {
          contact: {
            name: "",
            email: "invalid-email",
            message: ""
          }
        }, headers: { "Accept" => "text/vnd.turbo-stream.html" }
      end
    end

    assert_response :unprocessable_entity
  end
end
