function out_group = read_group(name_format, var_name)

if nargin < 2
	var_name = 'datas';
end

min_data_len = 0;
% count the number of available files
a = 1;
while true
	this_name = sprintf(name_format,a);
	my_ls = dir(this_name);
	if any(~[my_ls.isdir])
		a = a + 1;
	else
		break;
	end
end

% a = num_files + 1

if a > 1
	this_name = sprintf(name_format,1);
	loader = load(this_name);
	out_group(1,:) = loader.(var_name)(:);
	base_len = size(out_group,2);
	for b = 2:(a-1)
		this_name = sprintf(name_format,b);
		loader = load(this_name);
		new_len = numel(loader.(var_name));
		if new_len >= base_len
			out_group(b,:) = loader.(var_name)((end+1-base_len):end);
		else
			out_group(b,(base_len-new_len+1):end) = loader.(var_name)(:);
		end
	end
else
	% no files!
	out_group = [];
end
