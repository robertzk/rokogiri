#' Compile an R expression into XML.
#'
#' @param expr expression. The R expression to compile to XML.
#' @param output_type character. Either \code{'list'} or \code{'xml'}.
#'    By default, the latter.
#' @param enclos environment. The enclosing environment to use for evaluating
#'    variables mentioned in the XML generation process. By default,
#'    \code{parent.frame()}.
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
rokogiri <- function(expr, output_type = parent.frame()) {
  # Find all variables mentioned in the expression.
  vars <- all.names(substitute(expr))

  # Variables that have not already been defined in the parent environment
  # chain will be replaced with a function that generates the appropriate
  # list structure. This will achieve a "method missing" type of effect.
  # TODO: (RK) Somehow, we should be able to identify function calls moreso
  # than just variables, otherwise, e.g., if we have a global variable
  # called "note", but call note({ ... }) inside rokogiri to generate,
  # then this variable will have been overwritten and not give the correct
  # behavior. Even more specifically, we should be able to identify functions
  # that are called with one argument that looks like ({ ... }).



}

