require "application_system_test_case"

class LoginsTest < ApplicationSystemTestCase
  setup do
    @user1 = users(:user1)
    @user2 = users(:user2)
  end

  test "user1 login success" do
    visit main_url
    fill_in "Email", with: @user1.email
    fill_in "Password", with: '12345678'
    click_on "Login"
    assert_text "Login successfully"
  end

  test "user2 login success" do
    visit main_url
    fill_in "Email", with: @user2.email
    fill_in "Password", with: 'testtwo'
    click_on "Login"
    assert_text "Login successfully"
  end

  test "user1 login with wrong password" do
    visit main_url
    fill_in "Email", with: @user1.email
    fill_in "Password", with: 'asdasdasdasdas'
    click_on "Login"
    assert_text "Invalid Email or Password. please try again"
  end

  test "user1 login but not enter password" do
    visit main_url
    fill_in "Email", with: @user1.email
    click_on "Login"
    assert_text "Invalid Email or Password. please try again"
  end

  test "user1 login but not enter email" do
    visit main_url
    fill_in "Password", with: 'testone'
    click_on "Login"
    assert_text "Invalid Email or Password. please try again"
  end

  test "user1 login but not enter anything" do
    visit main_url
    click_on "Login"
    assert_text "Invalid Email or Password. please try again"
  end

end