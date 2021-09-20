fact <- function(x) {
    x <= 1.0 && return(x)

    x * fact(x - 1.0)
}

fact(6)

## Retourne la probabilité théorique d'être malade.
y.th <- function(sexe, mutation){
    ## sexe: Sexe (0 = F, 1 = M).
    ## mutation: Possède la mutation (0 = Non, 1 = Oui).

    ## On s'assure que tous les arguments sont valides.
    if(mutation != 0)
        mutation <- 1
    if(sexe != 0)
        sexe <- 1

    ## Pr(Y = 1 | sexe, mutation)
    1 - 1 / (1 + 1.1 * 1.5^sexe * 2^mutation)
}

rmaladie <- function(n){
    ## n: Nombre de cas à générer.

    ##On s'assure de la validité de n.
    if(n < 1)
        n <- 1
    n <- floor(n)
    
    s <- runif(n) # Sexe (0 = F, 1 = M).
    m <- runif(n) # Possède la mutation (0 = Non, 1 = Oui).
    y <- runif(n) # Malade (0 = Non, 1 = Oui).

    ## On détermine le sexe de chaque individu, s'il est
    ## porteur de la mutation et s'il est malade.
    for(i in 1:n){
        ## Sexe
        if(s[i] < 0.5)
            s[i] <- 0
        else
            s[i] <- 1

        ## Mutation
        if(m[i] < 0.75)
            m[i] <- 0
        else
            m[i] <- 1

        ## Malade
        if(y[i] <  1 - y.th(s[i], m[i]))
            y[i] <- 0
        else
            y[i] <- 1
    }

    r <- as.data.frame(cbind(s, m, y))
    colnames(r) <- c("Sexe", "Mutation", "Malade")
    return(r)
}

rmaladie(10)

cutVector <- function(vec, m) {
  n <- length(vec) / m
  lapply(0:(m - 1),
          \(x) vec[seq(n * x + 1, n * (x + 1))])
}

dist0 <- function(m, n = 1e4){
  dat <- sample(0:9, size = n * m, replace = TRUE)
  dat_chopped <- cutVector(dat, m)
  
  sapply(dat_chopped, \(v) mean(v == 0))
}

lmFast <- function(m){
    res <- numeric()

    for (kk in 1:m){
        random_values <- rnorm(1e6)
        X <- matrix(random_values, ncol = 20)
        X <- cbind(1, X)
        y <- rnorm(5e4)
        
        qrX <- qr(X)
        β <- qr.coef(qrX, y)
        res <- cbind(res, β)
    }
    rownames(res) <- c("(Intercept)", paste0("X", 1:20))
    res
}

lmSlow <- function(m){
    Xs <- rnorm(1e6 * m) |>       ## Génération des données.
        cutVector(m) |>           ## 1 entrée = 1 simulation.
        lapply(matrix, ncol = 20) ## vecteur -> matrice.

    ys <- cutVector(rnorm(5e4 * m), m)

    mapply(\(X, y) coef(lm(y ~ X)), Xs, ys)
}

system.time(lmSlow(20))

system.time(lmFast(20))

library(microbenchmark)

mb <- microbenchmark(lmSlow(10), lmFast(10), times = 20)
print(mb)

autoplot(mb)
