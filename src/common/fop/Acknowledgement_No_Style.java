package common.fop;

import java.io.File;

public class Acknowledgement_No_Style {

	public static void main(String[] args) {
		try {
			FOP_Java_Engine.build(new File("example-2/Acknowledgement.xml"), new File("example-2/Acknowledgement-no-style.xsl"), new File("example-2/Acknowledgement-no-style.pdf"));
		} catch (Exception e) {			
			e.printStackTrace();
		}
	}

}
