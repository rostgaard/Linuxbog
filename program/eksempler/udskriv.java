// af Peter Stubbe <stubbe@bitnisse.dk>
// $Id$

// Oversættelse:
//  javac udskriv.java
// Afvikling:
//  java udskriv fil+

import java.io.*;

class udskriv {

    public static void main(String argv[]) {
	udskriv uds=new udskriv(argv);

    }

    public udskriv(String navne[]) {
	int argnr,len;
	LineNumberReader ls;
	FileReader r;
	String lin;

	len=navne.length;
	for(argnr=0; argnr<len; argnr++){
	    try{
		r=new FileReader(navne[argnr]);
	    }
	    catch(IOException e){
		System.out.println("Kan ikke åbne filen "+navne[argnr]+"!");
		return;
	    }
	    ls=new LineNumberReader(r);
	    try{
		lin=ls.readLine();
	    }
	    catch(IOException e){
		System.out.println("Kan ikke læse!");
		return;
	    }
	    while(null!=lin){
		System.out.println(ls.getLineNumber()+"\t"+lin);
		try{
		    lin=ls.readLine();
		}
		catch(IOException e){
		    System.out.println("Kan ikke læse!");
		    return;
		}
	    }
	    try{
		r.close();
	    }
	    catch(IOException e){
		System.out.println("Kan ikke lukke "+navne[argnr]+"!");
		return;
	    }
	}
	q();
    }

    public void q(){
	String ind;
	BufferedReader r;

	r=new BufferedReader(new InputStreamReader(System.in));
	do{
	    try{
		ind=r.readLine();
	    }
	    catch(IOException e){
		System.out.println("Kan ikke læse stdin!");
	    }
	    ind=ind.toUpperCase();
	}
	while(ind.compareTo("Q")!=0);
    }

}
