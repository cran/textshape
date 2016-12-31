#' Tools for Reshaping Text
#'
#' Tools that can be used to reshape text data.
#' @docType package
#' @name textshape
#' @aliases textshape package-textshape
NULL

#' Fictitious Classroom Dialogue
#'
#' A fictitious dataset useful for small demonstrations.
#'
#' @details
#' \itemize{
#'   \item person. Speaker
#'   \item sex. Gender
#'   \item adult. Dummy coded adult (0-no; 1-yes)
#'   \item state. Statement (dialogue)
#'   \item code. Dialogue coding scheme
#' }
#'
#' @docType data
#' @keywords datasets
#' @name DATA
#' @usage data(DATA)
#' @format A data frame with 11 rows and 5 variables
NULL

#' Hamlet (Complete & Split by Sentence)
#'
#' A dataset containing the complete dialogue of Hamlet with turns of talk split
#' into sentences.
#'
#' @details
#' \itemize{
#'   \item act. The act (akin to repeated measures)
#'   \item tot. The turn of talk
#'   \item scene. The scene (nested within an act)
#'   \item location. Location of the scene
#'   \item person. Character in the play
#'   \item died. Logical coded death variable if yes the character dies in the
#'   play
#'   \item dialogue. The spoken dialogue
#' }
#'
#' @docType data
#' @keywords datasets
#' @name hamlet
#' @usage data(hamlet)
#' @format A data frame with 2007 rows and 7 variables
#' @references
#' http://www.gutenberg.org
NULL



#' Simple \code{\link[tm]{DocumentTermMatrix}}
#'
#' A dataset containing a simple \code{\link[tm]{DocumentTermMatrix}}.
#'
#' @details
#' \describe{
#'   \item{i}{The document locations}
#'   \item{j}{The term locations}
#'   \item{v}{The count of terms for that particular element position}
#'   \item{nrow}{The number of rows}
#'   \item{ncol}{The number of columns}
#'   \item{dimnames}{document and terms}
#' }
#'
#' @docType data
#' @keywords datasets
#' @name simple_dtm
#' @usage data(simple_dtm)
#' @format A list with 6 elements
NULL