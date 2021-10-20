hold off;
a_limit = length(results.data_1_31.wog_exc_lambdas);
for a = 1:a_limit
	plot_spec(results.data_1_31,results.data_1_31.wog_specs(a,:));
	ylim([0 5E-3]);xlim([600 700]);
	title(sprintf('%d nm', results.data_1_31.wog_exc_lambdas(a)));
	%pause;
	hold all;
end
clear a a_limit;
hold off;
title('Fluorescence curves without goggles (a.u.)');