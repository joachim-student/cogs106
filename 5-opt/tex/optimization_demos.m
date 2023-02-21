%% Steepest Ascent

objective = @(x) normpdf(x,0,1);

xax = linspace(-5,5,101);
yax = objective(xax);

plot(xax, yax, 'LineWidth', 3)
grid on

current_value  = randn;
current_height = objective(current_value);

m = line(current_value, current_height, ...
    'Zdata'      , 100  , ...
    'color'      ,  'g' , ...
    'marker'     ,  '^' , ...
    'markersize' ,  10  , ...
    'markerface' ,  'g' , ...
    'LineWidth'  ,   2  );

best_value  = current_value;
best_height = current_height;

for k = 1:100
    %current_value = best_value + randn/k;
    current_value = randn;
    current_height = objective(current_value);
    line(current_value, current_height, ...
        'color', 'r', 'marker', 'o', 'LineWidth', 2);
    if current_height > best_height
        best_height = current_height;
        best_value  = current_value
        m.set('XData', best_value, 'YData', best_height);
    end
    drawnow
    pause(.20)
end

best_value


%% Simulated Annealing
rng(0)

pks = @(x,y) 3*(1-x).^2.*exp(-x.^2 - (y+1).^2) ...
    - 10*(x/5 - x.^3 - y.^5).*exp(-x.^2-y.^2) ...
    - 1/3*exp(-(x+1).^2 - y.^2);

dim = linspace(-3,3,101);
[xpl, ypl] = meshgrid(dim, dim);
zfn = pks(xpl, ypl);
c = surfc(xpl, ypl, zfn);

c(1).EdgeColor = 'none';
axis off
colormap hsv
pause
view([0 -90])
pause
xi = 0;
yi = 0;

b = line(xi, yi, -3, 'color', 'g', 'marker', 'o', 'markerf', 'g');

T = 1;
N = 2000;
ll=zeros(1,N);
for k = 1:N
    k
    T = sqrt(N+1-k)/5;
    if k==1,T=1000;end

    zi = pks(xi, yi);
    b.XData = xi;
    b.YData = yi;
    proposal = zfn;
    proposal(:) = mvnpdf([xpl(:) ypl(:)], [xi yi]);
    acceptance = min(exp(-(zi-zfn)/T),10);
    P = proposal .* acceptance;
    c(1).CData = P*100;

    P(P<.01) = 0;
    P = P(:) ./ sum(P(:));

    drawnow
    pause(T/400)
    if k<=2 || (k>750 && k<800),pause,end

    idx = find(mnrnd(1,P));
    [xidx, yidx] = ind2sub(size(c(1).CData), idx);
    if k>1
        xi = xpl(1, yidx);
        yi = ypl(xidx, 1);
    end
    ll(k)=zi;
end

c(1).CData = zfn;

pause
clf
plot(ll)