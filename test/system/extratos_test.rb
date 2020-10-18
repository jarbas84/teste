require "application_system_test_case"

class ExtratosTest < ApplicationSystemTestCase
  setup do
    @extrato = extratos(:one)
  end

  test "visiting the index" do
    visit extratos_url
    assert_selector "h1", text: "Extratos"
  end

  test "creating a Extrato" do
    visit extratos_url
    click_on "New Extrato"

    fill_in "Historico", with: @extrato.historico
    fill_in "Id user", with: @extrato.id_user
    click_on "Create Extrato"

    assert_text "Extrato was successfully created"
    click_on "Back"
  end

  test "updating a Extrato" do
    visit extratos_url
    click_on "Edit", match: :first

    fill_in "Historico", with: @extrato.historico
    fill_in "Id user", with: @extrato.id_user
    click_on "Update Extrato"

    assert_text "Extrato was successfully updated"
    click_on "Back"
  end

  test "destroying a Extrato" do
    visit extratos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Extrato was successfully destroyed"
  end
end
