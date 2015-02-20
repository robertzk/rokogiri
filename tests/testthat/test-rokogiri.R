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

