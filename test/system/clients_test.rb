require "application_system_test_case"

class ClientsTest < ApplicationSystemTestCase
  test "CRUDing a client" do
    visit clients_url

    # Create
    click_link "New Client"
    fill_in "Name", :with => "Widgets, Inc."
    fill_in "Email", :with => "owners@widgets.biz"

    click_button "Create Client"

    assert_text "Client was successfully created."
    assert_text "Name: Widgets, Inc."
    assert_text "Email: owners@widgets.biz"

    click_link "Back"

    # Update
    find_client_row_named("Widgets, Inc.").find_link("Edit").click
    fill_in "Name", :with => "Widgets LLP"
    fill_in "Email", :with => "partners@widgets.biz"

    click_button "Update Client"

    assert_text "Client was successfully updated."
    assert_text "Name: Widgets LLP"
    assert_text "Email: partners@widgets.biz"

    click_link "Back"

    # Destroy
    find_client_row_named("Widgets LLP").find_link("Destroy").click

    accept_confirm "Are you sure?"

    assert_text "Client was successfully destroyed."
    refute_text "Widgets"
  end

  private

  def find_client_row_named(name)
    find("tbody").all("tr").find { |tr| tr.first("td").text == name }
  end
end
