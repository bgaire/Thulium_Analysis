hold off;
a_limit = length(results.data_1_31.wg_exc_lambdas)-6;
for a = 1:a_limit
	plot_spec(results.data_1_31,results.data_1_31.wg_specs(a,:));
	ylim([0 1E-3]);xlim([600 700]);
	title(sprintf('%d nm', results.data_1_31.wg_exc_lambdas(a)));
	%pause;
	hold all;
end
clear a a_limit;
hold off;
title('Fluorescence curves with goggles (a.u.)');