clc; clear all; close all;

alphas = [0.75, 0.75, 0.75, 0.50, 0.25, 0.25, 0.25];
gammas = [0.00, 0.10, 0.20, 0.50, 1.00, 2.00, 5.00];
aps = [31.1, 31.4, 31.9, 32.9, 33.7, 34.0, 32.2];
nor = aps - min(aps) + 1;
nor = nor ./ max(nor);

a1 = 0.1581;
b1 = -1.848;
c1 = -0.069;

ax = 0.2:0.01:0.9;
fit = a1 .* (ax .^ b1) + c1;
rough = 1 ./ (10 * ax .^ 2);
plot(ax, fit);
grid on; hold on;
plot(ax, rough);
p = plot(alphas, gammas, '-x', 'MarkerSize', 16);
scatter(0.25, 5, 50, 'rx');
text(0.255, 5, {'\leftarrow Treated as an outlier (0.25, 5)'})
p.LineWidth = 1.5;
ylim([0, 5.5]); 
legend('Best Power Fit', 'Rough Fit', 'Experiment Data', 'Location', 'best');
xlabel('\fontsize{17} \alpha'); ylabel('\fontsize{17} \gamma')

text(0.702, 4.5, {'Goodness of Best Fit:'})
text(0.702, 4.3, {'SSE: 0.3098'})
text(0.702, 4.1, {'R-square: 0.8224'})
text(0.702, 3.9, {'RMSE: 0.3936'}) 

text(0.702, 3.5, {'Goodness of Rough Fit:'})
text(0.702, 3.3, {'SSE: 0.5098'})
text(0.702, 3.1, {'R-square: 0.7424'})
text(0.702, 2.9, {'RMSE: 0.2915'}) 

p = 0.5;
z = zeros(61, 501);
i = 1;
j = 1;
for a = 0.2:0.01:0.8
    for b = 0:0.01:5
        f = -a * ((1 - p) ^ b) * log(p);
        z(i,j) = f;
        j = j + 1;
    end
    i = i + 1;
    j = 1;
end

x = max(max(z));
figure;
plot3(gammas, alphas, nor.*x); hold on;
for i = 1:7
    y = 0:0.001:nor(i) * x;
    temp1 = ones(1,length(y)) .* alphas(i);
    temp2 = ones(1,length(y)) .* gammas(i);
    plot3(temp2, temp1, y);
end
mesh(0:0.01:5, 0.2:0.01:0.8, z);
ylabel('\fontsize{17} \alpha'); xlabel('\fontsize{17} \gamma'); zlabel('FL(0.5)'); 
title("Focal Loss vs. \alpha and \gamma @ p = 0.5");
legend('Normalized AP Values', 'Location', 'best');
grid on; hold off;

p = 0.5;
step = 0.1;
[X,Y] = meshgrid(0.2:step:1, 0:step:2+step);
Z = -X .* (p .^ Y) .* log(p);
[dX,dY] = gradient(Z,step);
figure; quiver(X,Y,dX,dY);
hold on
contour(X,Y,Z)
axis equal
hold off
xlim([0.2, 0.91]); ylim([0, 2+step]);
xlabel('\fontsize{17} \alpha'); ylabel('\fontsize{17} \gamma');
title('Quiver-Contour Plot of Focal Loss');
figure, grid on; hold on;
p = 0:0.01:1;
for i = 1:3
    alpha = 0.25 * i;
    fit = a1 .* (alpha .^ b1) + c1;
    f = -alpha .* ((1 - p) .^ fit) .* log(p);
    plot(p, f); 
end
legend('\alpha = 0.25 | \gamma = f(\alpha) = 1.97 | \gamma_{best} = 2.0', ...
       '\alpha = 0.50 | \gamma = f(\alpha) = 0.50 | \gamma_{best} = 0.5', ...
       '\alpha = 0.75 | \gamma = f(\alpha) = 0.10 | \gamma_{best} = 0.2')
ylim([0, 3.5])
ylabel('FL^{*}(p_{t})');
xlabel('p_{t}');
hold off;

% Experiments
exp_alphas = [0.45, 0.45, 0.45, 0.6, 0.6];
exp_gammas = [(a1 .* (0.45 .^ b1) + c1) * 0.7, ...
               a1 .* (0.45 .^ b1) + c1, ...
              (a1 .* (0.45 .^ b1) + c1) * 1.3, ...
              (a1 .* (0.6 .^ b1) + c1) * 0.7, ...
               a1 .* (0.6 .^ b1) + c1];
exp_aps = [32.5, 32.9, 32.8, 31.2, 31.7];
figure('Renderer', 'painters', 'Position', [800 200 900 900]);
ax = 0.2:0.01:0.9;
fit = a1 .* (ax .^ b1) + c1;
plot(ax, fit);
grid on; hold on;
p = plot(alphas(2:end - 1), gammas(2:end - 1), '-x', 'MarkerSize',12);
% text(0.257, 5.02, {'\leftarrow Treated as an outlier (0.25, 5)'})
p.LineWidth = 1.5;
% scatter(exp_alphas, exp_gammas, 'ko');
scatter(0.25, 5, 100, 'rx');
scatter(0.75, 0, 100, 'rx');
% text(0.52, 0.02, {'Treated as an outlier (0.75, 0)\rightarrow'})
ylim([-0.5, 5.5]);
% legend('Best Power Fit', 'Lin et. al. Data', 'Experiment Data', 'Location', 'best');
legend('Best Power Fit', 'Lin et. al. Data', 'Location', 'best');
xlabel('\fontsize{17} \alpha'); ylabel('\fontsize{17} \gamma')
% text(0.39, exp_gammas(1), {'AP: 32.4 \rightarrow'}, 'FontSize', 11)
% text(0.46, exp_gammas(2), {'\leftarrow AP: 32.9'}, 'FontSize', 11)
% text(0.46, exp_gammas(3), {'\leftarrow AP: 32.8'}, 'FontSize', 11)
% text(0.54, exp_gammas(4), {'AP: 31.2 \rightarrow'}, 'FontSize', 11)
% text(0.54, exp_gammas(5), {'AP: 31.7 \rightarrow'}, 'FontSize', 11)

figure;
scatter(exp_alphas, exp_aps, 60)
grid on; hold on;
xlabel('\fontsize{17} \alpha'); ylabel('AP');
scatter([0.45, 0.6], [32.9, 31.7], 70, 'x');
xlim([0.4, 0.65]); ylim([31, 33]);
legend('Experiment Results', 'Proposed \alpha/\gamma pairs', 'Location', 'best')
