// apply.c     "LIGHTHOUSE" NESTED SAMPLING APPLICATION
// (GNU General Public License software, (C) Sivia and Skilling 2006)
//              u=0                                 u=1
//               -------------------------------------
//          y=2 |:::::::::::::::::::::::::::::::::::::| v=1
//              |::::::::::::::::::::::LIGHT::::::::::|
//         north|::::::::::::::::::::::HOUSE::::::::::|
//              |:::::::::::::::::::::::::::::::::::::|
//              |:::::::::::::::::::::::::::::::::::::|
//          y=0 |:::::::::::::::::::::::::::::::::::::| v=0
// --*--------------*----*--------*-**--**--*-*-------------*--------
//             x=-2          coastline -->east      x=2
// Problem:
//  Lighthouse at (x,y) emitted n flashes observed at D[.] on coast.
// Inputs:
//  Prior(u)    is uniform (=1) over (0,1), mapped to x = 4*u - 2; and
//  Prior(v)    is uniform (=1) over (0,1), mapped to y = 2*v; so that
//  Position    is 2-dimensional -2 < x < 2, 0 < y < 2 with flat prior
//  Likelihood  is L(x,y) = PRODUCT[k] (y/pi) / ((D[k] - x)^2 + y^2)
// Outputs:
//  Evidence    is Z = INTEGRAL L(x,y) Prior(x,y) dxdy
//  Posterior   is P(x,y) = L(x,y) / Z estimating lighthouse position
//  Information is H = INTEGRAL P(x,y) log(P(x,y)/Prior(x,y)) dxdy
/*__________________________________________________________________*/
#define n    100   // # Objects
#define MAX 1000   // # iterates
/*__________________________________________________________________*/
typedef struct
{
    double  u;     // Uniform-prior controlling parameter for x
    double  v;     // Uniform-prior controlling parameter for y
    double  x;     // Geographical easterly position of lighthouse
    double  y;     // Geographical northerly position of lighthouse
    double  logL;  // logLikelihood = ln Prob(data | position)
    double  logWt; // log(Weight), adding to SUM(Wt) = Evidence Z
} Object;
/*__________________________________________________________________*/
double logLhood(   // logLikelihood function
double  x,         // Easterly position
double  y)         // Northerly position
{
    int  N = 64;   // # arrival positions
    double D[64] =   { 4.73,  0.45, -1.73,  1.09,  2.19,  0.12,
  1.31,  1.00,  1.32,  1.07,  0.86, -0.49, -2.59,  1.73,  2.11,
  1.61,  4.98,  1.71,  2.23,-57.20,  0.96,  1.25, -1.56,  2.45,
  1.19,  2.17,-10.66,  1.91, -4.16,  1.92,  0.10,  1.98, -2.51,
  5.55, -0.47,  1.91,  0.95, -0.78, -0.84,  1.72, -0.01,  1.48,
  2.70,  1.21,  4.41, -4.79,  1.33,  0.81,  0.20,  1.58,  1.29,
 16.19,  2.75, -2.38, -1.79,  6.50,-18.53,  0.72,  0.94,  3.64,
  1.94, -0.11,  1.57,  0.57};  // up to N=64 data
    int    k;                  // data index
    double logL = 0;           // logLikelihood accumulator
    for( k = 0; k < N; k++ )
        logL += log((y/3.1416) / ((D[k]-x)*(D[k]-x) + y*y));
    return logL;
}
/*__________________________________________________________________*/
void Prior(        // Set Object according to prior
Object* Obj)       // Object being set
{
    Obj->u = UNIFORM;               // uniform in (0,1)
    Obj->v = UNIFORM;               // uniform in (0,1)
    Obj->x = 4.0 * Obj->u - 2.0;    // map to x
    Obj->y = 2.0 * Obj->v;          // map to y
    Obj->logL = logLhood(Obj->x, Obj->y);
}
/*__________________________________________________________________*/
void Explore(      // Evolve object within likelihood constraint
Object* Obj,       // Object being evolved
double  logLstar)  // Likelihood constraint L > Lstar
{
    double  step = 0.1;   // Initial guess suitable step-size in (0,1)
    int     m    = 20;    // MCMC counter (pre-judged # steps)
    int     accept = 0;   // # MCMC acceptances
    int     reject = 0;   // # MCMC rejections
    Object  Try;          // Trial object
    for( ; m > 0; m-- )
    {
// Trial object
        Try.u = Obj->u + step * (2.*UNIFORM - 1.);  // |move| < step
        Try.v = Obj->v + step * (2.*UNIFORM - 1.);  // |move| < step
        Try.u -= floor(Try.u);      // wraparound to stay within (0,1)
        Try.v -= floor(Try.v);      // wraparound to stay within (0,1)
        Try.x = 4.0 * Try.u - 2.0;  // map to x
        Try.y = 2.0 * Try.v;        // map to y
        Try.logL = logLhood(Try.x, Try.y);  // trial likelihood value
// Accept if and only if within hard likelihood constraint
        if( Try.logL > logLstar )
        {  *Obj = Try;  accept++;  }
        else
            reject++;
// Refine step-size to let acceptance ratio converge around 50%
        if( accept > reject )    step *= exp(1.0 / accept);
        if( accept < reject )    step /= exp(1.0 / reject);
    }
}
/*__________________________________________________________________*/
void Results(     // Posterior properties, here mean and stddev of x,y
Object* Samples,  // Objects defining posterior
int     nest,     // # Samples
double  logZ)     // Evidence (= total weight = SUM[Samples] Weight)
{
    double x = 0.0, xx = 0.0;   // 1st and 2nd moments of x
    double y = 0.0, yy = 0.0;   // 1st and 2nd moments of y
    double w;                   // Proportional weight
    int    i;                   // Sample counter
    for( i = 0; i < nest; i++ )
    {
        w = exp(Samples[i].logWt - logZ);
        x  += w * Samples[i].x;
        xx += w * Samples[i].x * Samples[i].x;
        y  += w * Samples[i].y;
        yy += w * Samples[i].y * Samples[i].y;
    }
    printf("mean(x) = %g, stddev(x) = %g\n", x, sqrt(xx-x*x));
    printf("mean(y) = %g, stddev(y) = %g\n", y, sqrt(yy-y*y));
}
