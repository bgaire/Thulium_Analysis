path_root = 'C:\Users\cparker60/Documents/Binod_Shared/2018 Thulium Experiment/June 2018 Data/20180618/';

master_bg = process_bg([path_root 'background_noLight_06182018.csv']);

[exc_micrometer, specs] = process_pattern(path_root, 'neonFluorescence*in.csv', 'neonFluorescence_%*dnm_%d');
[exc_micrometer, sort_order] = sort(exc_micrometer);
specs = specs(sort_order,:);

power_data = xlsread([path_root 'powerMeterMeasurement_0618.xlsx'],'Sheet1','A2:E35');

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

figure(1);
plot_spec_2d(clean_bg, exc_lambdas, 10/log(10)*log(specs_clean), [500 1100]);
xlim([530 800]);
ylim([min(exc_lambdas) max(exc_lambdas)]);
title('2D Spectra 20180618 (power normalized, bg subtracted, bad pixels removed), Tm in Ne (dB, arb)');
colorbar;
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[6.5 4]);
set(gcf,'PaperUnits','inches');
print('-dpng', '20180618_2D_spec.png');

figure(3);
view_wavelength = 575;
plot_spec_sub(master_bg,specs(round(interp1(exc_lambdas,1:length(exc_lambdas),view_wavelength)),:));
set(gca,'LineWidth',1.5);
my_plot = get(gca,'Children');
set(my_plot(1),'LineWidth',1.5);
xlim([550 800]);
title(sprintf('Spectrum with excitation at %d nm, %.1f mW total',view_wavelength,interp1(exc_lambdas,exc_power,view_wavelength)));
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[6.5 4]);
set(gcf,'PaperUnits','inches');
print('-dpng', '20180618_single_spec.png');