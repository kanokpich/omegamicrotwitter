require "application_system_test_case"

class LikeOnFeedsTest < ApplicationSystemTestCase
  setup do
    @testlikeuser1 = users(:testlikeuser1)
    @testlikeuser2 = users(:testlikeuser2)
    @post = posts(:post1)
  end

  test "user2 like user1 post" do
    #login with testlikeuser2
    visit main_url
    fill_in "Email", with: @testlikeuser2.email
    fill_in "Password", with: 'testliketwo'
    click_on "Login"

    #go to testlikeuser1 profile and follow
    visit profile_path(name: @testlikeuser1.name)
    click_on "Follow"

    #go to feed and like testlikeuser1 post
    click_on "MicroTwitter"
    click_on "Like", match: :first

    #go to check testlikeuser1 profile, like is shown
    click_on @testlikeuser1.name
    assert_text "1 Like"
    assert_text @testlikeuser1.name
  end
end 