#include <iostream>
#include <cmath>
#include <numbers>

using namespace std;

// Taylorjev razvoj za arctan(x)
double calcAtan(double* x, int* N_steps)
{
    double sum = 0.0;

    for (int n = 0; n < *N_steps; n++)
    {
        sum += pow(-1, n) * pow(*x, 2 * n + 1) / (2 * n + 1);
    }

    return sum;
}

// f(x) = e^(3x) * arctan(x/2)
double f(double x, int N_steps)
{
    double arg = x / 2;
    double atan_val = calcAtan(&arg, &N_steps);
    return exp(3 * x) * atan_val;
}

int main()
{
    const double a = 0;
    const double b = numbers::pi / 4;

    int n;          // število trapezov
    int N_steps;    // število clenov Taylorjeve vrste

    cout << "Vnesi stevilo trapezov n: ";
    cin >> n;

    cout << "Vnesi stevilo clenov Taylorjeve vrste: ";
    cin >> N_steps;

    double dx = (b - a) / n;
    double integral = 0.0;

    // Trapezna metoda
    integral += f(a, N_steps);
    for (int i = 1; i < n; i++)
    {
        double x = a + i * dx;
        integral += 2.0 * f(x, N_steps);
    }
    integral += f(b, N_steps);

    integral *= dx / 2.0;

    cout << "Priblizna vrednost integrala je: " << integral << endl;

    return 0;
}


