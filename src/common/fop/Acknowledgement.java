package common.fop;

import java.io.File;

public class Acknowledgement {

	public static void main(String[] args) {
		try {
			FOP_Java_Engine.build(new File("example-2/Acknowledgement.xml"), new File("example-2/Acknowledgement.xsl"), new File("example-2/Acknowledgement.pdf"));
		} catch (Exception e) {			
			e.printStackTrace();
		}
	}

}
