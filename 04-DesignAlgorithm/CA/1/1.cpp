#include <iostream>
#include <vector>
#include <string>

using namespace std;

int findMin(vector<int> *arr,int low,int high){
    if(high == low){
        return arr->at(low);
    }
    int mid = (int)((low + high)/2);
    int h = findMin(arr,  mid + 1, high);
    int l = findMin(arr, low, mid );
    if(  h > l){
        return l;
    }
    else{
        return h;
    }

}

int main()
{
    int n ;
    cin >> n;
    //cin.clear();
    //cin.ignore(numeric_limits<streamsize>::max(), '\n');
    vector<int> arr;
    for(int i=0;i< n ; i++){
        int a;
        cin >> a;
        arr.push_back(a);
    }
    int m = findMin(&arr, 0, n-1);
    for (int i=n-1 ; i>=0;i--){
        if(m == arr[i]){
            cout << "(" << i <<"," << m << ")" << endl;
            break;
        }
    }
 
    return 0;
}

