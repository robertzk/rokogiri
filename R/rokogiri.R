#' Compile an R expression into XML.
#'
#' @param expr expression. The R expression to compile to XML.
#' @param output_type character. Either \code{'list'} or \code{'xml'}.
#'    By default, the latter.
#' @param enclos environment. The enclosing environment to use for evaluating
#'    variables mentioned in the XML generation process. By default,
#'    \code{parent.frame()}.
#' @return a character string representing the compiled XML.
#' @export
#' @examples
#' xml <- rokogiri({
#'   note({
#'     to("Tove")
#'     from("Jani")
#'     heading("Reminder")
#'     msg("Don't forget me this weekend!")
#'   })
#' })
#'
#' expected_xml <- "
#'   <note>
#'     <to>Tove</to>
#'     <from>Jani</from>
#'     <heading>Reminder</heading>
#'     <msg>Don't forget me this weekend!</msg>
#'   </note>
#' "
#' 
#' remove_spacing <- function(x) { gsub("[ \n]", "", x) }
#' stopifnot(remove_spacing(xml) == remove_spacing(expected_xml))
rokogiri <- function(expr, output_type = 'xml', enclos = parent.frame()) {
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
  vars <- remove_variables_already_defined(vars, envir = enclos)

  eval_env <- list2env(
    setNames(replicate(length(vars), node_function), vars),
    parent = enclos
  )

  output <- eval(substitute(node_function(expr)), envir = eval_env)
  
  if (identical(output_type, "list")) {
    output
  } else {
    to_xml(output)
  }
}

remove_variables_already_defined <- function(vars, envir = parent.frame()) {
  Filter(
    # TODO: (RK) Instead, replace with substitute functions that check
    # their call expression's first argument for `{`, and if not present,
    # try a function from further up the environment stack.
    function(var) { !exists(var, envir = envir) },
    unique(vars)
  )
}

node_function <- function(...) {
  call_name <- as.character(sys.call()[[1]])
  dots <- eval(substitute(alist(...)))
  eval_env <- list2env(list(`_stack` = list()), parent = parent.frame())

  if (length(dots) > 1) {
    # TODO: (RK) More detailed call stack.
    stop("rokogiri requires each xml node definition is a function call  with ",
         "exactly one argument. You provided ", length(dots), " when ",
         "calling the ", sQuote(call_name), " node.", call. = FALSE)
  }

  is_block <- length(dots) > 0 && identical(dots[[1]][[1]], as.name("{"))

  value <- if (length(dots) == 0) {
    setNames(list(NULL), call_name)
  } else if (is_block) {
    eval(dots[[1]], envir = eval_env)
    setNames(list(eval_env$`_stack`), call_name)
  } else {
    setNames(list(eval(dots[[1]], envir = eval_env)), call_name)
  }

  parent.env(eval_env)$`_stack` <- c(parent.env(eval_env)$`_stack`, value)

  if (is_block) {
    eval_env$`_stack`
  } else {
    value
  }
}

to_xml <- function(list, nest = 0) {
  spacing <- paste(collapse = '', replicate(nest, '  '))
  if (is.atomic(list)) {
    paste0(spacing, as.character(list))
  } else if (length(list) == 1 && is.null(list[[1]])) {
    paste0(spacing, '<', names(list)[1], ' />')
  } else if (length(list) == 1) {
    # TODO: (RK) Sanitize XML string output.
    paste0(spacing, '<', names(list)[1], ">\n", to_xml(list[[1]], nest + 1),
           "\n", spacing, "</", names(list)[1], '>')
  } else {
    paste(collapse = "\n", vapply(seq_along(list), function(i) {
      to_xml(setNames(base::list(list[[i]]), nm = names(list)[i]), nest)
    }, character(1)))
  }
}

