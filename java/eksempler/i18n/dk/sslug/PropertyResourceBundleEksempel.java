package dk.sslug;

import java.util.Enumeration;
import java.util.Locale;
import java.util.ResourceBundle;

public class PropertyResourceBundleEksempel
{
  public static void main(String[] args)
  {
    udskrivVaerdier(new Locale("da", "DK"));
    udskrivVaerdier(new Locale("de"));
    udskrivVaerdier(new Locale("fr", "CA"));
  }
  
  private static void udskrivVaerdier(Locale locale)
  {
    ResourceBundle logIndBundt =
      ResourceBundle.getBundle("dk.sslug.LogInd", locale);
    Enumeration enum = logIndBundt.getKeys();
    while (enum.hasMoreElements()) {
      String noegle = (String) enum.nextElement();
      System.out.println(noegle +" = " + logIndBundt.getString(noegle));
    }
    System.out.println();
  }
}

