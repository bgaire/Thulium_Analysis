function [out_freq, out_bg] = find_bg(in_data, target_freq, filter_width)

if nargin < 3
	filter_width = 2;
end

my_sinewave = @(x,xdata) x(1)*cos(2*pi*xdata*x(3)/numel(xdata))+x(2)*sin(2*pi*xdata*x(3)/numel(xdata));

in_data = in_data(:)';
in_x = 0:(numel(in_data)-1);
fft_data = fft(in_data-mean(in_data));
fft_filter = exp(-2*(in_x-target_freq).^2/filter_width^2)+exp(-2*(in_x-numel(in_data)+target_freq).^2/filter_width^2);
fft_filter = fft_filter/max(fft_filter);

filtered_in = ifft(fft_data.*fft_filter);

%plot(in_x,in_data,in_x,filtered_in);
%disp('Filtering');
%pause;

options = optimoptions(@lsqcurvefit,'Display','none');
my_fit = lsqcurvefit(my_sinewave, [max(filtered_in) max(filtered_in) target_freq],in_x,filtered_in,[],[],options);
%plot(in_x,filtered_in,in_x,my_sinewave(my_fit,in_x));
%disp('Fitting');

out_freq = my_fit(3);
if nargout >= 2
	out_bg = my_sinewave(my_fit,in_x);
end

