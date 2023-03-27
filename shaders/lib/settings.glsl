#define NETHER_RADIUS -32 //[-32 -16 -8 -4 0 4 8 16 32] Radius of the nether.
#define OVER_RADIUS 16 //[-32 -16 -8 -4 0 4 8 16 32] Radius of the overworld.
#define END_RADIUS 16 //[-32 -16 -8 -4 0 4 8 16 32] Radius of the end.

#ifdef WRLD_NETHER
    #define RADIUS NETHER_RADIUS
#endif

#ifdef WRLD_OVER
    #define RADIUS OVER_RADIUS
#endif

#ifdef WRLD_END
    #define RADIUS END_RADIUS
#endif

#ifndef RADIUS
    #define RADIUS 0.0
#endif
