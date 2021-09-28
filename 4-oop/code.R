source("../utils.R")
options(repr.plot.width = 10, repr.plot.height = 10)

p1 <- c(1, 2)
class(p1) <- c("point", "numeric")

p2 <- c(1, 2)
attributes(p2) <- list(class = c("point", "numeric"))

p3 <- structure(c(3, 4), class = c("point", "numeric"))

point <- function(v){
    v <- as.numeric(v)
    
    stopifnot(identical(length(v), 2L))

    structure(v, class = c("point", class(v)))
}

point(1:3)

point(letters[1:2])

point(1:2)

formals(print)

print.point <- function(x, ...)
    cat("x = ", x[1], "& y = ", x[2], "\n")

summary.point <- function(object, ...){
    cat("Point de coordonnées ")
    print(object)
}

p1

summary(p1)

summary(cars)

summary(lm(dist ~ speed, cars))

body(summary)

v1 <- structure(c(1, 2), class = c("vec", "numeric"))

summary.vec

summary.numeric

methods(summary)

summary(v1)

summary.default(v1)

isaligned.point <- function(...) {
    points <- list(...)
    
    isTRUE(length(points) <= 2) && return(TRUE)
    
    fit <- crossprod(
        solve(cbind(1, c(points[[1]][1], points[[2]][1]))),
        c(points[[1]][2], points[[2]][2]))
    
    for (p in points[-(1:2)]) {
        pred <- crossprod(c(1, p[1]), fit)[1]
        
        isTRUE(all.equal(pred, p[2])) || return(FALSE)
    }
    
    TRUE
}

isaligned.point(point(1:2), point(3:4), point(5:6))

isaligned.point(point(1:2), point(3:4), point(c(5, 7)))

isaligned <- function(...) UseMethod("isaligned")

isaligned(point(1:2), point(5:6), point(9:10))

isaligned(point(1:2), point(5:6), point(c(9, 11)))

pointM <- function(v, mark = NULL) {
    stopifnot(is.null(mark) ||
              (is.character(mark) && identical(length(mark), 1L)))
    
    p <- point(v)
    attr(p, "mark") <- mark
    
    structure(p, class = c("pointM", class(p)))
}

p1 <- pointM(1:2, "Premier point")
p2 <- pointM(3:4, "Second point")
p3 <- pointM(5:6, "Troisième point")

p1

summary(p2)

isaligned(p1, p2, p3)

mark.pointM <- function(point) {
    print(attr(point, "mark"))
}

mark <- function(point) UseMethod("mark")

mark(p1)

mark(p1) <- "1er point"

`mark<-.pointM` <- function(point, value) {
    attr(point, "mark") <- value
    
    point
}

`mark<-` <- function(point, value) UseMethod("mark<-")

mark(p1)

mark(p1) <- "1er point"

mark(p1)

print.pointM <- function(x, ...) {
    print.point(x)
    cat(mark(x), "\n")
}

print(p1)

summary(p2)
