// Function to reverse a number
int reverseNumber(int num):
    int reversedNum = 0
    while (num > 0):
        reversedNum = (reversedNum * 10) + (num % 10)
        num /= 10

    return reversedNum
end

int main():
    int number

    // Get input from the user
    printf("Enter an integer: ")
    scanf("%d", &number)

    // Handle negative numbers (not palindromes)
    if (number < 0):
        printf("%d is not a palindrome.\n", number)
        return 0


    // Check if the number is a palindrome
    int reversed = reverseNumber(number)
    if (number == eversed):
        printf("%d is a palindrome.\n", number)
    else:
        printf("%d is not a palindrome.\n", number)


    return 0
end