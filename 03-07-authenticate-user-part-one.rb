require "rails_helper"

RSpec.feature "user logs in" do
  scenario "and log out" do
    name = "Sylvie"
    user = create(:person, first_name: name)

    visit root_path

    expect(page).not_to have_text(name)
    expect(page).not_to have_text "Log out"

    click_on "Log in"

    within "form" do
      fill_in :session_email, with: user.email
      click_on "Log in"
    end

    expect(page).to have_text("Logged in!")
    expect(page).to have_text(name)
    expect(page).to have_text "Log out"
    expect(page).not_to have_text "Log in"

    click_on "Log out"

    expect(page).to have_current_path(root_path)
    expect(page).to have_text("Logged out!")
    expect(page).not_to have_text(name)
    expect(page).not_to have_text "Log out"
  end
end
