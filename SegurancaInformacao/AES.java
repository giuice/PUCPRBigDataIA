import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;

public class AES 
{
	public static byte[] cifra(String texto, String chave) throws InvalidKeyException, IllegalBlockSizeException, BadPaddingException, NoSuchAlgorithmException, NoSuchPaddingException, UnsupportedEncodingException
	{
		return cifra(texto.getBytes(), chave);
	}
	
	public static byte[] cifra(byte[] texto, String chave) 
			throws IllegalBlockSizeException, BadPaddingException, NoSuchAlgorithmException, NoSuchPaddingException, UnsupportedEncodingException, InvalidKeyException
	{
		Key key = 
				new SecretKeySpec(chave.getBytes(StandardCharsets.UTF_8), "AES");
		
		
		Cipher cifrador = Cipher.getInstance("AES");
		cifrador.init(Cipher.ENCRYPT_MODE, key);
		byte[] textoCifrado = cifrador.doFinal(texto);
		return textoCifrado;
	}	
	
	public static String decifra(byte[] texto, String chave) 
			throws IllegalBlockSizeException, BadPaddingException, NoSuchAlgorithmException, NoSuchPaddingException, UnsupportedEncodingException, InvalidKeyException
	{
	  	 Key key = 
	  			 new SecretKeySpec(chave.getBytes(StandardCharsets.UTF_8), "AES");
		 Cipher decifrador = Cipher.getInstance("AES");
		 decifrador.init(Cipher.DECRYPT_MODE, key);
    	 byte[] textoDecifrado = decifrador.doFinal(texto);
    	 return new String(textoDecifrado);
	}	
	
	public static void main(String[] args) throws Exception {
		try
		{						
			String chave = "bolabolabolabola"; //tamanho: 16
			String texto = "O Java SE possui um conjunto amplo de bibliotecas, ferramentas e implementações comumente utilizadas em algoritmos, mecanismos e protocolos de segurança.";
			
			byte[] textoCifrado = AES.cifra(texto, chave);
			String textoDecifrado = AES.decifra(textoCifrado, chave);
			System.out.println(new String(textoCifrado));
			System.out.println(textoDecifrado);
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
}
