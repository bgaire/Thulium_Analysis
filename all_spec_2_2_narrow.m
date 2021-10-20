hold off;
a_limit = length(results.data_2_2.wog_exc_lambdas_narrow);
for a = 1:a_limit
	plot_spec(results.data_2_2,results.data_2_2.wog_specs_narrow(a,:));
	ylim([0 25E-3]);xlim([600 700]);
	title(sprintf('%d nm', results.data_2_2.wog_exc_lambdas_narrow(a)));
	%pause;
	hold all;
end
clear a a_limit;
hold off;
title('Fluorescence curves without goggles (2-2) narrow (a.u.)');