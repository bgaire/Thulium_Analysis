function [exc_lambdas, specs] = process_pattern(in_directory, in_simple_glob, in_fancy_glob, process_fcn)

dir_matches = ls([in_directory in_simple_glob]);

if nargin < 4
	process_fcn = @csvread;
	if nargin < 3
		in_fancy_glob = strrep(in_simple_glob,'*','%ddot%d');
	end
end

if isempty(dir_matches)
	exc_lambdas = [];
	specs = [];
else
	exc_lambdas = zeros(size(dir_matches,1),1);
	[exc_lambdas(1), specs] = process_fluorescence(in_directory,dir_matches(1,:),in_fancy_glob, process_fcn);
	specs(2:size(dir_matches,1),:) = 0;
	for a = 2:size(dir_matches,1)
		[exc_lambdas(a), specs(a,:)] = process_fluorescence(in_directory,dir_matches(a,:),in_fancy_glob, process_fcn);
	end
end