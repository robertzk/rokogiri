context('rokogiri')

test_that('it can produce a simple example XML', {
  xml <- rokogiri({
    note({
      to("Tove")
      from("Jani")
      heading("Reminder")
      body("Don't forget me this weekend!")
    })
  })
 
  expected_xml <- "
    <note>
      <to>Tove</to>
      <from>Jani</from>
      <heading>Reminder</heading>
      <body>Don't forget me this weekend!</body>
    </note>
  "
  
  remove_spacing <- function(x) { gsub("[ \n]", "", x) }
  expect_equal(remove_spacing(xml), remove_spacing(expected_xml))
})
