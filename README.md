# sumo

This pachage contains various functions related to statistics, data visualisation, data organisation and image analysis.

Make_project() create a environement with classical folder structures (Data, Figures, Docs, References, Sources, Gist) a mainscript at the root.
If IHC = TRUE, it will create czi folder to store raw images, jpg folder and QP_analysis folder containing a QuPath project for further analyses.

SourceAll() will detect all .R files located in the "Sources" folder and source them as functions.

Comp3Moy() is made to compares means of two or more distributions in a dataset. Based on normality and variance, it will pick the best tests to use and yield the result.

graphsumo() creates graph with ggplot2 made from a scatter plot and violin plot. Median is representated by an horizontal line and mean by a cross. 

save_pheatmap() is a small function to easily save heatmap made with pheatmap in png or pdf is a similar fashion than the ggsave() function.
