figure(21);
all_spec_2_2_wog;

figure(22);
[~] = plot_excit_spec(results.data_2_2, results.data_2_2.wog_exc_lambdas, results.data_2_2.wog_specs, [604 610]);
title('2-2 without goggles obs. at 604-610');
xlabel('\lambda_{exc} (nm)');
xlim([565 600]);ylim([0 1].*ylim());

figure(23);
[~] = plot_excit_spec(results.data_2_2, results.data_2_2.wog_exc_lambdas, results.data_2_2.wog_specs, [610 616]);
title('2-2 without goggles obs. at 610-616');
xlabel('\lambda_{exc} (nm)');
xlim([565 600]);ylim([0 1].*ylim());

figure(24);
[~] = plot_excit_spec(results.data_2_2, results.data_2_2.wog_exc_lambdas, results.data_2_2.wog_specs, [680 690]);
title('2-2 without goggles obs. at 680-690');
xlabel('\lambda_{exc} (nm)');
xlim([565 600]);ylim([0 1].*ylim());

figure(25);
plot_spec_2d(results.data_2_2, results.data_2_2.wog_exc_lambdas,results.data_2_2.wog_specs, [580 700]);
caxis([0 1E-2]);
title('2D spectra with goggles 2-2');

figure(26);
all_spec_2_2_narrow;

figure(27);
range_594 = abs(results.data_2_2.wog_exc_lambdas_narrow - 594) < 1.5;
plot_spec_2d(results.data_2_2, results.data_2_2.wog_exc_lambdas_narrow(range_594),results.data_2_2.wog_specs_narrow(range_594,:), [580 700]);
caxis([0 5E-2]);
title('2D spectra without goggles near 594 2-2');

figure(28);
range_603 = abs(results.data_2_2.wog_exc_lambdas_narrow - 603) < 1.5;
range_603(end) = false;
plot_spec_2d(results.data_2_2, results.data_2_2.wog_exc_lambdas_narrow(range_603),results.data_2_2.wog_specs_narrow(range_603,:), [580 700]);
caxis([0 5E-2]);
title('2D spectra without goggles 2-2 near 603');

figure(29);
[~] = plot_excit_spec(results.data_2_2, results.data_2_2.wog_exc_lambdas_narrow(range_594), results.data_2_2.wog_specs_narrow(range_594,:), [600 604]);
title('2-2 without goggles narrow obs. at 600-604');
xlabel('\lambda_{exc} (nm)');
ylim([0 1].*ylim());

figure(30);
[~] = plot_excit_spec(results.data_2_2, results.data_2_2.wog_exc_lambdas_narrow(range_594), results.data_2_2.wog_specs_narrow(range_594,:), [587 590]);
title('2-2 without goggles narrow obs. at 587-590');
xlabel('\lambda_{exc} (nm)');
ylim([0 1].*ylim());

figure(31);
[~] = plot_excit_spec(results.data_2_2, results.data_2_2.wog_exc_lambdas_narrow(range_594), results.data_2_2.wog_specs_narrow(range_594,:), [680 690]);
title('2-2 without goggles narrow obs. at 680-690');
xlabel('\lambda_{exc} (nm)');
ylim([0 1].*ylim());

figure(32);
[~] = plot_excit_spec(results.data_2_2, results.data_2_2.wog_exc_lambdas_narrow, results.data_2_2.wog_specs_narrow, [680 690]);
hold all;
[~] = plot_excit_spec(results.data_2_2, results.data_2_2.wog_exc_lambdas, results.data_2_2.wog_specs, [680 690]);
hold off;
title('2-2 without goggles all obs. at 680-690');
xlabel('\lambda_{exc} (nm)');
ylim([0 1].*ylim());

for a = 21:32
	figure(a);
	set(gcf,'WindowStyle','Docked');
	set(gcf,'PaperUnits','inches');
	set(gcf,'PaperSize',[5 5]);
	set(gcf,'PaperPosition',[0 0 5 5]);
	if ~ismember(a, [25 27 28])
		print('-dpdf',sprintf('fig%d.pdf',a));
	end
	print('-dpng',sprintf('fig%d.png',a));
end