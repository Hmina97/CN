#ifndef lib_lu_h
#define lib_lu_h

void myblas_tri_dgbsetlu(int la, int lab, double *a);
void myblas_tri_dgbup(int ld, int lab, double *a, double *x, double *b);
void myblas_tri_dgbdown(int ld, int lab, double *a, double *x, double *b);
void myblas_tri_dgblu(enum myblas_enum my_enum, int ld, int lab, double *a, double *x, double *b);

#endif
