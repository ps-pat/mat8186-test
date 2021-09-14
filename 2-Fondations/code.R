source("../utils.R")
options(repr.plot.width = 10, repr.plot.height = 10)

m <- n <- 1e3L
mat <- matrix(42L, m, n)

double1 <- function() {
    for (i in seq_len(m))
        for (j in seq_len(n))
            mat[i, j] <- mat[i, j] + mat[i, j]
}

double2 <- function() {
    for (j in seq_len(n))
        for (i in seq_len(m))
            mat[i, j] <- mat[i, j] + mat[i, j]
}

library(microbenchmark)

bench <- microbenchmark(double1(), double2(), 2 * mat)

autoplot(bench)

autoplot(subset(bench, expr != "2 * mat"))

vec_integer <- c(1L, 2L, 3L)
vec_double <- c(1.0, 2.0, 3.0)
vec_complexe <- c(1 + 2i, 3 + 4i, 5 + 6i)

is.integer(vec_integer)
is.double(vec_double)
is.complex(vec_complexe)

is.numeric(vec_integer)
is.numeric(vec_double)
is.numeric(vec_complexe)

## Attention!
vec_integer
vec_double
identical(vec_integer, vec_double)

vec_logical <- c(TRUE, FALSE, TRUE)
vec_character <- c("J'αiμε", "beaucoup", "R", "!!!")
vec_raw <- as.raw(c(1, 13, 66, 0x42))

vec_logical
vec_character
vec_raw

is.logical(vec_logical)
is.character(vec_character)
is.raw(vec_raw)

mat <- matrix(c(1, 2, 666, 42), nrow = 2, ncol = 2)
class(mat)
mat


arr <- array(1:2^4, dim = c(2, 2, 4))
class(arr)

vec <- 1:16
class(vec)
vec

dim(vec) <- c(4, 4)
class(vec)
vec

dim(vec) <- c(2, 2, 4)
class(vec)

X <- cbind(1, as.matrix(cars))
head(X)

head(t(X))

tXX <- crossprod(X)
all.equal(t(X) %*% X, tXX)

eigen(tXX)

chol(tXX)
