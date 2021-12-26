
//
n = 50;
T0 = -5;
T1 = 5;
e = 10^(-8);
max_count = 10^5;

y_data_j_n = zeros(n);
y_data_g_n = zeros(n);
y_data_j_n_relres = zeros(n);
y_data_g_n_relres = zeros(n);

for i = 1:n

//
A = mat_chal(i);
b = vec_chal(i, T0, T1);

//
[vec_j, count_j, relres_j, void] = jacobi(A, b, e, max_count);
[vec_g, count_g, relres_g, void] = gauss_seidel(A, b, e, max_count);

//
y_data_j_n(i) = count_j;
y_data_g_n(i) = count_g;

//
y_data_j_n_relres(i) = relres_j;
y_data_g_n_relres(i) = relres_g;

end

//
xtitle("Evolution of number of iteration per matrix size", "sizes of matrix", "number of iteration");
plot([1:n], [y_data_j_n y_data_g_n]);
legend(["jacobi" "gauss seidel"], 2);
xs2png(0, "img/number_of_iteration.png");
clf();

//
xtitle("Evolution of relative error per matrix size", "sizes of matrix", "relative error");
plot([1:n], [log(y_data_j_n_relres) log(y_data_g_n_relres)]);
legend(["jacobi" "gauss seidel"], 2);
xs2png(0, "img/number_of_iteration_relres.png");
clf();


// Error vary
n = 10;
y_data_j_e = zeros(n);
y_data_g_e = zeros(n);
y_data_j_e_relres = zeros(n);
y_data_g_e_relres = zeros(n);

error_vec = [10^(-1), 10^(-2), 10^(-3), 10^(-4), 10^(-5), 10^(-6), 10^(-7), 10^(-8), 10^(-9), 10^(-10), 10^(-11), 10^(-12), 10^(-13), 10^(-14), 10^(-15)];

for i = 1:12

//
A = mat_chal(n);
b = vec_chal(n, T0, T1);

//
e = error_vec(i);

//
[vec_j, count_j, relres_j, void] = jacobi(A, b, e, max_count);
[vec_g, count_g, relres_g, void] = gauss_seidel(A, b, e, max_count);

//
y_data_j_e(i) = count_j;
y_data_g_e(i) = count_g;

//
y_data_j_e_relres(i) = relres_j;
y_data_g_e_relres(i) = relres_g;

end

//
xtitle("Evolution of number of iteration per desired error", "error", "number of iteration");
plot([1:12], [y_data_j_e y_data_g_e]);
legend(["jacobi" "gauss seidel"], 2);
xs2png(0, "img/error.png");
clf();

//
xtitle("Evolution of relative error per desired error", "sizes of matrix", "relative error");
plot([1:12], [log(y_data_j_e_relres) log(y_data_g_e_relres)]);
legend(["jacobi" "gauss seidel"], 2);
xs2png(0, "img/error_relres.png");
clf();

// Convergence
n = 10;
e = 10^(-8);
max_count = 550;

A = mat_chal(n);
b = vec_chal(n, T0, T1);

[x_j, count_j, void, resvec_j] = jacobi(A, b, e, max_count);
[x_g, count_g, void, resvec_g] = gauss_seidel(A, b, e, max_count);
disp(max(size(relres_j)));

xtitle("Convergence", "number of iteration", "residual result");
plot(log10(resvec_j), "k.")
plot(log10(resvec_g), ".r")
legend(["jacobi" "gauss seidel"], 2);
xs2png(0, "img/convergence.png");
clf();
