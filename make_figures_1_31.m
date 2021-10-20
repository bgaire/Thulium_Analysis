figure(1);
all_spec_1_31;

figure(2);
[~] = plot_excit_spec(results.data_1_31, results.data_1_31.wg_exc_lambdas, results.data_1_31.wg_specs, [604 610]);
title('1-31 with goggles obs. at 604-610');
xlabel('\lambda_{exc} (nm)');
xlim([565 600]);ylim([0 1].*ylim());

figure(3);
[~] = plot_excit_spec(results.data_1_31, results.data_1_31.wg_exc_lambdas, results.data_1_31.wg_specs, [610 616]);
title('1-31 with goggles obs. at 610-616');
xlabel('\lambda_{exc} (nm)');
xlim([565 600]);ylim([0 1].*ylim());

figure(4);
[~] = plot_excit_spec(results.data_1_31, results.data_1_31.wg_exc_lambdas, results.data_1_31.wg_specs, [680 690]);
title('1-31 with goggles obs. at 680-690');
xlabel('\lambda_{exc} (nm)');
xlim([565 600]);ylim([0 1].*ylim());

figure(5);
plot_spec_2d(results.data_1_31, results.data_1_31.wg_exc_lambdas,results.data_1_31.wg_specs, [600 700]);
caxis([0 1E-3]);
title('2D spectra with goggles');

figure(6);all_spec_1_31_wog;

figure(7);
[~] = plot_excit_spec(results.data_1_31, results.data_1_31.wog_exc_lambdas(1:(end-2)), results.data_1_31.wog_specs(1:(end-2),:), [604 610]);
title('1-31 without goggles obs. at 604-610');
xlabel('\lambda_{exc} (nm)');
xlim([565 600]);ylim([0 1].*ylim());

figure(8);
[~] = plot_excit_spec(results.data_1_31, results.data_1_31.wog_exc_lambdas(1:(end-2)), results.data_1_31.wog_specs(1:(end-2),:), [610 616]);
title('1-31 without goggles obs. at 610-616');
xlabel('\lambda_{exc} (nm)');
xlim([565 600]);ylim([0 1].*ylim());

figure(9);
[~] = plot_excit_spec(results.data_1_31, results.data_1_31.wog_exc_lambdas, results.data_1_31.wog_specs, [680 690]);
title('1-31 without goggles obs. at 680-690');
xlabel('\lambda_{exc} (nm)');
xlim([565 600]);ylim([0 1].*ylim());

figure(10);
plot_spec_2d(results.data_1_31, results.data_1_31.wog_exc_lambdas,results.data_1_31.wog_specs, [580 700]);
caxis([0 1E-2]);
ylim([565 600]);
title('2D spectra without goggles');

for a = 1:0
	figure(a);
	set(gcf,'WindowStyle','Docked');
	set(gcf,'PaperUnits','inches');
	set(gcf,'PaperSize',[5 5]);
	set(gcf,'PaperPosition',[0 0 5 5]);
	if mod(a,5) ~= 0
		print('-dpdf',sprintf('fig%d.pdf',a));
	end
	print('-dpng',sprintf('fig%d.png',a));
end