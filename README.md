Rokogiri [![Build Status](https://travis-ci.org/robertzk/rokogiri.svg?branch=master)](https://travis-ci.org/robertzk/rokogiri.svg?branch=master) [![Coverage Status](https://coveralls.io/repos/robertzk/rokogiri/badge.svg?branch=master)](https://coveralls.io/r/robertzk/rokogiri)
==============

An XML generator DSL in R, inspired by Ruby's Nokogiri.

Examples
--------

Imagine we would like to produce the XML output for a CD catalog.

```xml
<catalog>
  <cd>
    <title>Empire Burlesque</title>
    <artist>Bob Dylan</artist>
    <country>USA</country>
    <company>Columbia</company>
    <price>10.90</price>
    <year>1985</year>
  </cd>
  <cd>
    <title>Hide your heart</title>
    <artist>Bonnie Tyler</artist>
    <country>UK</country>
    <company>CBS Records</company>
    <price>9.90</price>
    <year>1988</year>
  </cd>
  <cd>
</catalog>
```

To generate this file using Nokogiri, we can write the following R code.

```r
rokogiri({
  catalog({
    cd({
      title("Empire Burlesque")
      artist("Bob Dylan")
      country("USA")
      company("Columbia")
      price(10.90)
      year(1985)
    })

    cd({
      title("Hide your heart")
      artist("Bonnie Tyler")
      country("UK")
      company("CBS Records")
      price(9.90)
      year(1988)
    })
  })
}) 
```

