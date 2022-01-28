close all;  
clear; %intialization

set(0,'DefaultFigureWindowStyle','docked')

% Constants
global m0 m T k;
m0 = 9.10938356*10^(-31); %Electron rest mass
m = 0.26*m0; 
T = 300;
k = 1.38064852*10^(-23); %Boltzmann Constant

global vth;
vth = sqrt(2*k*T/m);

% Simulation controls
global box;
box.length = 200*10^(-9);
box.height = 100*10^(-9);

show_all_particles = 0;
num_particles = 1000;
traced_particles = 50;

global dt;
dt = box.height/vth/100;
epochs = 1000;

states = GenerateStates(num_particles);
temperatures = zeros(epochs, 1);

for epoch = 1:epochs
    % Plot the positions of the particles
    figure(1)
    if show_all_particles
        plot(states(:,1)/(10^(-9)),...
                states(:,2)/(10^(-9)), 'b*');
        xlim([0 box.length/(10^(-9))]);
        ylim([0 box.height/(10^(-9))]);
        xlabel('x (nm)')
        ylabel('y (nm)')
    
    else

        for n = 1:traced_particles
            xValues(epoch, n) = states(n:n,1).';
            yValues(epoch, n) = states(n:n,2).';
        end
    
        plot(xValues/10^(-9), yValues/10^(-9), '.')
        xlim([0 box.length/(10^(-9))]);
        ylim([0 box.height/(10^(-9))]);
        xlabel('x (nm)')
        ylabel('y (nm)')
    end
    
    % Check the boundary conditions of the particles
    states = check_boundary(states);
    % Move the particle
    states = move_particle(states);
    % Get the semi conductor temperature at this time step
    temperatures(epoch) = mean(states(:,5));
    
    pause (0.01)
end

FN2 = 'Particle Trajectories';   
print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG

figure(2)
plot(temperatures)
xlabel('Time (1/100 sec)')
ylabel('Temperature (K)') 

FN2 = 'Temperature Plot';   
print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
