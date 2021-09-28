########################
##     Exercice 1     ##
########################

distr <- function(density, parameters, name) {
    stop("À compléter")
}

dens <- function(d, y, x, log, ...) {
    stop("À compléter")
}

dens.distr <- function(d, y, x, log = FALSE, ...) {
    stop("À compléter")
}

print.distr <- function(x, ...) {
    stop("À compléter")
}

########################
##     Exercice 2     ##
########################

kern <- function(density, parameters, name, sampler) {
    stop("À compléter")
}

rand <- function(d, n, x, ...) {
    stop("À compléter")
}

rand.kern <- function(d, n, x, ...) {
    stop("À compléter")
}

########################
##     Exercice 3     ##
########################

mhsampler <- function(target, proposal) {
    stop("À compléter")
}

aratio <- function(sampler, y, x, log, ...) stop("À compléter")

aratio.mhsampler <- function(sampler, y, x, log = FALSE, ...) {
    stop("À compléter")
}

rand.mhsampler <- function(sampler, n, init = 0.0, ...) {
    stop("À compléter")
}
