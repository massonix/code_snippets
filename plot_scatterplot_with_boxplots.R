library(tidyverse)
library(patchwork)
library(ggpubr)
faithful <- mutate(faithful, group = ifelse(eruptions > 3, "A", "B"))
scatterplot <- ggplot(faithful, aes(eruptions, waiting, color = group)) +
  geom_point() +
  geom_density_2d() +
  theme_classic() +
  theme(axis.text = element_blank(), axis.title = element_blank())
legend <- as_ggplot(get_legend(scatterplot))
scatterplot <- scatterplot + theme(legend.position = "none")
boxplot_left <- ggplot(faithful, aes(group, waiting, fill = group)) +
  geom_boxplot() +
  theme_classic() +
  theme(legend.position = "none", axis.ticks.x = element_blank(),
        axis.text.x = element_blank(), axis.title.x = element_blank())
boxplot_bottom <- ggplot(faithful, aes(group, eruptions, fill = group)) +
  geom_boxplot() +
  theme_classic() +
  theme(legend.position = "none", axis.ticks.y = element_blank(),
        axis.text.y = element_blank(), axis.title.y = element_blank()) +
  coord_flip()

top <- wrap_plots(boxplot_left, scatterplot, ncol = 2, widths = c(0.2, 0.8))
bottom <- wrap_plots(legend, boxplot_bottom, ncol = 2, widths = c(0.22, 0.8))
final <- wrap_plots(top, bottom, nrow = 2, heights = c(0.8, 0.2))
final
