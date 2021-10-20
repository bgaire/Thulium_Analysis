path_root = 'C:\Users\cparker60/Documents/Binod_Shared/2018 Thulium Experiment/June 2018 Data/20180610/';

bg_1 = process_bg([path_root 'background_beforeNeGrowth.csv']);
bg_2 = process_bg([path_root 'background_with_lasersOff.csv']);

master_bg.obs_lambda = bg_1.obs_lambda;
master_bg.cut = bg_1.cut;
master_bg.quiet = bg_1.quiet&bg_2.quiet;
master_bg.bg = (bg_1.bg+bg_2.bg)/2;

[exc_micrometer, specs] = process_pattern(path_root, 'fluorescence*in.csv', 'fluorescence_%*d_nm_%d');
[exc_micrometer, sort_order] = sort(exc_micrometer);
specs = specs(sort_order,:);

specs_clean = zeros(length(exc_micrometer),sum(master_bg.quiet));
for a = 1:length(exc_micrometer)
	specs_clean(a,:) = plot_spec_sub(master_bg,specs(a,:),false);
end

clean_bg = master_bg;
clean_bg.obs_lambda = master_bg.obs_lambda(master_bg.quiet);
clean_bg.quiet = true(size(clean_bg.obs_lambda));

additional_data1 = xlsread([path_root 'powerMeterMeasurements'],'Sheet1','A3:E37');
additional_data2 = xlsread([path_root 'powerMeterMeasurements'],'Sheet2','A3:B26');

exc_lambdas = interp1(additional_data2(:,1),additional_data2(:,2),exc_micrometer/1000);
exc_power = interp1(additional_data1(:,2),additional_data1(:,3),exc_micrometer/1000);

specs_clean = diag(1./exc_power)*specs_clean;

figure(1);
plot_spec_2d(clean_bg, exc_lambdas, 10/log(10)*log(specs_clean), [500 1100]);
xlim([530 1000]);
ylim([566.67 588.4]);
title('2D Spectra (bg subtracted, bad pixels removed), Tm in Ne (dB, arb)');
colorbar;
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[6.5 4]);
set(gcf,'PaperUnits','inches');
print('-dpng', '20180610_2D_spec.png');