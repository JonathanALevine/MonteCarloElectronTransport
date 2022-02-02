function PlotTemperatureMap(states)
    x = states(:,1);
    y = states(:,2);
    xx = linspace(min(x), max(x), 200);
    yy = linspace(min(y), max(y), 200);
    [X, Y] = meshgrid(xx, yy);
    Z = griddata(x, y, states(:,5), X, Y);
    surf(X, Y, Z);
    colorbar;
    view(2);
end
