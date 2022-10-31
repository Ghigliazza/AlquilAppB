require "application_system_test_case"

class CarsTest < ApplicationSystemTestCase
  setup do
    @car = cars(:one)
  end

  test "visiting the index" do
    visit cars_url
    assert_selector "h1", text: "Cars"
  end

  test "should create car" do
    visit cars_url
    click_on "New car"

    fill_in "Brand", with: @car.brand
    fill_in "Color", with: @car.color
    fill_in "Doors", with: @car.doors
    check "Engine" if @car.engine
    fill_in "Fuel", with: @car.fuel
    fill_in "Img url", with: @car.img_url
    fill_in "License", with: @car.license
    fill_in "Model", with: @car.model
    fill_in "Position", with: @car.position_id
    fill_in "Seats", with: @car.seats
    fill_in "State", with: @car.state
    click_on "Create Car"

    assert_text "Car was successfully created"
    click_on "Back"
  end

  test "should update Car" do
    visit car_url(@car)
    click_on "Edit this car", match: :first

    fill_in "Brand", with: @car.brand
    fill_in "Color", with: @car.color
    fill_in "Doors", with: @car.doors
    check "Engine" if @car.engine
    fill_in "Fuel", with: @car.fuel
    fill_in "Img url", with: @car.img_url
    fill_in "License", with: @car.license
    fill_in "Model", with: @car.model
    fill_in "Position", with: @car.position_id
    fill_in "Seats", with: @car.seats
    fill_in "State", with: @car.state
    click_on "Update Car"

    assert_text "Car was successfully updated"
    click_on "Back"
  end

  test "should destroy Car" do
    visit car_url(@car)
    click_on "Destroy this car", match: :first

    assert_text "Car was successfully destroyed"
  end
end
