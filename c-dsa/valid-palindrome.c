#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

bool validPalindrome(char* s);

int main(void) {
    char* s = "my teacher told me to get the car off the driveway!!";
    if (validPalindrome(s) == 1) {
        printf("its a palindrome!!");
    }
    else { printf("sorry its not a palindrome!");}
}

bool validPalindrome(char* s) {
    int i=0, j=strlen(s)-1;
    while (i < j){
        if (tolower(s[i])!= tolower(s[j]))
            return false;
        else {
            ++i; --j;
        }
    }
    return true;
}