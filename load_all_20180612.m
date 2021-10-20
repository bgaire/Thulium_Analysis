path_root = 'C:\Users\cparker60/Documents/Binod_Shared/2018 Thulium Experiment/June 2018 Data/20180612/';

ocean_root = [path_root 'fromOceanOptics spectrometer/'];

bg_1 = process_bg([ocean_root 'background.txt'], 1000, @ocean_optics_read);
bg_2 = process_bg([ocean_root 'background_no_light.txt'], 1000, @ocean_optics_read);

master_bg.obs_lambda = bg_1.obs_lambda;
master_bg.cut = bg_1.cut;
master_bg.quiet = bg_1.quiet&bg_2.quiet;
master_bg.bg = (bg_1.bg+bg_2.bg)/2;

% Note: You need to rename the following:
% oceanOptics_140ms_566_7nm_075mW by oceanOptics_140ms_566.7nm_075mw
% oceanOptics_572_nm_45ms by oceanOptics_572_0_nm_45ms
% oceanOptics_573_nm_45ms by oceanOptics_573_0_nm_45ms

[wvl1, specs1] = process_pattern(ocean_root, 'oceanOptics_*ms*nm*mW.txt', 'oceanOptics_%*dms_%f',@ocean_optics_read);
[integ_time1, ~] = process_pattern(ocean_root, 'oceanOptics_*ms*nm*mW.txt', 'oceanOptics_%dms',@ocean_optics_read);

[wvl2, specs2] = process_pattern(ocean_root, 'oceanOptics_*_nm*ms.txt', 'oceanOptics_%d_%d',@ocean_optics_read);
[integ_time2, ~] = process_pattern(ocean_root, 'oceanOptics_*_nm*ms.txt', 'oceanOptics_%*d_%*d_nm_%dms',@ocean_optics_read);

[index3_hour, specs3] = process_pattern(ocean_root, 'USB2G*.txt', 'USB2G%*d_%d',@ocean_optics_read);
[index3_minute, ~] = process_pattern(ocean_root, 'USB2G*.txt', 'USB2G%*d_%*d-%d',@ocean_optics_read);
index3_hour(index3_hour > 12) = index3_hour(index3_hour > 12) - 12;
index3 = index3_hour+index3_minute/100; % not real time units!
index3_good = index3 > 7.29;
index3 = index3(index3_good);
specs3 = specs3(index3_good,:);
integ_time3 = 400*ones(size(index3));
integ_time3(index3 < 7.53) = 45;

powerData = xlsread([path_root 'PowerMeterMeasurement.xlsx'],'Sheet1','A3:G52');

% Now look up the data we need to piece together the wavelength for the
% third set

known_times = isfinite(powerData(:,7));
wvl3 = interp1(powerData(known_times,7),powerData(known_times,2),index3);

exc_lambdas = [wvl1; wvl2; wvl3];
specs = [specs1; specs2; specs3];

specs_clean = zeros(length(exc_lambdas),sum(master_bg.quiet));
for a = 1:length(exc_lambdas)
	specs_clean(a,:) = plot_spec_sub(master_bg,specs(a,:),false);
end

clean_bg = master_bg;
clean_bg.obs_lambda = master_bg.obs_lambda(master_bg.quiet);
clean_bg.quiet = true(size(clean_bg.obs_lambda));

figure(1);
plot_spec_2d(clean_bg, exc_lambdas, 10/log(10)*log(specs_clean), [500 1200]);
%xlim([530 1000]);
%ylim([570 595]);
%title('2D Spectra (bg subtracted, bad pixels removed), Tm in Ar (dB, arb)');
%colorbar;
%set(gcf,'PaperUnits','inches');
%set(gcf,'PaperSize',[6.5 4]);
%set(gcf,'PaperUnits','inches');
%print('-dpng', '20180524_2D_spec.png');