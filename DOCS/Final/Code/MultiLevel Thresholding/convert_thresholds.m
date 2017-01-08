
function thresholds = convert_thresholds(population, n_thresholds)

    thresholds = [];
    population_size = size(population, 1);
    
    for i = 1:population_size
        thresholds = [thresholds; threshold_bin2dec(population(i,:), n_thresholds)];
	end
