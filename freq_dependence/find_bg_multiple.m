function [out_coeffs, out_bg, true_freqs] = find_bg_multiple(in_data, target_freqs, filter_width)

if nargin < 3
	filter_width = 2;
end

in_data = in_data(:);
in_x = (0:(numel(in_data)-1))';

true_freqs = target_freqs;

fit_mtx = zeros(numel(in_x),2*length(target_freqs));

for a = 1:length(target_freqs)
	true_freqs(a) = find_bg(in_data, target_freqs(a), filter_width);
	fit_mtx(:,2*a-1) = cos(in_x*2*pi/numel(in_x)*true_freqs(a));
	fit_mtx(:,2*a) = sin(in_x*2*pi/numel(in_x)*true_freqs(a));
end

out_coeffs = fit_mtx\in_data;
if nargout >= 2
	out_bg = (fit_mtx*(out_coeffs));
end
out_coeffs = out_coeffs';