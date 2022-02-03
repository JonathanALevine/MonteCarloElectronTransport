function PlotParticleDensity(states)
    global world;
    values = hist3([states(:,1), states(:,2)], [200 100], 'CdataMode','auto');
    imagesc(values.')
    c = colorbar;
    c.Label.String = 'Number of Particles';
    xlabel('x (nm)');
    ylabel('y (nm)');
    xlim([0 world.length/(10^(-9))]);
    ylim([0 world.height/(10^(-9))]);
    axis equal
    axis xy
end

