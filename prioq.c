#include "alloc.h"
#include "gen_allocdefs.h"
#include "prioq.h"

GEN_ALLOC_readyplus(prioq,struct prioq_elt,p,len,a,i,n,x,100,prioq_readyplus)

int prioq_min(pq,pe)
prioq *pq;
struct prioq_elt *pe;
{
  struct prioq_elt *x;

  x = pq->p;
  if (!x) return 0;
  if (!pq->len) return 0;
  *pe = x[0];
  return 1;
}

int prioq_insert(pq,pe)
prioq *pq;
struct prioq_elt *pe;
{
  int i;
  int j;
  struct prioq_elt *x;

  if (!prioq_readyplus(pq,1)) return 0;
  x = pq->p;

  i = pq->len++;
  while (i) {
    j = (i - 1) >> 1;
    if (x[j].dt <= pe->dt) break;
    x[i] = x[j];
    i = j;
  }
  x[i] = *pe;

  return 1;
}

void prioq_delmin(pq)
prioq *pq;
{
  int i;
  int j;
  int n;
  struct prioq_elt *x;

  x = pq->p;
  if (!x) return;

  n = pq->len;
  if (!n) return;
  --n;
  pq->len = n;

  i = 1;
  while ((j = i + i) < n) {
    if (x[j].dt > x[j - 1].dt) {
      x[i - 1] = x[j];
      i = j + 1;
    }
    else {
      x[i - 1] = x[j - 1];
      i = j;
    }
  }
  if (j == n) {
    x[i - 1] = x[j - 1];
    i = j;
  }
  while (i > 1) {
    j = i >> 1;
    if (x[n].dt <= x[j - 1].dt) break;
    x[i - 1] = x[j - 1];
    i = j;
  }
  x[i - 1] = x[n];
}
