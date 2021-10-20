function results = analyze_Thulium(options)

if nargin < 1
	% replace with appropriate path for faster operation
	options.one_drive_path = 'C:\Users\cparker60\OneDrive-NEW\OneDrive - Georgia Institute of Technology\Parker Lab';
	if numel(ls(options.one_drive_path)) == 0
		options.one_drive_path = uigetdir('/', 'Where is the "Parker Lab" folder on your machine?');
	end
	
	options.sub_folder_1_31 = [options.one_drive_path '/Binod/Cryo/2018 Thulium Experiment/January/20180131/'];
	options.sub_folder_2_2 = [options.one_drive_path '/Binod/Cryo/2018 Thulium Experiment/20180202/'];
	options.sub_folder_2_2n = [options.sub_folder_2_2 'Detailed Scan/'];
end

data_1_31 = process_bg([options.sub_folder_1_31 '1_lightBlocked.csv']);
[data_1_31.wg_exc_lambdas, data_1_31.wg_specs] = process_pattern(options.sub_folder_1_31, '*nm_withGoggles.csv');
[data_1_31.wog_exc_lambdas, data_1_31.wog_specs] = process_pattern(options.sub_folder_1_31, '*nm_withoutGoggles.csv');

results.data_1_31 = data_1_31;

data_2_2 = process_bg([options.sub_folder_2_2 'background.csv']);
[data_2_2.wog_exc_lambdas, data_2_2.wog_specs] = process_pattern(options.sub_folder_2_2, 'noGoggles_*.csv');
[data_2_2.wog_exc_lambdas_narrow, data_2_2.wog_specs_narrow] = process_pattern(options.sub_folder_2_2n, 'noGoggles_*_forFinalPeak.csv');

results.data_2_2 = data_2_2;

results.options = options;



