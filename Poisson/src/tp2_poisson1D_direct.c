/******************************************/
/* tp2_poisson1D_direct.c                 */
/* This file contains the main function   */
/* to solve the Poisson 1D problem        */
/******************************************/

#include <stdio.h>
#include <string.h>
#include "lib_poisson1D.h"



int main(int argc,char *argv[])
/* ** argc: Number of arguments */
/* ** argv: Values of arguments */
{
  if (argc != 2)
    {
      printf("Error nb arg\n");
      return  0;
    }



  int ierr;
  int jj;
  int nbpoints, la;
  int ku, kl, kv, lab;
  int *ipiv;
  int info;
  int NRHS;
  double T0, T1;
  double *RHS, *B, *EX_SOL, *X, *Y;
  double *AB;

  double temp, relres;
  
  /* Size of the problem */
  NRHS=1;
  nbpoints=12;
  la=nbpoints-2;
  T0=-5.0;
  T1=5.0;

  printf("--------- Poisson 1D ---------\n\n");
  RHS=(double *) malloc(sizeof(double)*la);
  B=(double *) malloc(sizeof(double)*la);
  EX_SOL=(double *) malloc(sizeof(double)*la);
  X=(double *) malloc(sizeof(double)*la);
  Y=(double *) malloc(sizeof(double)*la);

  set_grid_points_1D(X, &la);
  set_dense_RHS_DBC_1D(RHS,&la,&T0,&T1);
  set_dense_RHS_DBC_1D(B,&la,&T0,&T1);
  set_analytical_solution_DBC_1D(EX_SOL, X, &la, &T0, &T1);
  
  write_vec(RHS, &la, "RHS.dat");
  write_vec(EX_SOL, &la, "EX_SOL.dat");
  write_vec(X, &la, "X_grid.dat");

  kv=1;
  ku=1;
  kl=1;
  lab=kv+kl+ku+1;

  AB = (double *) malloc(sizeof(double)*lab*la);

  info=0;

  
  ipiv = (int *) calloc(la, sizeof(int));

  if (row != 1){ 
    
    
    set_GB_operator_colMajor_poisson1D(AB, &lab, &la, &kv);
    write_GB_operator_colMajor_poisson1D(AB, &lab, &la, "AB_col.dat");

    info = LAPACKE_dgbsv(LAPACK_COL_MAJOR,la, kl, ku, NRHS, AB, lab, ipiv, RHS, la);

    
    kv = 0;
    lab--;
    free(AB);
    AB = (double *) malloc(sizeof(double)*lab*la);

    // Compute
    set_GB_operator_colMajor_poisson1D(AB, &lab, &la, &kv);
    cblas_dgbmv(CblasColMajor, CblasNoTrans, la, la, kl, ku, 1.0, AB, lab, EX_SOL, 1, 0.0, Y, 1);
    write_vec(Y, &la, "Y_col.dat");
  } 
  
  
  else {
    set_GB_operator_rowMajor_poisson1D(AB, &lab, &la, &kv);
    write_GB_operator_rowMajor_poisson1D(AB, &lab, &la, "AB_row.dat");

    info = LAPACKE_dgbsv(LAPACK_ROW_MAJOR,la, kl, ku, NRHS, AB, la, ipiv, RHS, NRHS);

    // Matrice x Vecteur
   
    kv = 0;
    lab--;
    free(AB);
    AB = (double *) malloc(sizeof(double)*lab*la);

    // Compute
    set_GB_operator_colMajor_poisson1D(AB, &lab, &la, &kv);
    cblas_dgbmv(CblasRowMajor, CblasNoTrans, la, la, kl, ku, 1.0, AB, lab, EX_SOL, 1, 0.0, Y, 1);
    write_vec(Y, &la, "Y_row.dat");
  }    

  
 
  write_xy(RHS, X, &la, "SOL.dat");

  /* Relative residual for DGBSV */
  temp = cblas_ddot(la, RHS, 1, RHS,1);
  temp = sqrt(temp);
  cblas_daxpy(la, -1.0, RHS, 1, EX_SOL, 1);
  relres = cblas_ddot(la, EX_SOL, 1, EX_SOL,1);
  relres = sqrt(relres);
  relres = relres / temp;
  
  printf("\nThe relative residual error is relres = %e\n",relres);

  printf("\n DGBSV :\n");

  write_vec(B, &la, "B.dat");
  
  /* Résidu relatif pour DGBSV */
 
 
  temp = cblas_ddot(la, Y, 1, Y,1);
  temp = sqrt(temp);
  // B - Y
  cblas_daxpy(la, -1.0, Y, 1, B, 1);
  // la norme de B
  relres = cblas_ddot(la, B, 1, B,1);
  relres = sqrt(relres);
  // Resultat de norm(B - Y) / norm(B)
  relres = relres / temp;
  
  printf("\n'erreur résiduelle relative est relres",relres);

  free(RHS);
  free(EX_SOL);
  free(B);
  free(X);
  free(Y);
  free(AB);
  free(ipiv);

  printf("\n\n--------- End -----------\n");
}
