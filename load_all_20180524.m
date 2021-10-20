path_root = 'C:\Users\cparker60/Documents/Binod_Shared/2018 Thulium Experiment/May 2018 Data/20180524/';

master_bg = process_bg([path_root 'fluorescence_signal.csv']);

[exc_lambdas, specs] = process_pattern(path_root, 'fluorescence_signal_*nm.csv','fluorescence_signal_%d');
[exc_lambdas, sort_order] = sort(exc_lambdas);
specs = specs(sort_order,:);

specs_clean = zeros(length(exc_lambdas),sum(master_bg.quiet));
for a = 1:length(exc_lambdas)
	specs_clean(a,:) = plot_spec_sub(master_bg,specs(a,:),false);
end

clean_bg = master_bg;
clean_bg.obs_lambda = master_bg.obs_lambda(master_bg.quiet);
clean_bg.quiet = true(size(clean_bg.obs_lambda));

figure(1);
plot_spec_2d(clean_bg, exc_lambdas, 10/log(10)*log(specs_clean), [500 1100]);
xlim([530 1000]);
ylim([570 595]);
title('2D Spectra (bg subtracted, bad pixels removed), Tm in Ar (dB, arb)');
colorbar;
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[6.5 4]);
set(gcf,'PaperUnits','inches');
print('-dpng', '20180524_2D_spec.png');