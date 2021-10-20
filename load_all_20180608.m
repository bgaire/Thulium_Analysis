path_root = 'C:\Users\cparker60/Documents/Binod_Shared/2018 Thulium Experiment/June 2018 Data/20180607/';

bg = process_bg([path_root 'background_duringNeonGrowth.csv']);
bg_1 = process_bg([path_root 'background_1_duringNeonGrowth.csv']);

master_bg.obs_lambda = bg.obs_lambda;
master_bg.cut = bg.cut;
master_bg.quiet = bg_1.quiet&bg.quiet;
master_bg.bg = (bg_1.bg+bg.bg)/2;

bg_ar = process_bg([path_root 'background_afterRemovingThulium_withargon.csv']);

[exc_lambdas, specs] = process_pattern(path_root, 'TmAblation*inch.csv', 'TmAblation_%*d_%*d%*cM_%dnm_');
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
ylim([565 587]);
title('2D Spectra (bg subtracted, bad pixels removed), Tm in Ne (dB, arb)');
colorbar;
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[6.5 4]);
set(gcf,'PaperUnits','inches');
print('-dpng', '20180607_2D_spec.png');

figure(2);
plot(master_bg.obs_lambda(master_bg.quiet),real(10*log(bg_ar.bg(master_bg.quiet)-master_bg.bg(master_bg.quiet))/log(10)));
ylim([-60 0]);
ylabel('Fluorescence (arb, dB)')
xlabel('Wavelength (nm)')
title('Laser BG, 566.6 nm');
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[6.5 4]);
set(gcf,'PaperPosition',[0 0 6.5 4]);
print('-dpng', '20180607_laser_spec.png');