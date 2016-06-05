import java.io.*;
import java.lang.*;
import java.util.*;

class Process {

// OPTION:
// 0 - ekstracja wartosci z nawiasow
// 1 - wstawianie plci
// 2 - ekstrakcja numeru lekarza rodzinnego
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
	while (in.hasNextLine()) { 
		String line = in.nextLine();
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
		}
		
	} 

	File file = new File(ofname);
	FileWriter fileWriter = new FileWriter(file);
	fileWriter.write(res.toString());
	fileWriter.close();
}

}
