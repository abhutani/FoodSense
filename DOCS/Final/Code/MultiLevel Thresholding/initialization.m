
function population = initialization(n_population, n_bins, n_thresholds)

     population = round(unifrnd(0, 1, [n_population ceil(log2(n_bins))*n_thresholds]));
