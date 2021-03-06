#' Tidy a List of Named Dataframes or Named Vectors or Vectors
#'
#' \code{\link[base]{rbind}} a named \code{\link[base]{list}} of
#' \code{\link[base]{data.frame}}s or \code{\link[base]{vector}}s to
#' output a single \code{\link[base]{data.frame}} with the 
#' \code{\link[base]{names}} from the \code{\link[base]{list}} as an \code{id} 
#' column.
#'
#' @param x A named \code{\link[base]{list}} of
#' \code{\link[base]{data.frame}}s or \code{\link[base]{vector}}.
#' @param id.name The name to use for the column created from the 
#' \code{\link[base]{list}}.
#' @param content.name The name to use for the column created from the 
#' \code{\link[base]{list}} of \code{\link[base]{vector}}s (only used if 
#' \code{x} is \code{\link[base]{vector}}).
#' @param content.attribute.name The name to use for the column created from the
#' \code{\link[base]{list}} of names given to the \code{\link[base]{vector}}s
#' (only used if \code{x} is named \code{\link[base]{vector}}).
#' @param \ldots Ignored.
#' @return Returns a \code{\link[data.table]{data.table}} with the 
#' \code{\link[base]{names}} from the \code{\link[base]{list}} as an \code{id} 
#' column.
#' @export
#' @examples
#' tidy_list(list(p=1:500, r=letters))
#' tidy_list(list(p=mtcars, r=mtcars, z=mtcars, d=mtcars))
#'
#' x <- list(
#'     a = setNames(c(1:4), LETTERS[1:4]),
#'     b = setNames(c(7:9), LETTERS[7:9]),
#'     c = setNames(c(10:15), LETTERS[10:15]),
#'     d = c(x=4, y=6, 4),
#'     e = setNames(1:10, sample(state.abb, 10, TRUE)),
#'     f = setNames(1:10, sample(month.abb, 10, TRUE))
#' )
#'
#' tidy_list(x)
#'
#' \dontrun{
#' ## 2015 Vice-Presidential Debates Example
#' if (!require("pacman")) install.packages("pacman")
#' pacman::p_load(rvest, magrittr, xml2)
#'
#' debates <- c(
#'     wisconsin = "110908",
#'     boulder = "110906",
#'     california = "110756",
#'     ohio = "110489"
#' )
#'
#' lapply(debates, function(x){
#'     paste0("http://www.presidency.ucsb.edu/ws/index.php?pid=", x) %>%
#'         xml2::read_html() %>%
#'         rvest::html_nodes("p") %>%
#'         rvest::html_text() %>%
#'         textshape::split_index(grep("^[A-Z]+:", .)) %>%
#'         textshape::combine() %>%
#'         textshape::split_transcript() %>%
#'         textshape::split_sentence()
#' }) %>%
#'     textshape::tidy_list("location")
#' }
tidy_list <- function(x, id.name= "id", content.name = "content",
    content.attribute.name = 'attribute', ...){

    if (is.data.frame(x[[1]])){
        tidy_list_df(x = x, id.name = id.name)
    } else {

        if (is.atomic(x[[1]])){
            
            tidy_list_vector(x = x, id.name = id.name, 
                content.name = content.name, 
                content.attribute.name = content.attribute.name
            )
            
        } else {
            stop("`x` must be a list of `data.frame`s or atomic `vector`s")
        }
    }
}



tidy_list_df <- function (x, id.name = "id"){
    if (is.null(names(x))) {
        names(x) <- seq_along(x)
    }
    list.names <- rep(names(x), sapply2(x, nrow))
    x <- lapply(x, data.table::as.data.table)
    x[['fill']] <- TRUE
    out <- data.frame(list.names, do.call(rbind, x),
        row.names = NULL, check.names = FALSE, stringsAsFactors = FALSE)
    colnames(out)[1] <- id.name
    data.table::data.table(out)
}

tidy_list_vector <- function(x, id.name = "id",
    content.attribute.name = 'attribute', content.name = "content"){

    if (is.null(names(x))) {
        names(x) <- seq_along(x)
    }

    if (all(!sapply2(x, function(y) is.null(names(y))))){

        tidy_list(
            lapply(x, tidy_vector, content.attribute.name , content.name ), 
            id.name
        )

    } else {

        dat <- data.frame(
            rep(names(x), sapply2(x, length)),
            unlist(x, use.names = FALSE),
            stringsAsFactors = FALSE,
            check.names = FALSE,
            row.names = NULL
        )
        colnames(dat) <- c(id.name, content.name)
        data.table::data.table(dat)

    }
}



