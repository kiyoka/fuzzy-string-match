
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
	}

}
