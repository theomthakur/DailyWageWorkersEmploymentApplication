#include<iostream>
using namespace std;
#include <string>

void (*Funptr)(int,int);

void mult(int i,int j)
{
  cout<<i*j;    
}

void mult(int i,int j,int k)
{
    cout<<(i*j*k);
}
void main()
{
    Funptr ptr;
    ptr=&mult;
    ptr(2,3,4);

}

