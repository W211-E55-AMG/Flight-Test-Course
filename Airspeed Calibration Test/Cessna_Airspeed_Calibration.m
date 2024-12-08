% Jose Rocha & Kaleb Nails Airspeed Calibration Code

clc
clear
close all

% Define the sheets to process
sheets = {'Clean', 'Flap10', 'Flap20', 'Flap30'};
last_rows = [83, 41, 27, 34];  % Last row for each sheet

% Initialize arrays for each configuration
clean_vcal = []; clean_pos_err = []; clean_vias = [];
flap10_vcal = []; flap10_pos_err = []; flap10_vias = [];
flap20_vcal = []; flap20_pos_err = []; flap20_vias = [];
flap30_vcal = []; flap30_pos_err = []; flap30_vias = [];

% Read and process data from Excel file
filename = 'Data_Post_Processing.xlsx';

% Process each sheet
for sheet_idx = 1:length(sheets)
    sheet_name = sheets{sheet_idx};
    last_row = last_rows(sheet_idx);
    
    % Read the entire sheet using readmatrix
    data = readmatrix(filename, 'Sheet', sheet_name);
    
    % Process data in 6-row blocks
    for row = 1:7:last_row-5
        % Extract KIAS (first row of each block)
        kias = data(row, 2:4);  % Columns B, C, D
        
        % Extract Ground Speed (third row of each block)
        gs = data(row+2, 2:4);
        
        % Extract Ground Track (fifth row of each block)
        track = data(row+4, 2:4);
        
        % Extract Density Ratio (sixth row of each block)
        density = data(row+5, 2:4);
        
        % Calculate average KIAS
        Vias = mean(kias, 'omitnan');
        
        % Calculate true airspeed
        [~, ~, Vtas] = calculate_wind_three_leg(gs, track(1), gs, track(2), gs, track(3));
        
        % Calculate average density ratio
        sigma_con = mean(density, 'omitnan');
        
        % Calculate calibrated airspeed
        Vcal = Vtas * sqrt(sigma_con);
        
        % Calculate position error
        pos_err = Vcal - Vias;
        
        % Store results based on configuration
        switch sheet_name
            case 'Clean'
                if ~isnan(Vias) && ~isnan(Vcal) && ~isnan(pos_err)
                    clean_vcal = [clean_vcal; Vcal];
                    clean_pos_err = [clean_pos_err; pos_err];
                    clean_vias = [clean_vias; Vias];
                end
            case 'Flap10'
                if ~isnan(Vias) && ~isnan(Vcal) && ~isnan(pos_err)
                    flap10_vcal = [flap10_vcal; Vcal];
                    flap10_pos_err = [flap10_pos_err; pos_err];
                    flap10_vias = [flap10_vias; Vias];
                end
            case 'Flap20'
                if ~isnan(Vias) && ~isnan(Vcal) && ~isnan(pos_err)
                    flap20_vcal = [flap20_vcal; Vcal];
                    flap20_pos_err = [flap20_pos_err; pos_err];
                    flap20_vias = [flap20_vias; Vias];
                end
            case 'Flap30'
                if ~isnan(Vias) && ~isnan(Vcal) && ~isnan(pos_err)
                    flap30_vcal = [flap30_vcal; Vcal];
                    flap30_pos_err = [flap30_pos_err; pos_err];
                    flap30_vias = [flap30_vias; Vias];
                end
        end
        
        % Debug output for first iteration of Clean configuration
        if sheet_idx == 1 && row == 1
            fprintf('First KIAS values: %.2f, %.2f, %.2f\n', kias(1), kias(2), kias(3));
            fprintf('Average KIAS: %.2f\n', Vias);
            fprintf('Ground Speed values: %.2f, %.2f, %.2f\n', gs(1), gs(2), gs(3));
            fprintf('Track values: %.2f, %.2f, %.2f\n', track(1), track(2), track(3));
            fprintf('Density values: %.2f, %.2f, %.2f\n', density(1), density(2), density(3));
            fprintf('Calculated Vtas: %.2f\n', Vtas);
            fprintf('Calculated Vcal: %.2f\n', Vcal);
            fprintf('Calculated Position Error: %.2f\n', pos_err);
        end
    end
end

% Create figure for Clean configuration
figure('Position', [100 100 1000 400])
subplot(1,2,1)
plot(clean_vias, clean_vcal, 'bo')
hold on
p = polyfit(clean_vias, clean_vcal, 2);
x_fit = linspace(min(clean_vias), max(clean_vias), 100);
y_fit = polyval(p, x_fit);
plot(x_fit, y_fit, 'r-')
xlim([min(clean_vias)-0.1*(max(clean_vias)-min(clean_vias)), max(clean_vias)+0.1*(max(clean_vias)-min(clean_vias))])
ylim([min(clean_vcal)-0.1*(max(clean_vcal)-min(clean_vcal)), max(clean_vcal)+0.1*(max(clean_vcal)-min(clean_vcal))])
title('Clean Configuration: V_{cal} vs V_{ias}')
xlabel('V_{ias} (kts)')
ylabel('V_{cal} (kts)')
grid on

