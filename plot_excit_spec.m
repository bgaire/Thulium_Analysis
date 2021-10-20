function [out_lambda, out_spec] = plot_excit_spec(bg, lambdas, specs, range)

sum_range = bg.quiet & (bg.obs_lambda > range(1)) & (bg.obs_lambda < range(2));

out_lambda = lambdas;
out_spec = sum(specs(:,sum_range),2) - sum(bg.bg(sum_range));

plot(out_lambda, out_spec);