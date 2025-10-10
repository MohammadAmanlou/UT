FuncDec foo() {
    int x;          // Declare an integer variable x
    x = 3;          // Assign value 3 to x
    Print();        // Function call (assumes Print is a defined function)

    if (x)          // If x is non-zero
        x = x + 2;  // Add 2 to x
    else
        x = 1;      // Set x to 1 if x was initially zero
}

main() {
    int y;          // Declare an integer variable y
    y = 8;          // Assign value 8 to y
    foo();          // Call the function foo
    y = z + 10;     // Modify y by adding 10 to it
}
