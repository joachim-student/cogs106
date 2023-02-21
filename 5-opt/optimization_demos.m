%% Steepest ascent example
%
% Define the objective function to be a normal probability density function
% with a mean of 0 and standard deviation of 1
objective = @(x) normpdf(x,0,1);

% Generate a vector of 101 equally spaced points between -5 and 5
xax = linspace(-5,5,101);

% Evaluate the objective function at each point in xax
yax = objective(xax);

% Plot the objective function
plot(xax, yax, 'LineWidth', 3)
grid on

% Generate a random starting point for the optimization algorithm
current_value  = randn;

% Evaluate the objective function at the starting point
current_height = objective(current_value);

% Plot the starting point as a green triangle marker
m = line(current_value, current_height, ...
    'Zdata'      , 100  , ...
    'color'      ,  'g' , ...
    'marker'     ,  '^' , ...
    'markersize' ,  10  , ...
    'markerface' ,  'g' , ...
    'LineWidth'  ,   2  );

% Initialize the best solution to be the starting point
best_value  = current_value;
best_height = current_height;

% Run the optimization algorithm for 100 iterations
for k = 1:100

    % Generate a new candidate solution by adding a random value from a
    % gradually narrowing normal distribution to the current best solution
    current_value = best_value + randn / k;

    % Evaluate the objective function at the candidate solution
    current_height = objective(current_value);

    % Plot the candidate solution as a red circle marker
    line(current_value, current_height, ...
        'color', 'r', 'marker', 'o', 'LineWidth', 2);

    % If the candidate solution is better than the current best solution,
    % update the best solution and move the green triangle marker to the
    % new best solution
    if current_height > best_height
        best_height = current_height;
        best_value  = current_value;
        m.set('XData', best_value, 'YData', best_height);
    end

    % Update the plot
    drawnow

    % Pause briefly to allow the plot to update
    pause(.20)
end

% Output the best solution found by the algorithm
best_value


%% Simulated Annealing example
rng(0)

% Define function to be optimized
peaks = @(x, y) 3*(1-x).^2 .* exp(-x.^2 - (y+1).^2) ...
    - 10*(x/5 - x.^3 - y.^5) .* exp(-x.^2-y.^2) ...
    - 1/3*exp(-(x+1).^2 - y.^2);

% Define grid for plotting
grid_range = linspace(-3, 3, 101);
[x_grid, y_grid] = meshgrid(grid_range, grid_range);

% Evaluate function on grid
z_values = peaks(x_grid, y_grid);

% Plot the function
surface_plot = surfc(x_grid, y_grid, z_values);
surface_plot(1).EdgeColor = 'none';
axis off
colormap hsv
pause
view([0 -90])
pause

% Initialize starting point and plot it
current_x = 0;
current_y = 0;
marker_plot = line(current_x, current_y, -3, 'color', 'g', 'marker', 'o', 'markerf', 'g');

% Define optimization parameters
initial_temperature = 1000;
num_iterations = 2000;
energies = zeros(1, num_iterations);
for iteration = 1:num_iterations
    iteration
    temperature = sqrt(num_iterations + 1 - iteration) / 5;
    if iteration == 1
        temperature = initial_temperature;
    end

    % Evaluate energy at current position and plot it
    current_energy = peaks(current_x, current_y);
    marker_plot.XData = current_x;
    marker_plot.YData = current_y;

    % Generate proposal distribution and evaluate acceptance probability
    proposal_distribution = z_values;
    proposal_distribution(:) = mvnpdf([x_grid(:) y_grid(:)], [current_x current_y]);
    acceptance_probability = min(exp(-(current_energy - z_values) / temperature), 10);
    P = proposal_distribution .* acceptance_probability;
    surface_plot(1).CData = P * 100;

    % Convert probabilities to a distribution
    P(P < 0.01) = 0;
    P = P(:) ./ sum(P(:));

    % Draw new sample from the distribution
    drawnow
    pause(temperature / 400)
    if iteration <= 2 || (iteration > 750 && iteration < 800)
        pause
    end
    sample_idx = find(mnrnd(1, P));
    [x_idx, y_idx] = ind2sub(size(surface_plot(1).CData), sample_idx);
    if iteration > 1
        current_x = x_grid(1, y_idx);
        current_y = y_grid(x_idx, 1);
    end
    energies(iteration) = current_energy;
end
