clc;clf;close;
Final_height = [];
Final_vtas = [];
vtas = out.sealevel(:,1);
T100 = out.sealevel(:,2);
T75 = out.sealevel(:,3);
T65 = out.sealevel(:,4);
T50 = out.sealevel(:,5);

%this is for thrust contours:
Final_vtas_100p = [];
Final_height_100p =[];
Final_vtas_75p = [];
Final_height_75p =[];
Final_vtas_65p = [];
Final_height_65p =[];
Final_vtas_50p = [];
Final_height_50p =[];

% Loop through all the data sets from _one to _nineteen
for i = 1:19
    % Find where column 2 (drag) is less than column 1 (thrust) for the current set (e.g., out.One, out.Two, ..., out.Twelve)
    %This is a lazy mans way to solve for the intercepts of the curves.
    %we can assume that the thrust always spans the drag, this program will
    %fail is thrust is not greater than drag at any point.
    idx = find(out.(sprintf('%s', number_to_word(i)))(:,2) < out.(sprintf('%s', number_to_word(i)))(:,1));
    
    % Display the last value of VTAS where the condition is met
    %disp(vtas(idx(end)));
    
    % Store the height and VTAS at that crossing
    Final_height = [Final_height; unique(out.(sprintf('%s', number_to_word(i)))(:,3))];
    Final_vtas = [Final_vtas; vtas(idx(end))];


    %%%%%%%%%%%%%%%
    %this is for find the the other thrust lines this is experimental, yes
    %i could do this with another four loop but this is fine for now. This 
    %does the same thing it just finds the left most point but instead of
    %the thrust at the propper elevation it compares it to percent thrust
    %at sea level
    idx = find(out.(sprintf('%s', number_to_word(i)))(:,2) < T100);
    Final_vtas_100p = [Final_vtas_100p; vtas(idx(end))];
    Final_height_100p = [Final_height_100p; unique(out.(sprintf('%s', number_to_word(i)))(:,3))];

    idx = find(out.(sprintf('%s', number_to_word(i)))(:,2) < T75);
    Final_vtas_75p = [Final_vtas_75p; vtas(idx(end))];
    Final_height_75p = [Final_height_75p; unique(out.(sprintf('%s', number_to_word(i)))(:,3))];

    idx = find(out.(sprintf('%s', number_to_word(i)))(:,2) < T65);
    Final_vtas_65p = [Final_vtas_65p; vtas(idx(end))];
    Final_height_65p = [Final_height_65p; unique(out.(sprintf('%s', number_to_word(i)))(:,3))];

    idx = find(out.(sprintf('%s', number_to_word(i)))(:,2) < T50);
    Final_vtas_50p = [Final_vtas_50p; vtas(idx(end))];
    Final_height_50p = [Final_height_50p; unique(out.(sprintf('%s', number_to_word(i)))(:,3))];

    %%%%%%%%%%%%
    
    % Plot the two curves for the current set, thrust and drag
    plot(vtas, out.(sprintf('%s', number_to_word(i)))(:,2)); % Plot column 2 (e.g., out.One(:,2))
    hold on;
    plot(vtas, out.(sprintf('%s', number_to_word(i)))(:,1)); % Plot column 1 (e.g., out.One(:,1))
    hold on;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
