Rokogiri [![Build Status](https://travis-ci.org/robertzk/rokogiri.svg?branch=master)](https://travis-ci.org/robertzk/rokogiri.svg?branch=master) [![Coverage Status](https://coveralls.io/repos/robertzk/rokogiri/badge.svg?branch=master)](https://coveralls.io/r/robertzk/rokogiri?branch=master)
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
    <price>10.9</price>
    <year>1985</year>
  </cd>
  <cd>
    <title>Hide your heart</title>
    <artist>Bonnie Tyler</artist>
    <country>UK</country>
    <company>CBS Records</company>
    <price>9.9</price>
    <year>1988</year>
  </cd>
</catalog>
```

To generate this file using Rokogiri, we can write the following R code.

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

As you can see, the output is the appropriate XML. The advantage of using
Rokogiri over other XML generators is that the code is very readable
to write; it almost looks like English.

If you wish to provide your own XML converter, you can also produce
a list as output.

```r
rokogiri(output_type = 'list', {
  note({
    to("Tove")
    from("Jani")
    heading("Reminder")
    msg("Don't forget me this weekend!")
  })
})
```

Note that lists in R can share the same name multiple times! This means the list 
produced will not lose multiple records.

```
output <- rokogiri(output_type = 'list', {
  note({
    to("Tove")
  })
  note({
    to("Jim")
  })
})
stopifnot(names(output) == c("note", "note"))
```

If you have unorthodox tags in your XML, you can take advantage of another quirk of R.
Any string surrounded in backticks or quotes can be used as a variable name.

```r
rokogiri({
  "what-if-we-need"({
    "xml-tags"()
    "like-this"(2)
  })
})
```

The above example also shows that we can leave the argument to the function blank if it is 
an empty tag, and Rokogiri will produce the trailing slash.

