import java.io.*;
import java.lang.*;
import java.util.*;

class Process {

// ARGS
// 0 - INPUT FILE
// 1 - OPTION
// 2 - OUTPUT FILE


// OPTION:
// 0 - ekstracja wartosci z nawiasow
// 1 - wstawianie plci
// 2 - ekstrakcja numeru lekarza rodzinnego
// 3 - przetworzenie wielu INSERT na jeden INSERT
public static void main(String[] args) {

	String file = args[0];
	int option = Integer.valueOf(args[1]);
	String ofile = args[2];

	try {
		process(file,ofile,option);

	} catch (FileNotFoundException e) {
		e.printStackTrace();
	} catch (IOException e) {
		e.printStackTrace();
	}

}


static Random r = new Random(System.currentTimeMillis());

private static void process(String fname, String ofname, int opt) throws FileNotFoundException, IOException {

	Scanner in = new Scanner(new FileReader(fname));

	StringBuilder res = new StringBuilder();
	int c = 0;
	while (in.hasNextLine()) { 
		String line = in.nextLine();
		c++;
		switch (opt) {
			case 0:
				// ekstracja wartosci z nawiasow
				if (line.contains("INSERT")) {
				int idx1 = line.indexOf('\'');
				int idx2 = line.indexOf('\'',idx1 + 1);
				res.append(line.substring(idx1 + 1,idx2)).append('\n');
				//System.out.println("appending: " + line.substring(idx1 + 1,idx2));
				} else {
					res.append('\n');
				}
				break;
			case 1:
				// wstawianie plci
				int rand = r.nextInt(2);
				char sex = 'M';
				if (rand == 0)
					sex = 'K';
				//System.out.println("sex is: " + sex);
				String newOne = "\'" + sex + "\'";
				res.append(line.replaceAll("\' \'",newOne)).append('\n');
				break;
			case 2:
				// ekstrakcja numeru
				int idx1 = line.indexOf(',');
				int idx2 = idx1 + 7;
				res.append(line.substring(idx1 + 1,idx2)).append('\n');
				
				break;
			case 3:
				// przetworzenie wielu INSERT na jeden INSERT
				if (c == 1) {
					res.append(line.substring(0,line.length() - 1)).append(',').append('\n');
				} else {
					int i1 = line.indexOf("VALUES") + 7;
					int i2 = line.indexOf(";",i1);
					res.append(line.substring(i1,i2)).append(',').append('\n');
				}
				break;
		}
		
	} 

	if (opt == 3) {
		res.setLength(res.length() - 2);
		res.append(';');

	}

	File file = new File(ofname);
	FileWriter fileWriter = new FileWriter(file);
	fileWriter.write(res.toString());
	fileWriter.close();
}

}
