/* floating point version af bogpris1 */
/* til alle praktiske formål den fornuftigste version! */
/* til teoretiske formål kan det være generende, at vi */
/* ikke ved, om der gemmer sig nogle betydende decimaler */
/* efter de første 6 */

main()
{
    double bogpris = 360;
    double afgift = 1.0/3.0;

    printf("Afgift %f\n",bogpris * afgift);
    return 0;
}

