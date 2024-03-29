% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sumo_palette.R
\name{sumo_palette}
\alias{sumo_palette}
\alias{sumo_pal}
\title{sumo_palette}
\usage{
sumo_pal(x = 6)
}
\arguments{
\item{x}{number of colour to display, by default 6}
}
\description{
create a palette of colours based on Hokusai wave
}
\examples{

ggplot(iris)+
 aes(x = Species,
     y = Sepal.Length,
     colour = Species)+
 geom_jitter()+
 scale_color_manual(values = sumo_pal())+
 theme_classic()

}
