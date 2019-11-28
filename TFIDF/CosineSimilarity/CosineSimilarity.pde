//コサイン類似度の算出（未完成）

import org.atilika.kuromoji.Token;
import org.atilika.kuromoji.Tokenizer;
import java.util.*;
PrintWriter file; 


String[] text = new String [27];
int j=0;
String textAll = ""; 
String[][] words = new String [30][50000];



void start() {
  file = createWriter("test.csv");
  // 処理対象の文字列の配列を取得
  String [] lines = loadStrings( "Nichirin_tab.txt" );
  for ( int i=0; i<lines.length; i++ ) {
    textAll+=lines[i];
  }
  for ( int i=0; i<text.length; i++ ) {
    text[i]="";
  }
  for ( int i=0; i<30; i++ ) {
    for ( int j=0; j<50000; j++ ) {
      words[i][j]="";
    }
  }

  String[] text = (split(textAll, ","));


  AllWords(textAll, 0);

  for (int i=0; i<text.length; i++ ) {
    AllWords(text[i], i+1);
  }


  file.flush();
  file.close();
  exit();
}


//全単語出す
void AllWords(String w, int chapter) {
  println(chapter+"章");
  Tokenizer tokenizer = Tokenizer.builder().build();
  HashMap<String, Integer> bag_of_words = new HashMap();


  List<Token> list_token = tokenizer.tokenize( w );
  for ( Token token : list_token ) {
    String[] features = token.getAllFeaturesArray();
    // HashMapに指定の単語がなければ1をセットし，あれば今の値に1増やす
    if ( bag_of_words.get( token.getSurfaceForm() ) == null ) {
      bag_of_words.put( token.getSurfaceForm(), 1 );
    } else {
      int count = bag_of_words.get( token.getSurfaceForm() );
      count++;
      bag_of_words.put( token.getSurfaceForm(), count );
    }
  }
  // bag_of_wordsの中身を表示！
  // キーのセットからイテレータを作成する
  // ちなみにキーはString型なのでIteratorもString型になっている
  Iterator<String> iterator = bag_of_words.keySet().iterator();
  // 次があればwhileが繰り返される！
  while (iterator.hasNext ()) {
    // 次の値を取得する！
    String key = iterator.next();
    // keyをもとに値を取得する


    if (chapter==0) {
      words[0][j] = key;
      //file.println(key + "," + bag_of_words.get(key));
    } else {
      for (int k=0; k<50000; k++ ) {
        if (words[0][k].equals(key)==true) {
          words[chapter][k] = str(bag_of_words.get(key));
        }
      }
    }
    j++;
  }
  for (int l=0; l<50000; l++) {
    file.println(words[chapter][l]);
  }
}