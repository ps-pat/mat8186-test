source("../utils.R")
options(repr.plot.width = 10, repr.plot.height = 10)

#' Titre
#'
#' Le second paragraphe est toujours la description. Le premier
#' paragraphe est le titre et ne devrait pas être plus long
#' qu'une phrase. Ce paragraphe donne une description générale
#' de l'objet à documenter.
#'
#' L'ensemble des paragraphes suivants contient les détails
#' de l'objet à documenter.

address <- function() "PK-5323"
x <- 42
address()

pryr::address(x)

library(pryr)

address(x)
