function bg = process_bg(in_file, in_cut, process_fcn)

if nargin < 3
	process_fcn = @csvread;
end

M = process_fcn(in_file);

bg.obs_lambda = M(:,1)';
bg.bg = M(:,2)';
bg_sort = sort(bg.bg);
if nargin < 2
	bg.cut = bg_sort(round(numel(bg_sort)*0.75));
else
	bg.cut = in_cut;
end
bg.quiet = bg.bg < bg.cut;