/* chemical balance Mohammad.Amanlou :))*/
#include <stdio.h>
/* including the libraries*/
/* defining a function to find lcm ....  */
/* we know lcm = gcd / Multiplication */
int lcm(int fir_inp, int sec_inp) {
    int zarb;
    zarb = fir_inp * sec_inp;
    while (fir_inp != sec_inp) {
        if (fir_inp > sec_inp) {
            fir_inp -= sec_inp;
        }
        else :
        sec_inp -= fir_inp;
        return fir_inp;
        /* gcd found*/
    }
    answer = zarb / fir_inp;
    /* lcm found */
    return(answer);
}
int main()
{
    /*we can find the numbers by check the condition and then count the elements in two side and act as the denominator of the subscription */
    while (1) {
        int a, b, c, d, e, f, g, h, X = 1, Y = 1, Z = 1, T = 1;
        printf("in the submass XAaBb+YCcDd ------> ZAeDf+TCgBh please enter a,b,c,d,e,f,g,h with a space between\n");
        scanf_s("%d %d %d %d %d %d %d %d", &a, &b, &c, &d, &e, &f, &g, &h);
        /* we know if e * d * g * b = a * f * c * h we can balance it */
        if ((e * d * g * b) == (a * f * c * h)) {
            Z = Z * (((lcm(X * a, e * Z)) / (e * Z)));
            X = X * (((lcm(X * a, e * Z)) / (X * a)));
            X = X * (((lcm(X * b, h * T)) / (X * b)));
            T = T * ((lcm(h * T, b * X)) / (h * T));
            T = T * (((lcm(c * Y, g * T)) / (g * T)));
            Y = Y * (((lcm(c * Y, g * T)) / (c * Y)));
            Y = Y * (((lcm(d * Y, f * Z)) / (d * Y)));
            Z = Z * (((lcm(d * Y, f * Z)) / (f * Z)));
            // printf("%dA%dB%d+%dC%dD%d -----> %dA%dD%d+%dC%dB%d\n", X, a, b, Y, c, d, Z, e, f, T, g, h);
            printf("%d %d %d %d", X, Y, Z, T);
        }
        else {
            //printf("-1\n -1 means we dont have a submass with this numbers\n");
            printf("-1");
        }
    }
    return 0;
}
/* GL :)*/