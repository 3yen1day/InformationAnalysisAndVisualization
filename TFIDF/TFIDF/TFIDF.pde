// 章ごと（カンマ区切り）のTFIDF値を求めるプログラム

import org.atilika.kuromoji.Token;
import org.atilika.kuromoji.Tokenizer;
import java.util.*;
PrintWriter file; 

String temp = "00";
String moziretu = "";
int count =0;
int AllWords = 0;
String[] text = new String [27];
String[] text2 = new String [27];
int j=0;
int wordCount = 10;
String textAll = ""; 


void start() {
  file = createWriter("test.csv");
  // 処理対象の文字列の配列を取得
  String [] lines = loadStrings( "Nichirin_tab.txt" );
  for ( int i=0; i<lines.length; i++ ) {
    textAll+=lines[i];
  }
  for ( int i=0; i<text.length; i++ ) {
    text[i] = "";
  }
  String[] text = (split(textAll, ","));
  
    for ( int i=0; i<text2.length; i++ ) {
    text2[i] = text[i];
  }

  for ( int i=0; i<text.length; i++ ) {
    //text[i] =  " ";


    file.println("");
    file.println(i);
    //println(text[i]);
    //file.println(text[i]);
    //file.println(i);
    textCount(text[i]);
  }

  file.flush();
  file.close();
  exit();
}


void textCount(String a) {
  // 処理対象の文字列 
  String target = a; // Tokenizerの初期化（kuromojiのための初期化） 
  Tokenizer tokenizer = Tokenizer.builder().build(); 
  List<Token> list_token = tokenizer.tokenize( target );
  // Stringをキーとし，Integer(int)を値として持つハッシュを作成！
  HashMap<String, Integer> bag_of_words = new HashMap(); 
  for ( Token token : list_token ) { 
    String[] features = token.getAllFeaturesArray(); // HashMapに指定の単語がなければ1をセットし，あれば今の値に1増やす
    if ( bag_of_words.get( token.getSurfaceForm() ) == null ) { 
      bag_of_words.put( token.getSurfaceForm(), 1 );
    } else { 
      int count = bag_of_words.get( token.getSurfaceForm() ); 
      count++; 
      bag_of_words.put( token.getSurfaceForm(), count );
    }
  }

  ArrayList entries = new ArrayList(bag_of_words.entrySet()); 
  Collections.sort(entries, new Comparator() { 
    public int compare(Object obj1, Object obj2) { 
      Map.Entry ent1 =(Map.Entry)obj1; 
      Map.Entry ent2 =(Map.Entry)obj2; 
      return (int)ent2.getValue() - (int)ent1.getValue();
    }
  } 
  );

  for ( int i=0; i<entries.size(); i++ ) { 
    Map.Entry ent = (Map.Entry)entries.get(i); 
    int value = (Integer)ent.getValue(); 

    String b = "" + ent.getKey();
  
  //TFIDF値
    float tfidf =TFIDF(value, AllWords(a), CountXTexts(b));
    if (tfidf>0.02 && tfidf<1.0) {
      file.println(ent.getKey()+ ","+tfidf);
      println(ent.getKey()+ ","+tfidf);
    }
    //println( ent.getKey() + ": " +AllWords(a)+", "+ value +", "+CountXTexts(b));
    wordCount = 0;
  }
}


int AllWords(String w) {
  // 処理対象の文字列 
  String target = w; // Tokenizerの初期化（kuromojiのための初期化） 
  Tokenizer tokenizer = Tokenizer.builder().build(); 
  List<Token> list_token = tokenizer.tokenize( target );
  // Stringをキーとし，Integer(int)を値として持つハッシュを作成！
  HashMap<String, Integer> bag_of_words = new HashMap(); 
  for ( Token token : list_token ) { 
    String[] features = token.getAllFeaturesArray(); // HashMapに指定の単語がなければ1をセットし，あれば今の値に1増やす
    if ( bag_of_words.get( token.getSurfaceForm() ) == null ) { 
      bag_of_words.put( token.getSurfaceForm(), 1 );
    } else { 
      int count = bag_of_words.get( token.getSurfaceForm() ); 
      count++; 
      bag_of_words.put( token.getSurfaceForm(), count );
    }
  }

  ArrayList entries = new ArrayList(bag_of_words.entrySet()); 
  Collections.sort(entries, new Comparator() { 
    public int compare(Object obj1, Object obj2) { 
      Map.Entry ent1 =(Map.Entry)obj1; 
      Map.Entry ent2 =(Map.Entry)obj2; 
      return (int)ent2.getValue() - (int)ent1.getValue();
    }
  } 
  );

  for ( int i=0; i<entries.size(); i++ ) { 
    Map.Entry ent = (Map.Entry)entries.get(i); 
    int value = (Integer)ent.getValue(); 
    if (value>=1) {
      wordCount+=value;
    }
  }
  return wordCount;
}


//単語Xを含む文書数産出
int CountXTexts(String word) {
  int Bunsyosuu=0;

  for (int i=0; i<text2.length; i++) {
    if (!(text2[i].indexOf(word)==-1)) {
      Bunsyosuu++;
    }
  }
  return Bunsyosuu;
}


float TFIDF(float A, float B, float C) {
  float TF = A/B;
  float IDF = log(152/C);
  return TF * IDF;
}