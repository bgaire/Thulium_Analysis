function out_raw_data = ocean_optics_read(in_filename)

marker_str = '<<<<<';

my_fid = fopen(in_filename,'r');
first_data_line = 0;
try
	offsets = [];
	first_line = '';
	while isempty(offsets) && ischar(first_line)
		first_line = fgetl(my_fid);
		first_data_line = first_data_line + 1;
		offsets = strfind(first_line,marker_str);
	end
catch ME
	fclose(my_fid);
	rethrow(ME);
end
fclose(my_fid);

out_raw_data = dlmread(in_filename,'\t',first_data_line+1,0);

