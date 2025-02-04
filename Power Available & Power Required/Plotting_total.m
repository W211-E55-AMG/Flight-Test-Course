clc;
Final_height = [];
Final_vtas = [];

vtas = out.sealevel(:,1);
T100= out.sealevel(:,2);
T75= out.sealevel(:,3);
T65= out.sealevel(:,4);
T50= out.sealevel(:,5);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% One
idx_one = find(out.One(:,2)<out.One(:,1)); %I am so so smart so incredibly smart
disp(vtas(idx_one(end)));
Final_height = [Final_height;out.One(:,3)];
Final_vtas = [Final_vtas;vtas(idx_one(end))];
plot(vtas, out.One(:,2))
hold on
plot(vtas, out.One(:,1))
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%