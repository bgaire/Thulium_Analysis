function [exc_lambda, spec] = process_fluorescence(in_directory, in_filename, in_glob, process_fcn)

exc_lambda_read = sscanf(in_filename, in_glob);

if length(exc_lambda_read) > 1
	num_digits = floor(log(exc_lambda_read(2)+0.0001)/log(10))+1;
	exc_lambda = exc_lambda_read(1)+10^(-num_digits)*exc_lambda_read(2);
elseif ~isempty(exc_lambda_read)
	exc_lambda = exc_lambda_read(1);
else
	error('Can''t parse the file named ''%s'' using pattern ''%s''\n', in_filename, in_glob)
end

M = process_fcn([in_directory in_filename]);
spec = M(:,2)';