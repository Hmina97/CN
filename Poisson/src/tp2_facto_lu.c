#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "lib_poisson1D.h"
#include "lib_lu.h"

int main()
{
  // Constant
  int lab = 3;
  int la = 10;
  int kv = 0;
  double T0 = -5.0;
  double T1 = 5.0;

  // Allocation
  double *A = aligned_alloc(64, sizeof(double) * la * lab);
  double *RHS = aligned_alloc(64, sizeof(double) * la);
  double *X = aligned_alloc(64, sizeof(double) * la);
  double *EX_SOL = aligned_alloc(64, sizeof(double) * la);

  // Set vector and matrix
  set_grid_points_1D(X, &la);
  set_dense_RHS_DBC_1D(RHS,&la,&T0,&T1);
  set_analytical_solution_DBC_1D(EX_SOL, X, &la, &T0, &T1);
  set_GB_operator_colMajor_poisson1D(A, &lab, &la, &kv);

  // Facto LU
  printf("--------- Facto LU ---------\n");
  myblas_tri_dgblu(MyblasNoTrans, la, lab, A, X, RHS);

  write_vec(RHS, &la, "LU.dat");

  /* Relative residual for tridiag LU */
  double temp = cblas_ddot(la, RHS, 1, RHS,1);
  temp = sqrt(temp);
  cblas_daxpy(la, -1.0, RHS, 1, EX_SOL, 1);

  double relres = cblas_ddot(la, EX_SOL, 1, EX_SOL, 1);
  relres = sqrt(relres);
  relres = relres / temp;
  
  printf("\nThe relative residual error is relres = %e\n", relres);
  
  printf("\n----------- End ------------\n");

  // Free
  free(A);
  free(X);
  free(EX_SOL);
  free(RHS);
  
  return 0;
}
