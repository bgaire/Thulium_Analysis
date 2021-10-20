function plot_spec_2d(bg, exc_lambda, specs, range)

plot_range = bg.quiet & (bg.obs_lambda > range(1)) & (bg.obs_lambda < range(2));

[x, y] = meshgrid(bg.obs_lambda(plot_range), exc_lambda);

surf(x,y,zeros(size(x)),specs(:,plot_range),'FaceColor','interp','EdgeColor','none');
view(2);
xlabel('\lambda_{obs} (nm)');
ylabel('\lambda_{exc} (nm)');