subplot(1,2,2)
plot(clean_vias, clean_pos_err, 'bo')
xlim([min(clean_vias)-0.1*(max(clean_vias)-min(clean_vias)), max(clean_vias)+0.1*(max(clean_vias)-min(clean_vias))])
ylim([min(clean_pos_err)-0.1*(max(clean_pos_err)-min(clean_pos_err)), max(clean_pos_err)+0.1*(max(clean_pos_err)-min(clean_pos_err))])
title('Clean Configuration: Position Error vs V_{ias}')
xlabel('V_{ias} (kts)')
ylabel('Position Error (kts)')
grid on
sgtitle('Clean Configuration')

% Create figure for Flap 10 configuration
figure('Position', [100 100 1000 400])
subplot(1,2,1)
plot(flap10_vias, flap10_vcal, 'bo')
hold on
p = polyfit(flap10_vias, flap10_vcal, 2);
x_fit = linspace(min(flap10_vias), max(flap10_vias), 100);
y_fit = polyval(p, x_fit);
plot(x_fit, y_fit, 'r-')
xlim([min(flap10_vias)-0.1*(max(flap10_vias)-min(flap10_vias)), max(flap10_vias)+0.1*(max(flap10_vias)-min(flap10_vias))])
ylim([min(flap10_vcal)-0.1*(max(flap10_vcal)-min(flap10_vcal)), max(flap10_vcal)+0.1*(max(flap10_vcal)-min(flap10_vcal))])
title('Flap 10 Configuration: V_{cal} vs V_{ias}')
xlabel('V_{ias} (kts)')
ylabel('V_{cal} (kts)')
grid on

subplot(1,2,2)
plot(flap10_vias, flap10_pos_err, 'bo')
xlim([min(flap10_vias)-0.1*(max(flap10_vias)-min(flap10_vias)), max(flap10_vias)+0.1*(max(flap10_vias)-min(flap10_vias))])
ylim([min(flap10_pos_err)-0.1*(max(flap10_pos_err)-min(flap10_pos_err)), max(flap10_pos_err)+0.1*(max(flap10_pos_err)-min(flap10_pos_err))])
title('Flap 10 Configuration: Position Error vs V_{ias}')
xlabel('V_{ias} (kts)')
ylabel('Position Error (kts)')
grid on
sgtitle('Flap 10 Configuration')

% Create figure for Flap 20 configuration
figure('Position', [100 100 1000 400])
subplot(1,2,1)
plot(flap20_vias, flap20_vcal, 'bo')
hold on
p = polyfit(flap20_vias, flap20_vcal, 2);
x_fit = linspace(min(flap20_vias), max(flap20_vias), 100);
y_fit = polyval(p, x_fit);
plot(x_fit, y_fit, 'r-')
xlim([min(flap20_vias)-0.1*(max(flap20_vias)-min(flap20_vias)), max(flap20_vias)+0.1*(max(flap20_vias)-min(flap20_vias))])
ylim([min(flap20_vcal)-0.1*(max(flap20_vcal)-min(flap20_vcal)), max(flap20_vcal)+0.1*(max(flap20_vcal)-min(flap20_vcal))])
title('Flap 20 Configuration: V_{cal} vs V_{ias}')
xlabel('V_{ias} (kts)')
ylabel('V_{cal} (kts)')
grid on

subplot(1,2,2)
plot(flap20_vias, flap20_pos_err, 'bo')
xlim([min(flap20_vias)-0.1*(max(flap20_vias)-min(flap20_vias)), max(flap20_vias)+0.1*(max(flap20_vias)-min(flap20_vias))])
ylim([min(flap20_pos_err)-0.1*(max(flap20_pos_err)-min(flap20_pos_err)), max(flap20_pos_err)+0.1*(max(flap20_pos_err)-min(flap20_pos_err))])
title('Flap 20 Configuration: Position Error vs V_{ias}')
xlabel('V_{ias} (kts)')
ylabel('Position Error (kts)')
grid on
sgtitle('Flap 20 Configuration')

% Create figure for Flap 30 configuration
figure('Position', [100 100 1000 400])
subplot(1,2,1)
plot(flap30_vias, flap30_vcal, 'bo')
hold on
p = polyfit(flap30_vias, flap30_vcal, 2);
x_fit = linspace(min(flap30_vias), max(flap30_vias), 100);
y_fit = polyval(p, x_fit);
plot(x_fit, y_fit, 'r-')
xlim([min(flap30_vias)-0.1*(max(flap30_vias)-min(flap30_vias)), max(flap30_vias)+0.1*(max(flap30_vias)-min(flap30_vias))])
ylim([min(flap30_vcal)-0.1*(max(flap30_vcal)-min(flap30_vcal)), max(flap30_vcal)+0.1*(max(flap30_vcal)-min(flap30_vcal))])
title('Flap 30 Configuration: V_{cal} vs V_{ias}')
xlabel('V_{ias} (kts)')
ylabel('V_{cal} (kts)')
grid on

subplot(1,2,2)
plot(flap30_vias, flap30_pos_err, 'bo')
xlim([min(flap30_vias)-0.1*(max(flap30_vias)-min(flap30_vias)), max(flap30_vias)+0.1*(max(flap30_vias)-min(flap30_vias))])
ylim([min(flap30_pos_err)-0.1*(max(flap30_pos_err)-min(flap30_pos_err)), max(flap30_pos_err)+0.1*(max(flap30_pos_err)-min(flap30_pos_err))])
title('Flap 30 Configuration: Position Error vs V_{ias}')
xlabel('V_{ias} (kts)')
ylabel('Position Error (kts)')
grid on
sgtitle('Flap 30 Configuration')
