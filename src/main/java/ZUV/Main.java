package ZUV;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.xml.transform.TransformerException;
import javax.xml.transform.stream.StreamSource;
/*
import org.oclc.purl.dsdl.svrl.FailedAssert;
import org.oclc.purl.dsdl.svrl.SchematronOutputType;

import com.helger.schematron.ISchematronResource;
import com.helger.schematron.xslt.SchematronResourceXSLT;
*/
public class Main {
	
	static final ClassLoader cl = Main.class.getClassLoader();

	

	public static void main(String[] args) {
		

		System.out.println("Creating xsl files...");

		try {
			String filename="ZUGFeRDSchematronStylesheetXSLT1.xsl";
			SchematronPipeline.processSchematron(cl.getResourceAsStream("ZUGFeRD_1p0.scmt"), new FileOutputStream() );
			System.err.println("Written "+filename);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TransformerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println("Validating...");

		String schematronValidationString = "";

		// final ISchematronResource aResSCH =
		// SchematronResourceSCH.fromFile (new File("ZUGFeRD_1p0.scmt"));
		// ... DOES work but is highly deprecated (and rightly so) because
		// it takes 30-40min,

		try {

			/***
			 * private static final String VALID_SCHEMATRON = "test-sch/valid01.sch";
			 * private static final String VALID_XMLINSTANCE = "test-xml/valid01.xml";
			 * 
			 * @Test public void testWriteValid () throws Exception { final Document aDoc =
			 *       SchematronResourceSCH.fromClassPath (VALID_SCHEMATRON)
			 *       .applySchematronValidation (new ClassPathResource (VALID_XMLINSTANCE));
			 * 
			 */

			//final ISchematronResource aResSCH = SchematronResourceXSLT.fromClassPath("/ZUGFeRDSchematronStylesheet.xsl");
		/*	final ISchematronResource aResSCH = SchematronResourceXSLT.fromFile(new File("/Users/jstaerk/workspace/ZUV/src/main/resources/ZUGFeRDSchematronStylesheet.xsl"));

			// takes around 10 Seconds.
			// http://www.bentoweb.org/refs/TCDL2.0/tsdtf_schematron.html
			// explains that
			// this xslt can be created using sth like
			// saxon java net.sf.saxon.Transform -o tcdl2.0.tsdtf.sch.tmp.xsl -s
			// tcdl2.0.tsdtf.sch iso_svrl.xsl
			if (!aResSCH.isValidSchematron()) {
				throw new IllegalArgumentException("Invalid Schematron!");
			}
			SchematronOutputType sout = aResSCH.applySchematronValidationToSVRL(new StreamSource(
					new FileInputStream(new File("/Users/jstaerk/workspace/ZUV/ZUGFeRD-invoice.xml"))));
			List<Object> failedAsserts = sout.getActivePatternAndFiredRuleAndFailedAssert();
			for (Object object : failedAsserts) {
				if (object instanceof FailedAssert) {
					FailedAssert failedAssert = (FailedAssert) object;
					System.out.println(failedAssert.getText());
					System.out.println(failedAssert.getTest());
				}
			}
			for (String currentString : sout.getText()) {
				System.out.print(".");
				schematronValidationString += currentString;
			}
*/
		} catch (

		Exception ex) {
			ex.printStackTrace();
		}
		System.out.println(schematronValidationString);

	}
}
