context('rokogiri')

test_that('it can produce a simple pre-XML list output', {
  xml <- rokogiri(output_type = 'list', {
    note({
      to("Tove")
      from("Jani")
      heading("Reminder")
      msg("Don't forget me this weekend!")
    })
  })
 
  expected_list <- list(note = list(to = "Tove",
    from = "Jani", heading = "Reminder", msg = "Don't forget me this weekend!"))

  expect_identical(xml, expected_list)
})

test_that('it can produce a simple pre-XML list output with duplicate entries', {
  xml <- rokogiri(output_type = 'list', {
    note({
      to("Tove")
      from("Jani")
      heading("Reminder")
      msg("Don't forget me this weekend!")
    })

    note({
      to("Tove")
      from("Jani")
      heading("Reminder")
      msg("Don't forget me this weekend!")
    })
  })
 
  expected_list <- replicate(2, list(note = list(to = "Tove",
    from = "Jani", heading = "Reminder", msg = "Don't forget me this weekend!")))

  expect_identical(xml, expected_list)
})

test_that('it can produce a simple example XML', {
  xml <- rokogiri({
    note({
      to("Tove")
      from("Jani")
      heading("Reminder")
      msg("Don't forget me this weekend!")
    })
  })
 
  expected_xml <- "
    <note>
      <to>Tove</to>
      <from>Jani</from>
      <heading>Reminder</heading>
      <msg>Don't forget me this weekend!</msg>
    </note>
  "
  
  remove_spacing <- function(x) { gsub("[ \n]", "", x) }
  expect_equal(remove_spacing(xml), remove_spacing(expected_xml))
})

test_that('it can produce a simple example XML with duplicate outputs', {
  xml <- rokogiri({
    note({
      to("Tove")
      from("Jani")
    })

    note({
      to("John")
      from("Jane")
    })
  })
 
  expected_xml <- "
    <note>
      <to>Tove</to>
      <from>Jani</from>
    </note>
    <note>
      <to>John</to>
      <from>Jane</from>
    </note>
  "
  
  remove_spacing <- function(x) { gsub("[ \n]", "", x) }
  expect_equal(remove_spacing(xml), remove_spacing(expected_xml))
})

test_that('it can produce a simple example XML with null output', {
  xml <- rokogiri({
    note({
      to("Tove")
      msg()
    })
  })
 
  expected_xml <- "
    <note>
      <to>Tove</to>
      <msg />
    </note>
  "
  
  remove_spacing <- function(x) { gsub("[ \n]", "", x) }
  expect_equal(remove_spacing(xml), remove_spacing(expected_xml))
})


