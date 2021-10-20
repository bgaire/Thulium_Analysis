function [out_laser_free, out_power] = subtract_laser_bg(wvl, in_clean_spec, guess_wvl, side_distance, in_laser_spec, in_spec_wvl, in_big_range)

good_wvl = (wvl > guess_wvl+side_distance(1)) & (wvl < guess_wvl+side_distance(2));
big_wvl = (wvl > guess_wvl+in_big_range(1)) & (wvl < guess_wvl+in_big_range(2));
in_fit_wvl = wvl(good_wvl);
big_range_wvl = wvl(big_wvl);

to_fit = in_clean_spec(good_wvl);

delta_wvl = wvl-in_spec_wvl;

fit_func = @(x,xdata) x(1)*interp1(delta_wvl,in_laser_spec,xdata-x(2));

options = optimset('Display','none');
fit_out = lsqcurvefit(fit_func,[1 guess_wvl],in_fit_wvl,to_fit,[],[],options);

out_laser_free = in_clean_spec;
out_laser_free(big_wvl) = out_laser_free(big_wvl)-fit_func(fit_out.*[1 1],big_range_wvl);
out_laser_free(out_laser_free < 1E-7) = 1E-7;
out_power = fit_out(1);

function data = limit(data, in_limit)
data(data > in_limit) = in_limit;
end