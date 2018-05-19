package common.fop;

import java.io.File;

public class HelloWorld {

	public static void main(String[] args) {
		
		try {
			FOP_Java_Engine.build(new File("example-1/HelloWorld.xml"), new File("example-1/HelloWorld.xsl"), new File("example-1/HelloWorld.pdf"));
		} catch (Exception e) {			
			e.printStackTrace();
		}
	}

}
