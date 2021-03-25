//                   NESTED SAMPLING MAIN PROGRAM
// (GNU General Public License software, (C) Sivia and Skilling 2006)
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <float.h>
#define UNIFORM ((rand()+0.5)/(RAND_MAX+1.0))  // Uniform inside (0,1)
#define PLUS(x,y) (x>y ? x+log(1+exp(y-x)) : y+log(1+exp(x-y)))
                          // logarithmic addition log(exp(x)+exp(y))
/*__________________________________________________________________*/
#include "apply.c"        // Application code, setting int n, int MAX,
                          // struct Object, void Prior,
                          // void Explore, void Results.
/*__________________________________________________________________*/
int main(void)
{
    Object Obj[n];        // Collection of n objects
    Object Samples[MAX];  // Objects stored for posterior results
    double logwidth;      // ln(width in prior mass)
    double logLstar;      // ln(Likelihood constraint)
    double H    = 0.0;    // Information, initially 0
    double logZ =-DBL_MAX;// ln(Evidence Z, initially 0)
    double logZnew;       // Updated logZ
    int    i;             // Object counter
    int    copy;          // Duplicated object
    int    worst;         // Worst object
    int    nest;          // Nested sampling iteration count
// Set prior objects
    for( i = 0; i < n; i++ )
        Prior(&Obj[i]);
// Outermost interval of prior mass
    logwidth = log(1.0 - exp(-1.0 / n));
// NESTED SAMPLING LOOP ______________________________________________
    for( nest = 0; nest < MAX; nest++ )
    {
// Worst object in collection, with Weight = width * Likelihood
        worst = 0;
        for( i = 1; i < n; i++ )
            if( Obj[i].logL < Obj[worst].logL )  worst = i;
        Obj[worst].logWt = logwidth + Obj[worst].logL;
// Update Evidence Z and Information H
        logZnew = PLUS(logZ, Obj[worst].logWt);
        H = exp(Obj[worst].logWt - logZnew) * Obj[worst].logL
          + exp(logZ - logZnew) * (H + logZ) - logZnew;
        logZ = logZnew;
// Posterior Samples (optional)
        Samples[nest] = Obj[worst];
// Kill worst object in favour of copy of different survivor
        do copy = (int)(n * UNIFORM) % n; // force 0 <= copy < n
        while( copy == worst && n > 1 );  // don't kill if n is only 1
        logLstar = Obj[worst].logL;       // new likelihood constraint
        Obj[worst] = Obj[copy];           // overwrite worst object
// Evolve copied object within constraint
        Explore(&Obj[worst], logLstar);
// Shrink interval
        logwidth -= 1.0 / n;
    } // _______ NESTED SAMPLING LOOP (might be ok to terminate early)
// Exit with evidence Z, information H, and optional posterior Samples
    printf("# iterates = %d\n", nest);
    printf("Evidence: ln(Z) = %g +- %g\n", logZ, sqrt(H/n));
    printf("Information: H = %g nats = %g bits\n", H, H/log(2.));
    Results(Samples, nest, logZ);         // optional
    return 0;
}
