path_root = 'C:\Users\cparker60/Documents/Binod_Shared/2018 Thulium Experiment/June 2018 Data/20180619/';

master_bg = process_bg([path_root 'background_20180619.csv']);

[exc_micrometer, specs] = process_pattern(path_root, 'neonFluorescence*19.csv', 'neonFluorescence_%*dnm_%d');
[exc_micrometer, sort_order] = sort(exc_micrometer);
specs = specs(sort_order,:);

power_data = xlsread([path_root 'powerMeter_20180619.xlsx'],'Sheet1','A2:F25');

specs_clean = zeros(length(exc_micrometer),sum(master_bg.quiet));
for a = 1:length(exc_micrometer)
	specs_clean(a,:) = plot_spec_sub(master_bg,specs(a,:),false);
end

clean_bg = master_bg;
clean_bg.obs_lambda = master_bg.obs_lambda(master_bg.quiet);
clean_bg.quiet = true(size(clean_bg.obs_lambda));

exc_lambdas = interp1(power_data(:,1),power_data(:,2),exc_micrometer/1000);
exc_power = interp1(power_data(:,1),power_data(:,3),exc_micrometer/1000);

specs_clean = diag(1./exc_power)*specs_clean;

figure(2);
plot_spec_2d(clean_bg, exc_lambdas, 10/log(10)*log(specs_clean), [500 1100]);
xlim([530 800]);
ylim([min(exc_lambdas) max(exc_lambdas)]);
title('2D Spectra 20180619 (power normalized, bg subtracted, bad pixels removed), Tm in Ne (dB, arb)');
colorbar;
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[6.5 4]);
set(gcf,'PaperUnits','inches');
print('-dpng', '20180619_2D_spec.png');