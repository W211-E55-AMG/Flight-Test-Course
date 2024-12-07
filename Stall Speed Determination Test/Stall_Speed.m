% Jose Rocha & Kaleb Nails Stall Determination Code

clc
clear
close all

% Data Collected from Stall Speed Test
Vias_Clean = 39; % Test 1
Vias_Flaps10 = 31; % Test 2
Vias_Flaps20 = 28;% Test 3
Vias_Flaps30 = 26; % Test 4

% Vcal Determined by Extroplating Airspeed Calibration Graphs
Vcal_clean = 41.08; % Test 1
Vcal_Flaps10 = 34.8; % Test 2
Vcal_Flaps20 = 30.74; % Test 3
Vcal_Flaps30 = 29; % Test 4

% Tach Time & Weight are Organize From G.T.W,Test 1 till Test 4.
Tach_time = [2346.6, 2347.0, 2347.05, 2347.1, 2347.15];
Weight = [2543.04, 2526.184, 2524.98, 2523.776, 2523.174];

ALT = 3500; % Pressure ALT ft

Theta = 1 - 0.689*10^-5*ALT; % Temperature Ratio

Del = Theta^5.256; % Pressure Ratio

Sigma = Del/Theta; % Density Ratio

Vtas = [Vcal_clean, Vcal_Flaps10,Vcal_Flaps20,Vcal_Flaps30]./sqrt(Sigma); %True Airspeed Array
Vgs = [72, 71, 71, 65]; % Ground Speed Data From Flight Radar

Phi = [0, 30, 45, 60]; % Bank Angle

n = 1./cosd(Phi); 

% Initialize arrays to store CLmax values for each configuration and bank angle
CLmax_EX_full = zeros(length(n), 4);  % 4 configurations, length(n) bank angles
CLmax_FR_full = zeros(length(n), 4);

% Calculate stall speeds for each bank angle and configuration
for i = 1:length(n)
    for j = 1:4  % 4 configurations
        % Experimental CLmax calculation
        CLmax_EX_full(i,j) = (2*Weight(j+1)*n(i))/(0.002378*Vtas(j).^2*174*1.68781);
        
        % Flight Radar CLmax calculation
        CLmax_FR_full(i,j) = (2*Weight(j+1)*n(i))/(0.002378*Vgs(j).^2*174*1.68781);
    end
end


weight_correction = sqrt(Weight(1)./Weight(2:5));

Vs_exp = zeros(length(Phi), 4);
Vs_fr = zeros(length(Phi), 4);

% Calculate corrected stall speeds for each bank angle and configuration
for i = 1:length(Phi)
    for j = 1:4
        % Experimental data correction
        Vs_exp(i,j) = n(i) * Vtas(j) * weight_correction(j);
        
        % Flight radar data correction
        Vs_fr(i,j) = n(i) * Vgs(j) * weight_correction(j);
    end
end

% Create figure for Experimental Data
figure('Name', 'Weight-Corrected Stall Speed vs Bank Angle - Experimental')
hold on
config_labels = {'Clean', 'Flaps 10°', 'Flaps 20°', 'Flaps 30°'};
colors = {'b', 'r', 'g', 'k'};
markers = {'o', 's', '^', 'd'};

% Plot experimental data with curve fitting
for j = 1:4
    % Plot data points
    plot(Phi, Vs_exp(:,j), [colors{j} markers{j}], 'MarkerFaceColor', colors{j}, ...
        'DisplayName', config_labels{j});
    
    % Generate polynomial fit
    p = polyfit(Phi, Vs_exp(:,j), 2);
    phi_fine = 0:0.1:60;
    Vs_fit = polyval(p, phi_fine);
    
    % Plot fitted curve
    plot(phi_fine, Vs_fit, colors{j}, 'LineWidth', 1.5, ...
        'DisplayName', [config_labels{j} ' Fit']);
end

grid on
xlabel('Bank Angle (degrees)')
ylabel('Corrected Stall Speed (ft/s)')
title('Weight-Corrected Stall Speed vs Bank Angle - Experimental Data')
legend('Location', 'northwest')

% Create figure for Flight Radar Data
figure('Name', 'Weight-Corrected Stall Speed vs Bank Angle - Flight Radar')
hold on

% Plot flight radar data with curve fitting
for j = 1:4
    % Plot data points
    plot(Phi, Vs_fr(:,j), [colors{j} markers{j}], 'MarkerFaceColor', colors{j}, ...
        'DisplayName', config_labels{j});
    
    % Generate polynomial fit
    p = polyfit(Phi, Vs_fr(:,j), 2);
    Vs_fit = polyval(p, phi_fine);
    
    % Plot fitted curve
    plot(phi_fine, Vs_fit, colors{j}, 'LineWidth', 1.5, ...
        'DisplayName', [config_labels{j} ' Fit']);
end

grid on
xlabel('Bank Angle (degrees)')
ylabel('Corrected Stall Speed (ft/s)')
title('Weight-Corrected Stall Speed vs Bank Angle - Flight Radar Data')
legend('Location', 'northwest')

% Create figure for Experimental CLmax Data
figure('Name', 'Maximum Lift Coefficient at 15° AOA - Experimental')
hold on
config_labels = {'Clean', 'Flaps 10°', 'Flaps 20°', 'Flaps 30°'};
colors = {'b', 'r', 'g', 'k'};

% Plot Experimental data points
for j = 1:4
    plot(15, CLmax_EX_full(1,j), [colors{j} '*'], 'MarkerSize', 10, ...
        'DisplayName', config_labels{j});
end

% Adjust plot properties
grid on
xlim([0 17])
yticks(0:0.25:8)
xlabel('Angle of Attack (degrees)')
ylabel('Maximum Lift Coefficient')
title('Maximum Lift Coefficient at 15° AOA - Experimental Data')
legend('Location', 'eastoutside')


% Create figure for Flight Radar CLmax Data
figure('Name', 'Maximum Lift Coefficient at 15° AOA - Flight Radar')
hold on

% Plot Flight Radar data points
for j = 1:4
    plot(15, CLmax_FR_full(1,j), [colors{j} 's'], 'MarkerSize', 10, ...
        'MarkerFaceColor', colors{j}, 'DisplayName', config_labels{j});
end

% Adjust plot properties
grid on
xlim([0 17])
ylim([0 2])
yticks(0:0.25:2)
xlabel('Angle of Attack (degrees)')
ylabel('Maximum Lift Coefficient')
title('Maximum Lift Coefficient at 15° AOA - Flight Radar Data')
legend('Location', 'eastoutside')


