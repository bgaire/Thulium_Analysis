path_root = 'C:\Users\cparker60/Documents/Binod_Shared/2018 Thulium Experiment/June 2018 Data/20180624/';

data_subdir = [path_root '15 mW excitation Power/'];

master_bg = process_bg([path_root 'background_20180624.csv']);

[exc_lambda, specs] = process_pattern(data_subdir, 'neonThulium*15mW.csv', 'neonThulium_%dnm');
[exc_lambda, sort_order] = sort(exc_lambda);
specs = specs(sort_order,:);

specs_clean = zeros(length(exc_lambda),sum(master_bg.quiet));
for a = 1:length(exc_lambda)
	specs_clean(a,:) = plot_spec_sub(master_bg,specs(a,:),false);
end

clean_bg = master_bg;
clean_bg.obs_lambda = master_bg.obs_lambda(master_bg.quiet);
clean_bg.quiet = true(size(clean_bg.obs_lambda));

%specs_clean = diag(1./exc_power)*specs_clean;

figure(1);
plot_spec_2d(clean_bg, exc_lambda, 10/log(10)*log(specs_clean), [530 800]);
xlim([530 800]);
ylim([min(exc_lambda) max(exc_lambda)]);
title('2D Spectra 20180624, Tm in Ne (dB, arb)');
colorbar;
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[6.5 4]);
set(gcf,'PaperUnits','inches');
print('-dpng', '20180624_2D_spec.png');

figure(2);
obs_range = [591.5 592.5];
in_range = clean_bg.obs_lambda <= obs_range(2) & clean_bg.obs_lambda >= obs_range(1);
lambda_limit = exc_lambda < 587;
plot(exc_lambda(lambda_limit),sum(specs_clean(lambda_limit,in_range),2));
hold all;
obs_range = [595 600];
in_range = clean_bg.obs_lambda <= obs_range(2) & clean_bg.obs_lambda >= obs_range(1);
plot(exc_lambda(lambda_limit),sum(specs_clean(lambda_limit,in_range),2));
hold off;
xlim([560 610]);
xlabel('\lambda_{exc} (nm)');
ylabel('Fluorescence (arb).');
title('Tm:Ne Fluorescence 590-600 nm vs excitation');
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[6.5 4]);
set(gcf,'PaperUnits','inches');
print('-dpng', '20180624_single_spec_595.png');

figure(3);
obs_range = [663 667];
in_range = clean_bg.obs_lambda <= obs_range(2) & clean_bg.obs_lambda >= obs_range(1);
lambda_limit = isfinite(exc_lambda);
plot(exc_lambda(lambda_limit),sum(specs_clean(lambda_limit,in_range),2));
hold off;
xlim([560 610]);
xlabel('\lambda_{exc} (nm)');
ylabel('Fluorescence (arb).');
title('Tm:Ne Fluorescence 663-667 nm vs excitation');
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[6.5 4]);
set(gcf,'PaperUnits','inches');
print('-dpng', '20180624_single_spec_665.png');

figure(4);
view_wavelength = 571;
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
print('-dpng', '20180624_single_spec_571e.png');