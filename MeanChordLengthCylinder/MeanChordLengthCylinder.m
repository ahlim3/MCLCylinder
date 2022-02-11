function MeanChordLengthCylinder(n, radius, height)
k = 1;
mclArray = zeros(1, n);
x1Array = zeros(1, n);
y1Array = zeros(1, n);
z1Array = zeros(1, n);
x0Array = zeros(1, n);
y0Array = zeros(1, n);
z0Array = zeros(1, n);

volume = pi * radius * radius * height;
surfacearea =  2 * pi * radius * radius + 2 * pi * radius * height;
AnalyticalSolution = volume * 4 / surfacearea

while k < n
    k = k + 1;
    [x0, y0, z0, x1, y1, z1, l] = CylinderGenerator(radius,height);
    x1Array(1, k) = x1;
    z1Array(1, k) = z1;
    y1Array(1, k) = y1;
    x0Array(1, k) = x0;
    z0Array(1, k) = z0;
    y0Array(1, k) = y0;
    mclArray(1, k) = abs(l);
end

mu = mean(mclArray)
sigma = std(mclArray)
a = histogram(mclArray,100);
q = a.Values;
HistMax = max(q);

figure(1)
histogram(mclArray,100)
grid on;
xlabel('Chord Length(cm)', 'FontSize', 15);
ylabel('Count', 'FontSize', 15);
xline(mu, 'color', 'g', "LineWidth", 2);
xline(mu - sigma, 'color', 'r', 'LineWidth', 2, 'LineStyle', '--');
xline(mu + sigma, 'color', 'r', 'LineWidth', 2, 'LineStyle', '--');
ylim([0, HistMax * 1.2]); % Give some headroom above the bars.
yl = ylim;
sMean = sprintf('  Mean = %.3f cm \n   SD = %.3f cm \n A.Sol. = %.3f cm', mu, sigma, AnalyticalSolution);
text(mu * 1.2, 0.9*yl(2), sMean, 'Color', 'r','FontWeight', 'bold', 'FontSize', 12, 'EdgeColor', 'b');
sMean2= sprintf('Frequency vs Chordlength (cm). N = %.0f trials  Mean = %.3f. cm  SD = %.3f cm A.Sol. = %.3f cm', n, mu, sigma, AnalyticalSolution);
title(sMean2, 'FontSize', 15);

figure(2)
plot3(x0Array,y0Array,z0Array,'.',x1Array,y1Array,z1Array,'.');
title('Profile Distribution', 'FontSize', 15);

end