function [fitresult, gof] = createFit1(xData, yData)
% 拟合: 'fitting function'。
yData = [5, 6.01263, 7.064074, 7.704001, 8.446876, 9.402603, 10.59638, 12.05081, ...  
         13.32077, 13.90903, 13.74398, 13.12445, 12.23864, 11.2714, 10.55806, ...  
         10.01067, 9.295592, 8.283175, 6.948832, 5.744262, 4.818105, 4.058073, ...  
         3.395804, 2.790049, 2.547823, 2.567301, 2.774149, 3.114509, 3.721667, ...  
         4.151112, 4.580556, 5];  
xData = [0, 0.644655, 1.289291, 1.934132, 2.578922, 3.223606, 3.868171, 4.512605, ...  
             5.157131, 5.801999, 6.447243, 7.092714, 7.738318, 8.383963, 9.029481, ...  
             9.674916, 10.32044, 10.9661, 11.61193, 12.2577, 12.90332, 13.54886, ...  
             14.19435, 14.83982, 15.4851, 16.13025, 16.77531, 17.4203, 18.06516, ...  
             18.71011, 19.35505, 20];  

[xData_1, yData_1] = prepareCurveData( xData, yData );

% 初始化障碍物数据  
Data.Obs(1).S = [1,4; 2,4; 2,1; 1,1;1,4];  
Data.Obs(2).S = [3,6; 4,6; 4,3; 3,3;3,6];  
Data.Obs(3).S = [6,4; 7,4; 7,1; 6,1;6,4];  
Data.Obs(4).S = [8,10; 9,10; 9,5; 8,5;8,10];  
Data.Obs(5).S = [10,14; 14,14; 14,12; 10,12;10,14];  
Data.Obs(6).S = [14,8; 18,8; 18,6; 14,6;14,8];  

% 设置 fittype 和选项。
ft = fittype( 'fourier5' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0 0 0 0 0 0 0 0 0 0 0 0.314159265358979];

% 对数据进行模型拟合。
[fitresult, gof] = fit( xData_1, yData_1, ft, opts );

% 绘制数据拟合图。
figure( 'Name', 'fitting function' );
hold on; % 保持当前图形，以便在同一窗口中绘制多个障碍物  
  
% 遍历每个障碍物并绘制其边界  
for i = 1:length(Data.Obs)  
    % 提取当前障碍物的顶点坐标  
    xy = Data.Obs(i).S;  
      
    % 绘制多边形边界  
    plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', rand(1,3)); % 使用随机颜色，也可以指定颜色  
end  
  
h = plot( fitresult, xData_1, yData_1 );
legend( h, 'yData vs. xData', 'fitting function', 'Location', 'NorthEast', 'Interpreter', 'none' );
% 为坐标区加标签
xlabel( 'xData', 'Interpreter', 'none' );
ylabel( 'yData', 'Interpreter', 'none' );
grid on


