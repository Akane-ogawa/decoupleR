
# ===== 変数やディレクトリの設定 =====

kin_result <- read.csv("../results/tables/decoupleR_kin.csv", row.names = 1)
save_plots_here <- "../results/figures/kin_lineplot/"
lineplot_color <- "#CC79A7"
kins_to_plot <- c("IKBKB", "MAPK1", "MAPK3", "MAPK8", "MAPK9")

# ====================================

library(tidyverse)
library(dplyr)
library(ggplot2)


# Data shaping 
kin_result_2 <- cbind(rownames(kin_result), kin_result) 
kin_result_2 <- kin_result_2 %>% 
  pivot_longer(cols = 2:ncol(kin_result_2),
               names_to = "time", 
               values_to = "score")
colnames(kin_result_2) <- c("kin", "time", "score")
kin_result_2$time <- as.numeric(gsub("^X", "", kin_result_2$time))


# Draw line plots
for (i in 1:length(kins_to_plot)) {
  kin_i <- kins_to_plot[i]
  data_to_draw <- kin_result_2 %>% filter(kin == kin_i)
  # ヒットしたら描画
  if(nrow(data_to_draw) != 0){
    data_to_draw <- data_to_draw[order(data_to_draw$time), ]
    time0 <- data_to_draw$score[1]
    data_to_draw$score <- data_to_draw$score - time0
    
    plot <- ggplot(data_to_draw, aes(x = time, y = score))+
      geom_line(colour = lineplot_color, linewidth = 1.2) + 
      geom_point(colour = lineplot_color, size = 2.0) +
      geom_hline(yintercept = 0, linetype = "solid")+
      scale_x_continuous(expand = c(0, 0)) +
      # labels
      labs(x = "Time (hour)", y = "TF activity [a.u.]", title = kin_i) +
      theme_bw() +
      theme(
        legend.position = "none",
        axis.title.x = element_text(size = 10),
        axis.title.y = element_text(size = 10),
        plot.title = element_text(size = 18, hjust = 0.5), 
        axis.text.x = element_text(size = 12),  # x軸のメモリの数字のサイズ
        axis.text.y = element_text(size = 12)   # y軸のメモリの数字のサイズ
      )
    #plot(plot)
    
    # ディレクトリが存在しなければ作成
    if (!dir.exists(save_plots_here)) {
      dir.create(save_plots_here, recursive = TRUE)  # recursive = TRUE は親ディレクトリも作る場合
    }
    ggsave(paste0(save_plots_here, kin_i, ".png"),
           plot = plot, width = 2.5, height = 2.5)
    
  }else{}
}


