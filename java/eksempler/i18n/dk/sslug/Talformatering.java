package dk.sslug;

import java.util.Locale;
import java.text.DecimalFormat;
import java.text.NumberFormat;

public class Talformatering
{
  public static void main(String[] args)
  {
    Locale[] locales = NumberFormat.getAvailableLocales();
    for (int i = 0; i < locales.length; i++) {
      System.out.println(locales[i].toString());
      formatterTal(locales[i]);
      formatterBeloeb(locales[i]);
      formatterProcent(locales[i]);
      System.out.println();
    }
  }
  
  public static void formatterTal(Locale locale) {
    NumberFormat nf = NumberFormat.getNumberInstance(locale);
    String heltal     = nf.format(123456789);
    String decimaltal = nf.format(123456.789);
    System.out.println(heltal);
    System.out.println(decimaltal);
  }
  
  public static void formatterBeloeb(Locale locale) {
    NumberFormat cf = NumberFormat.getCurrencyInstance(locale);
    cf.setMaximumFractionDigits(2);
    String beloeb = cf.format(123456.789);
    System.out.println(beloeb);
  }
  
  public static void formatterProcent(Locale locale) {
    NumberFormat pf = NumberFormat.getPercentInstance(locale);
    String procent = pf.format(1.42);
    System.out.println(procent);
  }
}

