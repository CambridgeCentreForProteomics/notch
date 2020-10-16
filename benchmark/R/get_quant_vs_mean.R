get_quant_vs_mean <- function(psm){

  psm <- update_average_sn(psm)

  mean_1 <- exprs(psm)[,pData(psm)$condition==1] %>% rowMeans(na.rm=TRUE) %>% data.frame()
  mean_2 <- exprs(psm)[,pData(psm)$condition==2] %>% rowMeans(na.rm=TRUE) %>% data.frame()
  mean_6 <- exprs(psm)[,pData(psm)$condition==6] %>% rowMeans(na.rm=TRUE) %>% data.frame()

  keep_features <- c('species', 'Isolation.Interference.in.Percent', 'Percolator.q.Value',
                     'Average.Reporter.SN', 'Delta.Score')

  psm_fdata <- fData(psm)[,keep_features]

  quant_vs_mean <- psm %>%
    exprs() %>%
    data.frame() %>%
    tibble::rownames_to_column('id') %>%
    pivot_longer(-id, names_to='tag', values_to='intensity') %>%
    mutate(tag=remove_x(tag)) %>%
    filter(is.finite(intensity)) %>%
    merge(pData(psm), by.x='tag', by.y='row.names') %>%
    merge(psm_fdata, by.x='id', by.y='row.names') %>%
    merge(mean_1, by.x='id', by.y='row.names') %>%
    merge(mean_2, by.x='id', by.y='row.names') %>%
    merge(mean_6, by.x='id', by.y='row.names')

  colnames(quant_vs_mean)[(ncol(quant_vs_mean)-2):ncol(quant_vs_mean)] <- c(
    'mean_1', 'mean_2', 'mean_6')

  quant_vs_mean_annt <- quant_vs_mean  %>%
    mutate(below_notch=intensity<5.5) %>%
    mutate(diff_1=log2(intensity/mean_1),
           diff_2=log2(intensity/mean_2),
           diff_6=log2(intensity/mean_6))  %>%
    pivot_longer(cols=c(diff_1, diff_2, diff_6), names_to='reference', values_to='diff') %>%
    mutate(comparison=recode(factor(interaction(reference, condition)),
                             'diff_1.2'='2 vs 1',
                             'diff_1.6'='6 vs 1',
                             'diff_2.1'='1 vs 2',
                             'diff_2.6'='6 vs 2',
                             'diff_6.1'='1 vs 6',
                             'diff_6.2'='2 vs 6')) %>%
    filter(!grepl('diff', comparison))
  quant_vs_mean_annt

}
