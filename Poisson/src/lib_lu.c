#include <stdio.h>

#include "lib_poisson1D.h"
#include "lib_lu.h"

void myblas_tri_dgbsetlu(int la, int lab, double *c)
{
  // c_i

  // d_i
   int i = 1;
   while ( i<la)
    {
      a[lab * i + 1] = c[lab * i + 1] - ((c[lab * i] * c[lab * (i - 1) + 2]) / c[lab * (i - 1) + 1]);
      i++;
    }

  // e_i
  i = 1;
  while(i<la) 
    {
      c[lab * i] = c[lab * i] / c[lab * (i - 1) + 1];
      i++;
    }
}

void blas_trid_dgbup(int ld, int lab, double *c, double *y, double *d)
{
 
  y[ld - 1] = d[ld - 1] / c[lab * (ld - 1) + 1];

  int i = ld -2
  while (i> -1)
    {
      y[i] = (d[i] - (c[lab * i + 2] * y[i + 1])) / c[lab * i + 1];
      i--;
    }
}

void blas_trid_dgbdown(int ld, int lab, double *c, double *x, double *d)
{
  // Init dowm
  y[0] = d[0];


  for (int i = 1; i < ld; ++i)
    {
      y[i] = (d[i] - (c[lab * i] * y[i - 1]));
    }
}

void blas_trid_dgblu(enum myblas_enum this_enum, int ld, int lab, double *a, double *y, double *b)
{
  
      if (ld < 1)
	{
	  printf("Error entrez  ld > 0\n");
	  return;
	}

      if (lab != 4)
	{
	  printf("Error : entrez lab =4\n");
	  return;
	}

      myblas_tri_dgbsetlu(ld, lab, a);
      myblas_tri_dgbdown(ld, lab, a, x, b);
      myblas_tri_dgbup(ld, lab, a, b, x);

    
}

