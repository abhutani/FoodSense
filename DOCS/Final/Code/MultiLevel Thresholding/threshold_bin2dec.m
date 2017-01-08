function dec_thresholds = threshold_bin2dec(bin_thresholds, n_thresholds)

    dec_thresholds = [];
    threshold_length = (size(bin_thresholds, 2)/n_thresholds);

    for i = 1:threshold_length:size(bin_thresholds, 2)
        dec_thresholds = [dec_thresholds, bi2de(bin_thresholds(i:i+threshold_length-1))];
	end
