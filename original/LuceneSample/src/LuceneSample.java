
import org.apache.lucene.search.spell.JaroWinklerDistance;
import org.apache.lucene.search.spell.StringDistance;

public class LuceneSample {

	private static void displayDistance(StringDistance sd, String str1, String str2) {
		float d = sd.getDistance(str1, str2);
		System.out.printf("str1[%s] str2[%s] d=%f\n", str1,str2,d);
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		  StringDistance sd = new JaroWinklerDistance();
		  
		  displayDistance(sd, "henka", "henkan");
		  displayDistance(sd, "al", "al");
		  displayDistance(sd, "martha", "marhta");
		  displayDistance(sd, "jones", "johnson");
		  displayDistance(sd, "abcvwxyz", "cabvwxyz");
		  displayDistance(sd, "dwayne", "duane");
		  displayDistance(sd, "dixon", "dicksonx");
		  displayDistance(sd, "fvie", "ten");
		  
		  // This program displays:
		  //   str1[henka] str2[henkan] d=0.972222
		  //   str1[al] str2[al] d=1.000000
		  //   str1[martha] str2[marhta] d=0.961111
		  //   str1[jones] str2[johnson] d=0.832381
		  //   str1[abcvwxyz] str2[cabvwxyz] d=0.958333
		  //   str1[dwayne] str2[duane] d=0.840000
		  //   str1[dixon] str2[dicksonx] d=0.813333
		  //   str1[fvie] str2[ten] d=0.000000
	}

}
