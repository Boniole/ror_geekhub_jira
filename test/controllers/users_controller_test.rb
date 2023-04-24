# require "test_helper"
#
# class Api::V2::UsersControllerTest < ActionDispatch::IntegrationTest
#   test "should create user" do
#     assert_difference("User.count") do
#       post users_url, params: { first_name: "Obi", last_name: "wan kenobi", email: "obiwan@ggmail.com", password: "ObiWan2023" }
#     end
#
#     assert_response :success
#   end
#
#   test "should show user" do
#     user = users(:luke_skywalker)
#     get user_url(user)
#     assert_response :success
#   end
#
#   test "should get index" do
#     get user_url
#     assert_response :success
#   end
# end
#