halfsteps = 1; % turn on and off half steps altitudes, this is a quick way
%chat Gtp can write the number_to_word function, but anything more
%complicated it bonks, and its not worth the man hours to add a function to
%accept half thousand feet increments
if halfsteps == 1
    idx = find(out.OneFive(:,2) < out.OneFive(:,1));
    Final_height = [Final_height; unique(out.OneFive(:,3))];
    Final_vtas = [Final_vtas; vtas(idx(end))];

    idx = find(out.TwoFive(:,2) < out.TwoFive(:,1));
    Final_height = [Final_height; unique(out.TwoFive(:,3))];
    Final_vtas = [Final_vtas; vtas(idx(end))];

    idx = find(out.TwelveFive(:,2) < out.TwelveFive(:,1));
    Final_height = [Final_height; unique(out.TwelveFive(:,3))];
    Final_vtas = [Final_vtas; vtas(idx(end))];

    idx = find(out.NineFive(:,2) < out.NineFive(:,1));
    Final_height = [Final_height; unique(out.NineFive(:,3))];
    Final_vtas = [Final_vtas; vtas(idx(end))];

    idx = find(out.ThirteenFive(:,2) < out.ThirteenFive(:,1));
    Final_height = [Final_height; unique(out.ThirteenFive(:,3))];
    Final_vtas = [Final_vtas; vtas(idx(end))];

    idx = find(out.Zero(:,2) < out.Zero(:,1));
    Final_height = [Final_height; unique(out.Zero(:,3))];
    Final_vtas = [Final_vtas; vtas(idx(end))];

    %this just reoganizes it if needed
    Final_Matrix = sortrows([Final_height,Final_vtas], 1);
    Final_height = Final_Matrix(:,1);Final_vtas = Final_Matrix(:,2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Final_Matrix = [Final_height,Final_vtas];
format long g
disp('Final_Matrix=')
disp(Final_Matrix)
% Add labels and title
xlabel('VTAS (ft/s)');
ylabel('Thrust & Drag');
title('Points');
%legend('show');

figure(2)
plot(Final_Matrix(:,2),Final_Matrix(:,1)/1000, '-o', 'MarkerSize', 2, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b','LineWidth',2);
xlabel('VTAS (ft/s)');
ylabel('Height (kft)');
title('Envelope Graph');
hold on; grid on; grid minor

%%%%%%%%%%%%%%%%%%%
%This is for plotting countors EXPERIMENTAL
[p, S, mu ]= polyfit(Final_Matrix(:,2),Final_Matrix(:,1),6)
y_fit = polyval(p, Final_Matrix(:,2), S, mu);
plot(Final_Matrix(:,2), y_fit/1000, 'r--'); % Plot fitted polynomial as red line

%now acutally plot them
plot(Final_vtas_100p,Final_height_100p/1000)

%this works by finding least distance between each point on the linear line
%and the other curve. Then it gets rid of anything to the right of it
%because we can assume it will have cross over the curve at that point.
[~,min_error_idx] = min(abs(polyval(p, Final_vtas_75p, S, mu)-Final_height_75p));
plot(Final_vtas_75p(1:min_error_idx),Final_height_75p(1:min_error_idx)/1000)

[~,min_error_idx] = min(abs(polyval(p, Final_vtas_65p, S, mu)-Final_height_65p));
plot(Final_vtas_65p(1:min_error_idx),Final_height_65p(1:min_error_idx)/1000)

[~,min_error_idx] = min(abs(polyval(p, Final_vtas_50p, S, mu)-Final_height_50p));
plot(Final_vtas_50p(1:min_error_idx),Final_height_50p(1:min_error_idx)/1000)

legend('envelope','Fitted Polynomial','100%','75%','65%','50%','Location','best')

%plot(Final_vtas_75p,Final_height_75p/1000)


%%%%%%



function word = number_to_word(n)
    % Check if the number is valid (between 1 and 99)
    if n < 1 || n > 99 || floor(n) ~= n
        error('Input must be a whole number between 1 and 99.');
    end
    
    % Define words for ones and tens
    ones = {'', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', ...
            'Ten', 'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', ...
            'Eighteen', 'Nineteen'};
    tens = {'', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'};
    
    % Handle numbers 1 to 19
    if n <= 19
        word = ones{n+1};  % +1 because 'ones' is 1-indexed
    else
        tens_place = floor(n / 10);
        ones_place = mod(n, 10);
        if ones_place == 0
            word = tens{tens_place};
        else
            word = [tens{tens_place}, '-' , ones{ones_place+1}];
        end
    end
end

