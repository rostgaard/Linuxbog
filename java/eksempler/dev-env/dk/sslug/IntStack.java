package dk.sslug;

/**
 * Denne klasse repræsenterer en simpel stak, der
 * lagrer heltal.
 *
 * @author Jonas Kongslund (jonas@kongslund.dk)
 * @version 1.1
 */
public class IntStack
{
  /** Antal elementer i stakken */
  protected int count;

  /**
   * Indeholder stakkens elementer. Elementerne er placeret
   * i <code>elements[0...count-1]</code>.
   * <p>
   * Toppen af stakken er <code>count-1</code>
   * når <code>count>0</code> og ellers udefineret.
   *
   * @see #pop()
   * @see #push(int)
   */
  protected int[] elements;

  /**
   * Standardkonstruktør for denne klasse.
   */
  public IntStack()
  {
    /* Øvelse: implementer metoden sådan at
       elements og count initialiseres til
       nogle fornuftige værdier */
  }

  /**
   * Fjerner og returnerer det øverste tal på stakken.
   *
   * @return int Det øverste tal på stakken
   * @exception java.util.EmptyStackException
   *            hvis stakken er tom
   */
  public int pop() throws java.util.EmptyStackException
  {
    /* Øvelse: implementer metoden */
    return -1;
  }

  /**
   * Placerer det angivne tal øverst på stakken.
   *
   * @param element Tallet der skal lægges på stakken
   */
  public void push(int element)
  {
    /* Øvelse: implementer metoden så stakken
       udvides såfremt den er fyldt */
  }

  /**
   * Placerer det angivne tal øverst på stakken.
   *
   * @param element Tallet der skal lægges på stakken
   * @deprecated Siden version 1.1; Metoden er
   *   erstattet af <code>push(int)</code>.
   * @see #push(int)
   */
  public void skub(int element)
  {
    push(element);
  }
}
