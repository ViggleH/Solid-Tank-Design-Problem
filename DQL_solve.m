clear;

rng(0);

step = 0.28;
eps1 = 0.0125;
eps2 = 0.0025;
eps3 = 10^(-2)/0.0125;
max_calls = 3125;
constraint = [0, 1; 0, 1; 0, 1; 0, 1; 0, 1];
j = 1;

initial = [1/4, 1/4, 1/4, 1/4, 1/4;
          1/4, 1/4, 1/4, 1/4, 3/4;
          1/4, 1/4, 1/4, 3/4, 1/4;
          1/4, 1/4, 1/4, 3/4, 3/4;
          1/4, 1/4, 3/4, 1/4, 1/4;
          1/4, 1/4, 3/4, 1/4, 3/4;
          1/4, 1/4, 3/4, 3/4, 1/4;
          1/4, 1/4, 3/4, 3/4, 3/4;
          1/4, 3/4, 1/4, 1/4, 1/4;
          1/4, 3/4, 1/4, 1/4, 4/4;
          1/4, 3/4, 1/4, 3/4, 1/4;
          1/4, 3/4, 1/4, 3/4, 3/4;
          1/4, 3/4, 3/4, 1/4, 1/4;
          1/4, 3/4, 3/4, 1/4, 3/4;
          1/4, 3/4, 3/4, 3/4, 1/4;
          1/4, 3/4, 3/4, 3/4, 3/4;
          3/4, 1/4, 1/4, 1/4, 1/4;
          3/4, 1/4, 1/4, 1/4, 3/4;
          3/4, 1/4, 1/4, 3/4, 1/4;
          3/4, 1/4, 1/4, 3/4, 3/4;
          3/4, 1/4, 3/4, 1/4, 1/4;
          3/4, 1/4, 3/4, 1/4, 3/4;
          3/4, 1/4, 3/4, 3/4, 1/4;
          3/4, 1/4, 3/4, 3/4, 3/4;
          3/4, 3/4, 1/4, 1/4, 1/4;
          3/4, 3/4, 1/4, 1/4, 4/4;
          3/4, 3/4, 1/4, 3/4, 1/4;
          3/4, 3/4, 1/4, 3/4, 3/4;
          3/4, 3/4, 3/4, 1/4, 1/4;
          3/4, 3/4, 3/4, 1/4, 3/4;
          3/4, 3/4, 3/4, 3/4, 1/4;
          3/4, 3/4, 3/4, 3/4, 3/4;
          ];

p = randperm(32, 32);

while max_calls >= 11
    
    x_0 = zeros(5, 1);
    for i = 1:5
        x_0(i)  = constraint(i, 1) + initial(p(j), i) * (constraint(i, 2) - constraint(i, 1));
    end
    
    f = @(x) Scaled_Solid_Tank_Problem(x);
    [Point_List, x_best_index, stop, time, s, calls, iter] = DQL(f, x_0, step, eps1, eps2, eps3, max_calls, 2, 3, 5, 1);
    save("Water_DQL_Result_" + num2str(j) + ".mat")
    max_calls = max_calls - calls;
    j = j + 1;
    
end