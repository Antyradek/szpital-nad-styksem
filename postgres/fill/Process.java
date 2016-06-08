import java.io.*;
import java.lang.*;
import java.util.*;

class Process {

// ARGS:
// 0 - INPUT FILE
// 1 - OPTION
// 2 - OUTPUT FILE
// 3 - LINES COUNT
// 4 - GENERATE RANDOM FROM
// 5 - GENERATE RANDOM TO
// 6 - COLUMN


// OPTION:
// 0 - ekstracja wartosci z nawiasow
// 1 - wstawianie plci
// 2 - ekstrakcja numeru lekarza rodzinnego
// 3 - przetworzenie wielu INSERT na jeden INSERT
// 4 - konwersja liczb na unikalne
public static void main(String[] args) {

	String file = args[0];
	int option = Integer.valueOf(args[1]);
	String ofile = args[2];
	String numsCount = args[3];
	String numsFrom = args[4];
	String numsTo = args[5];
	String column = args[6];
	try {
		process(file,ofile,option,numsCount,numsFrom,numsTo,column);

	} catch (FileNotFoundException e) {
		e.printStackTrace();
	} catch (IOException e) {
		e.printStackTrace();
	}

}


static Random r = new Random(System.currentTimeMillis());

private static void process(String fname, String ofname, int opt, String numsCount, String numsFrom, String numsTo, String column) throws FileNotFoundException, IOException {

	Scanner in = new Scanner(new FileReader(fname));
	StringBuilder res = new StringBuilder();

	// utils:
	int c = 0;

	// random option:
	int count = 0; 
	int from = 0; 
	int to = 0;
	int col = -1;
	if (opt == 4) {
		if (numsCount != null) 
			count = Integer.valueOf(numsCount);

		if (numsFrom != null) 
			from = Integer.valueOf(numsFrom);

		if (numsTo != null) 
			to = Integer.valueOf(numsTo);

		if (column != null) 
			col = Integer.valueOf(column);
	}

	HashSet<Integer> rNums = new HashSet<Integer>();
	int[] rands = new int[count];

	if (opt == 4) {
		System.out.println("Count is: " + count + " from: " + from + " to: " + to + ". Processing column: " + column);
		// unique random generation:
		while (rNums.size() < count) {
			int e = r.nextInt(to - from + 1) + from;
			rNums.add(e);
		}
		Object[] rNumsArr = rNums.toArray();
		for(int i = 0; i < rNumsArr.length; i++) {
			rands[i] = ((Integer)rNumsArr[i]).intValue();
		}
	}

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
			case 4:
				// konwersja liczb na unikalne
				int i14 = line.indexOf('(');
				int i24 = line.indexOf(",",i14);
				if (col > 0) { // przechodzenie po kolumnach
					int colCount = 0;
					while (colCount < col) {
						i14 = i24;
						i24 = line.indexOf(",",i14 + 1);
						colCount++;
					}
				}
				res.append(line.substring(0,i14 + 1));
				res.append(rands[c - 1]);
				res.append(line.substring(i24,line.length())).append('\n');
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
