
/* afproev bit operationer */
/*
<programlisting>
&    bitvis AND               1 & 1 == 1; 17 & 1 == 1;
|    bitvis OR                1 | 0 == 1; 17 | 1 == 17;
^    bitvis XOR               1 ^ 0 == 1; 17 ^ 1 == 16;
~    bitvis NOT               ~1    == 0x[...]fffe;
>>   shift right              1 >>1 == 0; 17 >>1 == 8;
<<   shift left               1 <<1 == 2; 17 <<1 == 34;
</programlisting>
*/

main()
{
    printf("17 >> 1 == %d \n",17>>1);
    return 0;
}


