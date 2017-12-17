#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[]) {
    int n = argc > 1 ? atoi(argv[1]) : 50000000;
    int steps = 314;
    int* nodes = malloc(n * sizeof(int));

    nodes[0] = 0;
    int pos = 0;

    for (int i = 0; i < n; i++) {
        if (i % 1000000 == 0) {
            printf("%d\n", i);
        }
        for (int s = 0; s < steps; s++) {
            pos = nodes[pos];
        }
        nodes[i+1] = nodes[pos];
        nodes[pos] = i+1;
        pos = i+1;
    }

    printf("%d\n", nodes[0]);
    return 0;
}
