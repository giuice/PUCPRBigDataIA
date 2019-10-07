import java.security.Key;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import javax.crypto.Cipher;

public class RSA {

	  public static final String ALGORITHM = "RSA";

	  public static byte[] encrypt(String text, Key key) {
		    byte[] cipherText = null;
		    try {
			    // get an RSA cipher object and print the provider
			    Cipher cipher = Cipher.getInstance(ALGORITHM);
			    // encrypt the plain text using the key
			    cipher.init(Cipher.ENCRYPT_MODE, key);
			    cipherText = cipher.doFinal(text.getBytes());
		    } catch (Exception e) {
		    	e.printStackTrace();
		    }
		    return cipherText;
	  }
  
	  public static String decrypt(byte[] text, Key key) {
			byte[] dectyptedText = null;
			try {
				// get an RSA cipher object and print the provider
				Cipher cipher = Cipher.getInstance(ALGORITHM);				
				// decrypt the text using the key
				cipher.init(Cipher.DECRYPT_MODE, key);
				dectyptedText = cipher.doFinal(text);
			
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			
			return new String(dectyptedText);
	  }
	    
	  public static void main(String[] args) 
	  {	
		    try 
		    {			
		    	KeyPairGenerator keyGen = KeyPairGenerator.getInstance(ALGORITHM);
			    keyGen.initialize(1024);
			    KeyPair key = keyGen.generateKeyPair();
		    					
				PublicKey publicKey = key.getPublic();
				PrivateKey privateKey = key.getPrivate();
					
				String originalText = "O Java SE possui um conjunto amplo de bibliotecas, ferramentas e implementações de segurança.";
				
				byte[] cipherText = encrypt(originalText, publicKey);					
				String plainText = decrypt(cipherText, privateKey);
					
				System.out.println("Original: " + originalText);
				System.out.println("Cifrado: " + new String(cipherText));
				System.out.println("Decifrado: " + plainText);
				
		    } 
		    catch (Exception e) {
		        e.printStackTrace();
		    }
	  }
}