f1 = figure;
f11 = subplot(1,2,1), h11 = plot(linspace (-1,1,10));
f12 = subplot(1,2,2), h12 = plot(linspace (-1,1,10));

%// second figure
f2 = figure;
f21 = subplot(1,2,1), h21 = plot(linspace (-1,1,10));
f22 = subplot(1,2,2), h22 = plot(linspace (-1,1,10));

for n = 1:3
    %// calculate a1, b1;
    h11.YData = linspace (-5,2,10);
    %set(h11, 'YData', linspace (-1,2,10));
    set(h12, 'YData', linspace (-1,2,10));

    %// calculate a2, b2;
    set(h21, 'YData', linspace (-2,1,10));
    set(h22, 'YData', linspace (-2,1,10));
end