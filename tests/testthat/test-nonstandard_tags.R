context('nonstandard tags')

test_that('it can correctly convert XML for tags containing hyphens', {
  xml <- rokogiri({
    "what-if-we-need"({
      "xml-tags"()
      "like-this"(2)
    })
  })

  expected_xml <- "
    <what-if-we-need>
      <xml-tags />
      <like-this>
        2
      </like-this>
    </what-if-we-need>
  "

  remove_spacing <- function(x) { gsub("[ \n]", "", x) }
  expect_equal(remove_spacing(xml), remove_spacing(expected_xml))
})
