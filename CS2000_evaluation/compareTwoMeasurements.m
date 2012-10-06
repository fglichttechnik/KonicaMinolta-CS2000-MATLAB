% AUTHOR:	Jan Winter, Sandy Buschmann, TU Berlin, FG Lichttechnik,
% 			j.winter@tu-berlin.de, www.li.tu-berlin.de
% LICENSE: 	free to use at your own risk. Kudos appreciated.

function compareTwoMeasurements( measurement1, measurement2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

N = length(measurement1);
M = length(measurement2);

lambda = linspace(380,780,401);
% 
% SpectralArray1 = zeros(N,401);
% for i = 1 : N
%     try
%         SpectralArray1(i,:) = measurement1{i}.spectralData;
%     end
% end
% meanSpectral1 = mean(SpectralArray1);
% 
% SpectralArray2 = zeros(M,401);
% for i = 1 : M
%     try
%         SpectralArray2(i,:) = measurement2{i}.spectralData;
%     end
% end
% meanSpectral2 = mean(SpectralArray2);


figure;
%semilogy(lambda, meanSpectral1);
semilogy(lambda, measurement1);
hold on;
%semilogy(lambda, meanSpectral2,'r');
semilogy(lambda, measurement2,'r');
hold off;
%title(sprintf('Mean of %d Measurements',N));
%l = legend('$$\overline{v_{i}}(\lambda)$$','$$\overline{v_{i}}(\lambda) \pm s$$','$$\overline{v_{i}}(\lambda) \pm u(x)$$');
%set(l,'Interpreter','latex');
xlabel('\lambda in nm');
ylabel('\L_{e}(\lambda) in W / m^{2} sr nm');
%legend('mean','std');
axis('tight');

end

