import java.util.Collections;

float rad;
int hexWid;
int hexHei;
int numShaded;

ArrayList hexes;

void setup()
{
  hexWid = 15;
  int canvasWid = 450;
  rad = canvasWid/(hexWid * 2);
  
  float a = sin(60 * PI/180) * rad; //half a hex height
  float b = sin(30 * PI/180) * rad; //half a hex width
  
  hexHei = 2 * hexWid;
  numShaded = 150;
  
  int canvasHei = Math.round(hexHei * 2 * a);
  System.out.println("canvas height: " + canvasHei);
  System.out.println("hex height: " + hexHei);
  System.out.println("b: " + b);
  System.out.println("a: " + a);

  size(canvasWid, canvasHei, P2D);
  background(255);
  noStroke();

  hexes = new ArrayList();

  for (int row = 0; row <= hexHei; row++)
  {
    float yOffset = a * row;

    for (int col = 0; col <= hexWid; col++)
    {
      float rowOffset = row % 2 * (rad + b);
      float xOffset = 3 * rad * col + rowOffset;

      Hexagon hex = new Hexagon(xOffset, yOffset, rad);
      hexes.add(hex);
    }
  }
  
  Collections.shuffle(hexes);
  
  for (int i = 0; i < numShaded; i++)
  {
    Hexagon hex = (Hexagon)hexes.get(i);
    hex.setCol(0);
  }
  /*
  for (int j = 0; j < hexes.size(); j++)
  {
    Hexagon hex = (Hexagon)hexes.get(j);
    
    
  }*/
}

void draw() 
{  
  for (int k = 0; k < hexes.size(); k++)
  {
    Hexagon hex = (Hexagon)hexes.get(k);
    hex.display();
  }
  
 // save("hexes.png");
 // exit();
}

class Hexagon {
  float x, y, radi;
  float col = 255;
  float angle = 360.0 / 6;

  Hexagon(float cx, float cy, float r)
  {
    x=cx;
    y=cy;
    radi=r;
  }
  
  void setCol(float value)
  {
    col = value;
  }

  void display() {
    fill(col);
    beginShape();
    for (int i = 0; i < 6; i++)
    {
      vertex(x + radi * cos(radians(angle * i)), 
      y + radi * sin(radians(angle * i)));
    }
    endShape(CLOSE);
  }
}

