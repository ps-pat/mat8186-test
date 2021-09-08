autocor1 <- function(x) {
    covraiance <- numeric(length(x))
    norm <- numeric(1)

    x <- scale(x)
    covariance <- crossprod(x, c(x[-1], x[1]))
    norm <- crossprod(x)

    covariance / norm
}

set.seed(42)
autocor1(rnorm(1000))

library(purrr)

autoCor1_fun <- compose(
    function(x) crossprod(x, c(x[-1], x[1])) / crossprod(x),
    scale)

set.seed(42)
autoCor1_fun(rnorm(1000))

add1 <- function(x) x + 1
add1()

formals(add1) <- pairlist(x = 42)
add1()

v <- structure(1:5, class = c("monvecteur", "integer"))

summary.monvecteur <- function(x, ...) { 
        cat("Je suis le vecteur de Patrick!!!\n")
        NextMethod()
}
  
summary(v)

n <- 1000L

set.seed(666L)
sims <- replicate(n,
                  expr = lm(dist ~ I(speed + rnorm(50L)) - 1, cars),
                  simplify = FALSE)
β <- sapply(sims, coef)

wilcox.test(β, mu = coef(lm(dist ~ speed - 1, cars)))
