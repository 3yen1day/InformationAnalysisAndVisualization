//有向グラフでの表現とPageRank

import edu.uci.ics.jung.graph.Graph;
import edu.uci.ics.jung.graph.DirectedSparseGraph;
import edu.uci.ics.jung.algorithms.layout.KKLayout;
import edu.uci.ics.jung.algorithms.layout.Layout;
import java.awt.Dimension;
import javax.swing.JFrame;

PrintWriter file; 

//ノード数
int vl = 20;
//エッジ数
int el = 25;
//ランダムサーフ値
float rs = 0;

void setup() {
  file = createWriter("test.csv");

  Graph<String, String> graph
    = new DirectedSparseGraph<String, String>();
  for (int i=0; i<vl; i++) {
    graph.addVertex("v" + i );
  }
  for (int i=0; i<el; i++) {
    int a = int(random(0, vl));
    int b = int(random(0, vl));
    if (a==b)b = int(random(0, vl));
    graph.addEdge("e"+i, "v" + a, "v" + b);
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