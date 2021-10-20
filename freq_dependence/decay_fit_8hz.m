my_group = read_group('../../../../OneDrive-NEW/OneDrive - Georgia Institute of Technology/Parker Lab/Binod/2018/Tektronix/fluorescence_8hz_run%d.mat');

my_full = mean(my_group,1);

[~, my_bg, ~] = find_bg_multiple(my_full-mean(my_full), [12 24 36]);

my_refined = my_full - my_bg';
plot(my_full);hold all;plot(my_refined);hold off;
pause;
my_refined = my_refined(1050:1600);

my_x = 1:numel(my_refined);
my_fun = @(x,xdata) x(1)*exp(-xdata/x(2))+x(3);
my_t = 0.2*my_x/2000;

my_fit = lsqcurvefit(my_fun,[100,16E-3,18400],my_t,my_refined);
plot(my_t,my_refined,'*',my_t,my_fun(my_fit,my_t),'-','LineWidth',10);
set(gca,'FontSize',18,'LineWidth',3)
ylabel('Intensity (arb.)');
xlabel('Time (s)');
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[5 5],'PaperPosition',[0 0 5 5]);
print('-dpdf','decay_fit_8hz.pdf');
print('-dpng','decay_fit_8hz.png');
save decay_fit_8hz.mat