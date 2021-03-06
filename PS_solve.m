clear;

step = 0.28;
eps1 = 0.0125;
eps2 = 0.0025;
eps3 = 10^(-3)/0.0025;
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
    options = optimoptions('patternsearch', 'MaxFunctionEvaluations', max_calls, 'MeshTolerance', eps2, 'InitialMeshSize', step);
    x_0 = zeros(5, 1);
    for i = 1:5
        x_0(i)  = constraint(i, 1) + initial(p(j), i) * (constraint(i, 2) - constraint(i, 1));
    end
    
    f = @(x) Scaled_Solid_Tank_Problem(x);
    [x, fval, exitflag, output] = patternsearch(f, x_0, [], [], [], [], [0; 0; 0; 0; 0], [1; 1; 1; 1; 1], [], options);
    save("FlexDos_PS_Result_" + num2str(j) + ".mat")
    max_calls = max_calls - output.funccount;
    j = j + 1;
    
end