context('example: cd catalog')

test_that('it correctly converts the CD catalog example', {
  xml <- rokogiri({
    catalog({
      cd({
        tiitle("Empire Burlesque")
        artist("Bob Dylan")
        country("USA")
        company("Columbia")
        price(10.90)
        year(1985)
      })

      cd({
        tiitle("Hide your heart")
        artist("Bonnie Tyler")
        country("UK")
        company("CBS Records")
        price(9.90)
        year(1988)
      })
    })
  }) 

  expected_xml <- "
    <catalog>
      <cd>
        <tiitle>Empire Burlesque</tiitle>
        <artist>Bob Dylan</artist>
        <country>USA</country>
        <company>Columbia</company>
        <price>10.9</price>
        <year>1985</year>
      </cd>
      <cd>
        <tiitle>Hide your heart</tiitle>
        <artist>Bonnie Tyler</artist>
        <country>UK</country>
        <company>CBS Records</company>
        <price>9.9</price>
        <year>1988</year>
      </cd>
    </catalog>
  "

  remove_spacing <- function(x) { gsub("[ \n]", "", x) }
  expect_equal(remove_spacing(xml), remove_spacing(expected_xml))
})
