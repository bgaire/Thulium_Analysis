hold off;
a_limit = length(results.data_2_2.wog_exc_lambdas);
for a = 1:a_limit
	plot_spec(results.data_2_2,results.data_2_2.wog_specs(a,:));
	ylim([0 5E-3]);xlim([600 700]);
	title(sprintf('%d nm', results.data_2_2.wog_exc_lambdas(a)));
	%pause;
	hold all;
end
clear a a_limit;
hold off;
title('Fluorescence curves without goggles (2-2) (a.u.)');