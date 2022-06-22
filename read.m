clear;

e = 1;

scores = zeros(1, e);
optimum = zeros(5, e);
scaled_optimum = zeros(5, e);

for k  = 1:e
    load("ClearView_surrogateopt_Result.mat");
    %scores(k) = Point_List(x_best_index(end)).Value;
    %optimum(:, k) = Point_List(x_best_index(end)).Point;
    optimum(:, k) = x;
    scores(k) = fval;
end
constraint = [200, 400; -30 30; 40 100; 40 80; 0 50];

%{
for i = 1:e
    for j = 1:5
        scaled_optimum(j, i)  = constraint(j, 1) + optimum(j, i) * (constraint(j, 2) - constraint(j, 1));
    end
    scaled_optimum(:, i) = proj(scaled_optimum(:, i), constraint);
    scaled_optimum(5, i) = scaled_optimum(5, i)  ;
end
%}

[M, I] = min(scores);
-M
optimum(:, I)
[score, BeamUni, ImageMag, EffRad] = Solid_Tank_Problem(optimum(:, I))

%scaled_optimum(:, I)