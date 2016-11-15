link1=  [0 0 3.68 0];
link2 = [5.24 0 0 30];
link3 = [5.24 -180 2 30];
link4 = [2 0 0 0];


links = [link1;link2;link3;link4];
hold on;
axis([-0 20 -20 20 0 20]);
set(gca,'YDir','Reverse')
set(gca,'XDir','Reverse')
grid on;
xlabel('X');
ylabel('Y');
zlabel('Z');
A = ones(4,4,length(links(:,1)));
T = ones(4,4,length(links(:,1)));
A = getA(links);
T = getT(A);
x = squeeze(T(1,4,:));
T(:,:,4)
y = squeeze(T(2,4,:));
z = squeeze(T(3,4,:));
x = x';
y = y';
z = z';
xPlot = [0 x];
yPlot = [0 y];
zPlot = [0 z];
plot3(xPlot,yPlot,zPlot,'black','LineWidth',4);
plot3(xPlot(end),yPlot(end),zPlot(end),'x','LineWidth',8);
% base = get(baseLink(), 'Vertices');
% servoLink01();
% armLink01();
% servoLink02();
% armLink02();