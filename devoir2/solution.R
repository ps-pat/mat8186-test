########################
##     Exercice 1     ##
########################

## (a)
cutVector_loop <- function(vec, m) {
    n <- length(vec) / m

    stop("À modifier")
    lapply(0:(m - 1),
           \(x) vec[seq(n * x + 1, n * (x + 1))])
}

dist0_loop <- function(m, n = 1e4){
    dat <- sample(0:9, size = n * m, replace = TRUE)
    dat_chopped <- cutVector_loop(dat, m)

    stop("À modifier")
    sapply(dat_chopped, \(v) mean(v == 0))
}

## (b)
pdf(stop("À compléter"))
tryCatch(
{
    stop("Votre code ici")
},
finally = dev.off())

## (c)
stop("À compléter")
message("Votre réponse ici!!")

########################
##     Exercice 2     ##
########################

## (a)
cesar <- function(str, key, decode = FALSE) {
    ## On suppose 1 <= `key` <= 100 et `str` alphanumérique.

    if (decode)
        key  <- -key

    raw_str <- as.raw(charToRaw(str))
    ascii_str <- strtoi(raw_str)

    ascii_str_crypt <- ascii_str + key

    rawToChar(as.raw(ascii_str_crypt))
}

## (b)
rpoiplus <- function(n, lambda) {
    ## n : Nombre d'observations à générer.
    ## lambda: Paramètre de la distribution.
    vec <- runif(n) #Vecteur contenant l'échantillon.

    ## efl contient le mode de la distribution (partie entière
    ## de l'espérance).
    ex <- (lambda * exp(lambda)) / (exp(lambda) - 1)
    efl <- floor(ex)

    ## On génère récursivement la répartition jusqu'au mode.
    F <- vector("numeric", 1)
    F[1] <- lambda / (exp(lambda) - 1)
    F[2] <- F[1] + lambda^2 / ((exp(lambda) - 1) * 2)
    max_x_sim <- 2 # Plus grande valeur de x calculée.
    while(max_x_sim < efl){
        p <- F[max_x_sim] - F[max_x_sim - 1]
        F <- append(F, F[max_x_sim] + lambda * p / (max_x_sim + 1))
        max_x_sim <- max_x_sim + 1
    }

    for(i in 1:n){
        if(vec[i] < F[efl]){
            ## On teste à reculon à partir du mode.
            for(k in (efl - 1):1){
                if(vec[i] > F[k]){
                    vec[i] <- k + 1
                    break
                }
            }
            ## Si la valeur de vec[i] n'a pas changée, alors nécessairement
            ## F^-1(vec[i]) = 1.
            if(vec[i] < 1)
                vec[i] <- 1
        }
        else{
            k <- efl + 1
            while(vec[i] < 1){
                ## On s'assure qu'on a assez de valeurs de F.
                if(k > max_x_sim){
                    p <- F[max_x_sim] - F [max_x_sim - 1]
                    F <- append(F, F[max_x_sim] + lambda * p / (max_x_sim + 1))
                    max_x_sim <- max_x_sim + 1
                }
                if(vec[i] <= F[k])
                    vec[i] <- k
                k <- k + 1
            }
        }
    }
    return(vec)
}
