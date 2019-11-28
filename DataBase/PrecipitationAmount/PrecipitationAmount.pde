//マウスオーバーで各都道府県の年平均降水量表示
//2019/08/02

import de.bezier.data.sql.*;
import de.bezier.data.sql.mapper.*;
SQLite db;
PImage img;
float [] posX = new float [47];
float [] posY = new float [47];
float [] col = new float [47];
float [] RFL = new float [47];
String [] ken = new String [47];



void setup() {
  size(700, 750);
  img = loadImage("japan_map.gif");
  db = new SQLite( this, "weather.db" ); // open DB file 
  if ( db.connect() ) { 
    String sql = "SELECT year,avg(rainfall_level),name,x,y FROM weather_table, prefecture_table WHERE weather_table.prefecture_id = prefecture_table.id" + " group by id" ; 
    db.query( sql ); 
    int i = 0;
    while ( db.next() ) { 

      posX[i]=db.getInt("x");
      posY[i]=db.getInt("y");
      RFL[i]=db.getFloat("avg(rainfall_level)");
      ken[i]=db.getString("name");
      float rain = db.getFloat("avg(rainfall_level)")*60;
      col[i]=1/pow(rain, 2)*20000;

      println( db.getString( "name" ) ); 
      println( db.getInt("x") + ", " + db.getInt("y") ); 
      println(RFL[i]);

      i++;
    }
  }
}

void draw() {
  image(img, 0, 0);
  for ( int i=0; i<47; i++ ) {
    fill(col[i], col[i], 255);
    if ( dist( mouseX, mouseY, posX[i], posY[i]) > 10 ) { 
      ellipse( posX[i], posY[i], 10, 10 );
    } else { 
      ellipse( posX[i], posY[i], 30, 30 );
      fill(0, 0, 0);
      textSize(20);
      text(ken[i], 50, 50);
      text("rainfall_level: "+RFL[i], 50, 100);
    }
  }
}