#include <stdio.h>
  

int main()
{
    int A[20] ={450   ,-64   ,-679,  1779 , 69 ,
               -1595 , 1678 , 1884 , -649 , 18 ,
                337 , -1764 , 1725 , 919 , 758 ,
               -584 , 82 , -1972 , -1375 , 683 };

    int index = 0;
    int min_value = 0;

    for(int i =0 ; i < 20; i++){
        if(A[i] < min_value){
            min_value = A[i];
            index =i;
        }
    }

    printf("%d %d", min_value , index);

    return 0;
}
