library(ggplot2)

theme <- list(ggplot2::theme(plot.margin =
                                 ggplot2::margin(rep(0.0, 4L), "cm"),
                             text = ggplot2::element_text(size = 22.0),
                             panel.background =
                                 ggplot2::element_rect(fill = "#212121"),
                             plot.background =
                                 ggplot2::element_rect(fill = "#212121",
                                                       color = NA),
                             axis.title =
                                 ggplot2::element_text(color = "#ffb74d"),
                             axis.text =
                                 ggplot2::element_text(color = "#39796b")),
              ggplot2::aes(color = "#39796b", fill = "#ffe0b2"),
              ggplot2::scale_color_identity(),
              ggplot2::scale_fill_identity())

autoplot.microbenchmark <- function(object, ..., log = TRUE) {
    if (log)
        object[["time"]] <- log10(object[["time"]])
    object[["ntime"]] <-
        microbenchmark:::convert_to_unit(object[["time"]], "t")

    y_label <- paste0(ifelse(log, "log", ""),
                      sprintf("Time [%s]", attr(object[["ntime"]], "unit")))

    ggplot2::ggplot(object, ggplot2::aes(x = expr, y = ntime)) +
        theme +
        ggplot2::coord_cartesian() +
        ggplot2::geom_violin() +
        ggplot2::scale_x_discrete(name = "Expression") +
        ggplot2::scale_y_continuous(name = y_label) +
        ggplot2::theme(panel.grid.major.x = ggplot2::element_blank())
}
