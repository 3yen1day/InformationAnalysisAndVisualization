//PageRank値が0.4以上となるようなノードの作成
//ランダムサーフ値は0.15

import edu.uci.ics.jung.graph.Graph;
import edu.uci.ics.jung.graph.DirectedSparseGraph;
import edu.uci.ics.jung.algorithms.layout.KKLayout;
import edu.uci.ics.jung.algorithms.layout.Layout;
import java.awt.Dimension;
import javax.swing.JFrame;

PrintWriter file; 

//ノード数
int vl = 100;
//エッジ数
//int el = vl-1;
//ランダムサーフ値
float rs = 0.15;

void setup() {
  
  file = createWriter("test.csv");

  Graph<String, String> graph
    = new DirectedSparseGraph<String, String>();
  for (int i=0; i<vl-1; i++) {
    graph.addVertex("v" + i );
  }
  

  for (int i=0; i<vl-1; i++) {
    if (int(i%2)==0) {
      graph.addEdge("e"+i, "v" + i, "v" + (i+1));
      graph.addEdge("e"+(i+vl), "v" + i, "v" + (vl-1));
    } else {
      graph.addEdge("e"+i, "v" + i, "v" + (vl-1));
    }
  }
  if(vl%2==0){
    graph.addEdge("e"+vl*2, "v" + (vl-2), "v" + (vl-1));
  }




  file.println("Graph = " + graph.toString());

  Dimension viewArea = new Dimension(900, 600);
  Layout<String, String> layout =
    new KKLayout<String, String>(graph);
  BasicVisualizationServer<String, String> panel = 
    new BasicVisualizationServer<String, String>
    (layout, viewArea);
  panel.getRenderContext().setVertexLabelTransformer
    (new ToStringLabeller<String>());
  //panel.getRenderContext().setEdgeLabelTransformer
  //(new ToStringLabeller<String>());

  // PageRankの値を計算する準備。ランダムサーフのdを第2引数で指定 
  PageRank<String, String> pr = new PageRank<String, String>(graph, rs); 
  pr.evaluate(); // 計算！
  // ノードのPageRank値を出力する 
  for (int i=0; i<vl; i++) {
    file.print(i + " ; ");
    file.println( pr.getVertexScore( "v" + i ) );
    print(i + " ; ");
    println( pr.getVertexScore( "v" + i ) );
  }



  JFrame frame = new JFrame("Graph View");
  frame.getContentPane().add(panel);
  frame.pack();
  frame.setVisible(true);

  file.flush();
  file.close();
}