package dk.sslug;

import junit.framework.TestCase;
import dk.sslug.IntStack;

public class TestIntStack extends TestCase
{
  public TestIntStack(String name)
  {
    super(name);
  }

  protected void setUp() throws Exception
  {
    // Ikke noget her indtil videre
  }

  protected void tearDown() throws Exception
  {
    // Ikke noget her indtil videre
  }

  public void testPushPop()
  {
    IntStack stack = new IntStack();
    stack.push(10);
    stack.push(20);
    stack.push(30);
    assertTrue( stack.pop() == 30 );
    assertTrue( stack.pop() == 20 );
    assertTrue( stack.pop() == 10 );
  }

  public void testEmptyStackException()
  {
    IntStack stack = new IntStack();
    try {
      stack.pop();
      fail("Burde have smidt en EmptyStackException");
    } catch (java.util.EmptyStackException e) {
    }
  }

}
