%{
Jose Rocha-Puscar
The purpose of this code is to calculate true airspeed based off the GPS
method of airspeed calibration. Its test conditions and procedures can be
found in appendix 9 section 3 of FAA AC 23-8c document
%}

% Function to calculate wind parameters and intermediate values
function [wind_speed,wind_direction, true_airspeed] = calculate_wind_three_leg(gs1, track1, gs2, track2, gs3, track3)

    % Calculate average values for each leg
    avg_gs1 = mean(gs1);
    avg_track1 = mean(track1);
    avg_gs2 = mean(gs2);
    avg_track2 = mean(track2);
    avg_gs3 = mean(gs3);
    avg_track3 = mean(track3);
    
    % Calculate X and Y components
    x1 = avg_gs1 * sind(360-avg_track1);
    y1 = avg_gs1 * cosd(360-avg_track1);
    x2 = avg_gs2 * sind(360-avg_track2);
    y2 = avg_gs2 * cosd(360-avg_track2);
    x3 = avg_gs3 * sind(360-avg_track3);
    y3 = avg_gs3 * cosd(360-avg_track3);
    
    % Calculate slopes and intercepts
    m1 = -1 * (x2 - x1) / (y2 - y1);
    b1 = ((y1 + y2) / 2) - (m1 * (x1 + x2) / 2);
    m2 = -1 * (x3 - x1) / (y3 - y1);
    b2 = ((y1 + y3) / 2) - m2 * ((x1 + x3) / 2);
    
    % Calculate wind components
    wx = (b1 - b2) / (m2 - m1);
    wy = m1 * wx + b1;
    
    % Calculate wind speed and direction
    wind_speed = sqrt(wx^2 + wy^2);
    wind_direction = mod(540 - rad2deg(atan2(wx, wy)), 360);
    
    % Calculate true airspeed
    true_airspeed = sqrt((x1 - wx)^2 + (y1 - wy)^2);
   
end

