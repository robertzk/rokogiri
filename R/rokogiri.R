#' Compile an R expression into XML.
#'
#' @param expr expression. The R expression to compile to XML.
#' @param output_type character. Either \code{'list'} or \code{'xml'}.
#'    By default, the latter.
#' @return a character string representing the compiled XML.
#' @examples
#' xml <- rokogiri({
#'   note({
#'     to("Tove")
#'     from("Jani")
#'     heading("Reminder")
#'     body("Don't forget me this weekend!")
#'   })
#' })
#'
#' expected_xml <- "
#'   <note>
#'     <to>Tove</to>
#'     <from>Jani</from>
#'     <heading>Reminder</heading>
#'     <body>Don't forget me this weekend!</body>
#'   </note>
#' "
#' 
#' remove_spacing <- function(x) { gsub("[ \n]", "", x) }
#' stopifnot(remove_spacing(xml) == remove_spacing(expected_xml))
#' }
rokogiri <- function(expr, output_type) {
  .NotYetImplemented()
}

