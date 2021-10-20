function spec_clean = plot_spec_sub(in_bg, in_spec, actually_plot)

if nargin < 3
	actually_plot = true;
end

spec_clean = in_spec(in_bg.quiet)-in_bg.bg(in_bg.quiet);
spec_clean(spec_clean < 1E-7) = 1E-7;

if actually_plot
	plot(in_bg.obs_lambda(in_bg.quiet), 10/log(10)*log(spec_clean));
end