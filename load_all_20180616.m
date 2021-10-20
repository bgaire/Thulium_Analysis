path_root = 'C:\Users\cparker60/Documents/Binod_Shared/2018 Thulium Experiment/June 2018 Data/20180616/';

master_bg = process_bg([path_root 'background_noLight.csv']);

[exc_micrometer, specs] = process_pattern(path_root, 'argonFluorescence*nm.csv', 'argonFluorescence_%dnm');
[exc_micrometer, sort_order] = sort(exc_micrometer);
specs = specs(sort_order,:);

power_data = xlsread([path_root 'powerMeterMeasurement_0616.xlsx'],'Sheet1','A2:C34');

specs_clean = zeros(length(exc_micrometer),sum(master_bg.quiet));
for a = 1:length(exc_micrometer)
	specs_clean(a,:) = plot_spec_sub(master_bg,specs(a,:),false);
end

clean_bg = master_bg;
clean_bg.obs_lambda = master_bg.obs_lambda(master_bg.quiet);
clean_bg.quiet = true(size(clean_bg.obs_lambda));

exc_lambda = exc_micrometer;
clear exc_micrometer;
exc_power = interp1(power_data(:,2),power_data(:,3),exc_lambda);

specs_clean = diag(1./exc_power)*specs_clean;

figure(1);
plot_spec_2d(clean_bg, exc_lambda, 10/log(10)*log(specs_clean), [500 1100]);
xlim([530 800]);
ylim([571 max(exc_lambda)]);
title('2D Spectra 20180618, Tm in Ar with filter (dB, arb)');
colorbar;
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[6.5 4]);
set(gcf,'PaperUnits','inches');
print('-dpng', '20180616_2D_spec.png');

figure(2);
obs_range = [603.5 617];
in_range = clean_bg.obs_lambda <= obs_range(2) & clean_bg.obs_lambda >= obs_range(1);
plot(exc_lambda(4:end),sum(specs_clean(4:end,in_range),2));%first few data points are questionable
xlim([560 610]);
xlabel('\lambda_{exc} (nm)');
ylabel('Fluorescence (arb).');
title('Tm:Ar Fluorescence 603-617 nm vs excitation');
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[6.5 4]);
set(gcf,'PaperUnits','inches');
print('-dpng', '20180616_single_spec_610.png');

figure(3);
obs_range = [681 688];
in_range = clean_bg.obs_lambda <= obs_range(2) & clean_bg.obs_lambda >= obs_range(1);
plot(exc_lambda(4:end),sum(specs_clean(4:end,in_range),2));
xlim([560 610]);
xlabel('\lambda_{exc} (nm)');
ylabel('Fluorescence (arb).');
title('Tm:Ar Fluorescence 681-688 nm vs excitation');
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[6.5 4]);
set(gcf,'PaperUnits','inches');
print('-dpng', '20180616_single_spec_685.png');

figure(4);
view_wavelength = 586;
plot(clean_bg.obs_lambda,10/log(10)*log(specs_clean(round(interp1(exc_lambda,1:length(exc_lambda),view_wavelength)),:)));
%plot_spec_sub(master_bg,specs(round(interp1(exc_lambdas,1:length(exc_lambdas),view_wavelength)),:));
%set(gca,'LineWidth',1.5);
%my_plot = get(gca,'Children');
%set(my_plot(1),'LineWidth',1.5);
xlim([530 800]);
title(sprintf('Spectrum with excitation at %d nm (log scale)',view_wavelength));
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[6.5 4]);
set(gcf,'PaperUnits','inches');
print('-dpng', '20180616_single_spec_586e.png');

figure(5);
view_wavelength = 586;
plot(clean_bg.obs_lambda,specs_clean(round(interp1(exc_lambda,1:length(exc_lambda),view_wavelength)),:));
%plot_spec_sub(master_bg,specs(round(interp1(exc_lambdas,1:length(exc_lambdas),view_wavelength)),:));
%set(gca,'LineWidth',1.5);
%my_plot = get(gca,'Children');
%set(my_plot(1),'LineWidth',1.5);
xlim([595 625]);
title(sprintf('Spectrum with excitation at %d nm',view_wavelength));
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[6.5 4]);
set(gcf,'PaperUnits','inches');
print('-dpng', '20180616_single_spec_586e_zoom.png');