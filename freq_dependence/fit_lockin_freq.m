function [fit_vals, out_interp_f, out_fit] = fit_lockin_freq(in_freq, in_y, in_guess, type)

if nargin < 4
	type = 1;
end
% type == 1 (default) corresponds with instant recharge, with decay
% type == 2 corresponds with same decay constant for recharge and decay

if type == 1
	fdep_sub = @(x,xdata) x(1)*(1-((2*pi*xdata/x(2)).^2+1i*2*pi*xdata/x(2))./(1+(2*pi*xdata/x(2)).^2).*(1+exp(-x(2)./(2*xdata)))/2);
elseif type ==2
	fdep_sub = @(x,xdata) x(1)*(1-1i*2*pi*xdata/x(2))./(1+(2*pi*xdata/x(2)).^2);
else
	error('Unknown type (valid values: 1 or 2)');
end

fdep = @(x,xdata) fdep_sub(real(x),xdata);

fdep_imag = @(x,xdata) imag(fdep(x,xdata));
fdep_real = @(x,xdata) real(fdep(x,xdata));

out_interp_f = linspace(min(in_freq),max(in_freq),1000);

plot(in_freq,real(in_y),'*b');
hold on;
plot(in_freq,imag(in_y),'*r');
init_guess = fdep(in_guess,out_interp_f);
plot(out_interp_f,real(init_guess),'-b');
plot(out_interp_f,imag(init_guess),'-r');
hold off;
disp('Preparing for fit. Showing initial guess.');
pause;

opts = optimoptions(@lsqcurvefit,'StepTolerance',1E-12);
fit_vals = lsqcurvefit(fdep_imag,in_guess,in_freq,imag(in_y),[-Inf 60],[],opts);

fit_vals= real(fit_vals);

plot(in_freq,real(in_y),'*b');
hold on;
plot(in_freq,imag(in_y),'*r');
out_fit = fdep(fit_vals,out_interp_f);
plot(out_interp_f,real(out_fit),'-b');
plot(out_interp_f,imag(out_fit),'-r');
hold off;

