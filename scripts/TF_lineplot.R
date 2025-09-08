
# ===== 変数やディレクトリの設定 =====

TF_result <- read.csv("../results/tables/decoupleR_TF.csv", row.names = 1) 
save_plots_here <- "../results/figures/TF_lineplot/"
lineplot_color <- "#009E73"
TFs_to_plot <- c("FOS", "JUN", "STAT1", "STAT2", "BCL3", "NFKBIB", "NFKB2")

# ====================================

library(tidyverse)
library(dplyr)
library(ggplot2)


# Data shaping 
TF_result_2 <- cbind(rownames(TF_result), TF_result) 
TF_result_2 <- TF_result_2 %>% 
  pivot_longer(cols = 2:ncol(TF_result_2),
               names_to = "time", 
               values_to = "score")
colnames(TF_result_2) <- c("TF", "time", "score")
TF_result_2$time <- as.numeric(gsub("^X", "", TF_result_2$time))


# Draw line plots
for (i in 1:length(TFs_to_plot)) {
  TF_i <- TFs_to_plot[i]
  data_to_draw <- TF_result_2 %>% filter(TF == TF_i)
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
      labs(x = "Time (hour)", y = "TF activity [a.u.]", title = TF_i) +
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
    ggsave(paste0(save_plots_here, TF_i, ".png"),
           plot = plot, width = 2.5, height = 2.5)
    
  }else{}
}










