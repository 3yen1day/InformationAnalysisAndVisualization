//各地域の結核有病率表示
//2019/08/02


import  de.bezier.data.sql.*; 
SQLite db;
PImage img;


String reg[] = new String [7];
Integer avg20[] = new Integer [7];
Integer avg19[] = new Integer [7];


void setup() {
  size(800, 300);
  img = loadImage("sekaichizu.png");
  int i=0;

  db = new SQLite( this, "TB_Country.db" ); // open DB file
  if ( db.connect() ) { 
    //
    String sql = "SELECT region, year, perpeople, avg(perpeople), max(perpeople) FROM TB_table";
    sql += " where year = '2013'";
    sql += " group by region";
    db.query( sql ); 
    println("2013年");
    while ( db.next() ) { 
      reg[i]=db.getString("region");
      avg20[i]=db.getInt("avg(perpeople)");

      println( db.getString("region") +": "+ db.getInt("avg(perpeople)")+"人/million");
      println("最大" + db.getInt("max(perpeople)")+"人");
      i++;
    }
  }
  i=0;


  println("");
  println("");
  println("1993年");

  String sql2 = "SELECT region, year, perpeople, avg(perpeople), max(perpeople) FROM TB_table";
  sql2 += " where year = '1993'";
  sql2 += " group by region";
  db.query( sql2 );
  while ( db.next() ) { 
    avg19[i]=db.getInt("avg(perpeople)");

    println(db.getString("region") +": "+ db.getInt("avg(perpeople)")+"人/million");
    println("最大" + db.getInt("max(perpeople)")+"人");
    i++;
  }
}


void draw() {
  background(255, 255, 255);
  image(img, 0, 0);
  fill(0, 0, 0);
  textSize(24);
  text("Estimated prevalence",530,35); 
  text("of TB (all forms)",590,62);
  /*
  ellipse(380, 90, 10, 10);
   ellipse(380, 220, 10, 10);
   ellipse(50, 190, 10, 10);
   ellipse(100, 120, 10, 10);
   ellipse(50, 90, 10, 10);
   ellipse(160, 170, 10, 10);
   ellipse(200, 100, 10, 10);
   ellipse(200, 220, 10, 10);
   */

  if ( dist( mouseX, mouseY, 50, 170) < 30 ) {
    text("Africa", 530, 110);
    TextShow(0);
  } else if ( dist( mouseX, mouseY, 380, 90) < 100 )
  {
    text("Americas", 530, 110);
    TextShow(1);
  } else if ( dist( mouseX, mouseY, 380, 220) < 100 ) {
    text("Americas", 530, 110);
    TextShow(1);
  } else if ( dist( mouseX, mouseY, 100, 120) < 30 ) {
    text("Eastern Mediterranean", 530, 110);
    TextShow(2);
  } else if ( dist( mouseX, mouseY, 30, 90) < 50 ) {
    text("Europe", 530, 110);
    TextShow(3);
  } else if ( dist( mouseX, mouseY, 160, 170) < 30 ) {
    text("South-East Asia", 530, 110);
    TextShow(4);
  } else if ( dist( mouseX, mouseY, 200, 100) < 50 ) {
    text("Western Pacific", 530, 110);
    TextShow(5);
  } else if ( dist( mouseX, mouseY, 200, 220) < 50 ) {
    text("Western Pacific", 530, 110);
    TextShow(5);
  }
}


void TextShow(int num) {
  textSize(20);
  text("2013",530, 150);
  text(avg20[num]+"/million people", 530, 175);
  text("1993",530, 210);
  text(avg19[num]+"/million people", 530, 230);
  text("Decreased: " + str(avg19[num]-avg20[num]) +"/million", 530, 275);
}