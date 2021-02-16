defmodule HomeworkTest do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case

  # Start hound session and destroy when tests are run
  hound_session()

  test "validates add/remove page" do
    # navigates to the add/remove page
    navigate_to "https://the-internet.herokuapp.com/add_remove_elements/"
    # verifies title
    assert page_title() == "The Internet"

    # captures create button with css selector
    addElementBtn = find_element(:css, ".example button")

    # uses loop to create new components via the create button
    for x <- 0..20 do 
      click(addElementBtn)
    end
    # captures the newly created items in a collection
    allElements = find_all_elements(:css, "#elements button")
    # uses the count/length of the array to confirm the expected number of created elements
    assert length(allElements) == 21

    # loops through the same number of times to delete newly created items
    for x <- 0..20 do 
      # pipes the first find_element result to the click function to delete the item
      find_element(:css, "#elements button") |> click()
    end
    # captures a collection of the deleted items with css selector
    noElements = find_all_elements(:css, "#elements button")
    # expects the array of deleted items to be empty after deletion
    assert length(noElements) == 0
    
  end

  test "validates check boxes page" do
    # navigates to the check boxes page
    navigate_to "https://the-internet.herokuapp.com/checkboxes"
    
    # captures first checkbox with xpath selector
    checkBox1 = find_element(:xpath, "//*[@id=\"checkboxes\"]/input[1]")
    # verifies initial checkbox value
    assert selected?(checkBox1) == false
    # changes value 
    click(checkBox1)
    # verifies changed value after click
    assert selected?(checkBox1) == true
    
    # captures second checkbox with xpath selector
    checkBox2 = find_element(:xpath, "//*[@id=\"checkboxes\"]/input[2]")
    # verifies initial checkbox value
    assert selected?(checkBox2) == true
    # changes value 
    click(checkBox2)
    # verifies changed value after click
    assert selected?(checkBox2) == false
    
  end

  test "validates dropdown page" do
    # navigates to the check boxes page
    navigate_to "https://the-internet.herokuapp.com/dropdown"

    # captures main dropdown element with css
    dropDown = find_element(:css, "#dropdown")
    # captures default dropdown item with css
    dropDefault = find_element(:css, "#dropdown > option:nth-child(1)")
    # vefifies default/initial state of default dropdown item
    assert attribute_value(dropDefault, "selected")

    # opens dropdown by selecting main element
    click(dropDown)
    # captures first non-default dropdown item by css
    dropOptionOne = find_element(:css, "#dropdown > option:nth-child(2)")
    # selects item
    click(dropOptionOne)
    # verifies new selection has the correct state
    assert attribute_value(dropOptionOne, "selected")

    # opens dropdown by selecting main element
    click(dropDown)
    # captures second non-default dropdown item by css
    dropOptionTwo = find_element(:css, "#dropdown > option:nth-child(3)")
    # selects item
    click(dropOptionTwo)
    # verifies new selection has the correct state
    assert attribute_value(dropOptionTwo, "selected")
    
  end

end
