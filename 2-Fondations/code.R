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

liste_hetero <- list(42, "αβγ", TRUE, list(list(matrix(666, 2, 2))))
liste_hetero

df <- data.frame(var1 = rnorm(5), var2 = letters[1:5], var3 = sample(42:46))
df

head(iris)

is.list(iris)

class(liste_hetero[2])
liste_hetero[2]

class(liste_hetero[[2]])
liste_hetero[[2]]

names(iris)

head(iris[["Species"]])

print_yo <- function() print("Yo!")
print_yo()

is_odd <- function(x) x %% 2 > 0
is_odd(42)

(function(x) 2 * x)(21)

(\(x) x / 2)(84)

is_even <- Negate(is_odd)
is_even(42)

Filter(is_even, 1:10)

lapply(1:10, \(x) 2 * x + 1)

rand_exp <- function(n, θ = 1.0) -θ * log(runif(n))

mean(rand_exp(1e4L))
mean(rand_exp(1e4L, 10))

mysum <- function(..., noise = FALSE) {
    dat <- as.numeric(list(...))
    
    if (noise)
        dat <- dat + rbeta(length(dat), 0.5, 0.5)
    
    sum(dat)
}

mysum(1, 2, 3, 4, 5)
mysum(1, 2, 3, 4, 5, noise = TRUE)

prod_not_42 <- function(x){
    if (42 %in% x)
        return(0)
    
    prod(x)
}

prod_not_42(1:10)

prod_not_42(1:100)

fact <- function(x) {
    identical(x, 1.0) && return(x)
    
    x * fact(x - 1.0)
}

fact(6)

## Sur ma machine, stack overflow pour x > 696.
fact(100.0)

1:100 |>
    Filter(f = \(x) identical(x %% 3L, 0L) | identical(x %% 5L, 0L)) |>
    sqrt() |>
    sum()
