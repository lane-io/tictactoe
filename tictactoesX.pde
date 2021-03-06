//Server (sends x's (2))
import processing.net.*;

Server myServer;
int[][] grid;

void setup() {//r c
  size (300, 300);
  grid = new int[3][3];
  strokeWeight (3);
  textAlign (CENTER, CENTER);
  textSize (50);
  myServer = new Server(this, 1234);
}

void draw() {
  background (255);

  stroke (0);
  line (20, 100, 280, 100);
  line (20, 200, 280, 200);
  line (100, 20, 100, 280);
  line (200, 20, 200, 280);

  int row = 0;
  int col = 0;
  while (row < 3) {
    drawXO (row, col);
    col++;
    if (col == 3) {
      col = 0;
      row++;
    }
  }
  Client myClient = myServer.available();
  if (myClient != null) {
    String incoming = myClient.readString();
    int r = int(incoming.substring(0,1));
    int c = int(incoming.substring(2,3));
    grid [r][c] = 1;
  }
}

void drawXO (int row, int col) {
  pushMatrix();
  translate (row*100, col*100);
  if (grid[row][col] == 1) {
    fill (255);
    ellipse (50, 50, 90, 90);
  } else if (grid[row][col] == 2) {
    line (10, 10, 90, 90);
    line (90, 10, 10, 90);
  }
  popMatrix();
}

void mouseReleased() {
  int row = mouseX/100;
  int col = mouseY/100;
  if (grid[row][col] == 0) {
    myServer.write(row + "," + col);
    grid[row][col] = 2;
  }
}
