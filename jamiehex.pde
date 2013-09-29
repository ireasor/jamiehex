import java.util.Collections;

float rad;
int canvasDimW;
int canvasDimH;
int numHexW;
int numHexH;
int numShaded;
int numCracks;

ArrayList<Hexagon> hexes;

void setup()
{
  numHexW = 15;
  numHexH = 30;
  numShaded = 100;
  numCracks = 10;

  canvasDimW = 900; //increments of 450 for HexW 15, H 30

  rad = canvasDimW/(numHexW * 2);
  float a = sin(60 * PI/180) * rad;
  float b = sin(30 * PI/180) * rad;

  canvasDimH = 2 * ceil(a) * (numHexH * 1/2) - 2;

  size(canvasDimW, canvasDimH, P2D);
  background(255);
  noStroke();

  hexes = new ArrayList();

  float maxY = 0;

  for (int row = 0; row <= numHexH; row++)
  {
    float y = a * row;

    for (int col = 0; col <= numHexW; col++)
    {
      float oddrowOffset = row % 2 * (rad + b);
      float x = col * 2 * (rad + b) + oddrowOffset;

      Hexagon hex = new Hexagon(x, y, rad);
      hexes.add(hex);
    }
    
    maxY = y;
  }

  Collections.shuffle(hexes);

  for (int i = 0; i < numShaded; i++)
  {
    Hexagon hex = hexes.get(i);
    hex.clr = 0;
  }

  for (Hexagon hex : hexes)
  {
    if (hex.clr != 255)
    {      
      if (hex.x == 0)
      {
        Hexagon targetHex = getHexagon(canvasDimW, hex.y);
        targetHex.clr = hex.clr;
      }
      else if (hex.x == canvasDimW)
      {
        Hexagon targetHex = getHexagon(0, hex.y);
        targetHex.clr = hex.clr;
      }
      else if (hex.y == 0)
      {
        Hexagon targetHex = getHexagon(hex.x, maxY);
        targetHex.clr = hex.clr;
      }
      else if (hex.y == maxY)
      {
        Hexagon targetHex = getHexagon(hex.x, 0);
        targetHex.clr = hex.clr;
      }
    }
  }
  
  getHexagon(0,0).clr = 0;
  getHexagon(0,maxY).clr = 0;
  getHexagon(canvasDimW,0).clr = 0;
  getHexagon(canvasDimW,maxY).clr = 0;
}

Hexagon getHexagon(float x, float y)
{
  for (Hexagon hex : hexes)
  {
    if (hex.x == x && hex.y == y)
    {
      return hex;
    }
  }

  return null;
}

void draw() 
{  
  for (int k = 0; k < hexes.size(); k++)
  {
    Hexagon hex = hexes.get(k);
    hex.display();
  }
  
  Collections.shuffle(hexes);
  
  for (int i = 0; i < numCracks; i++)
  {
    Hexagon hex = hexes.get(i);
    hex.drawCrack();
  }

  save("hexes.png");
  // exit();
}

class Hexagon {
  float x, y, radi;
  float clr = 255; //random(1, 255);
  float angle = 360.0 / 6;
  
  float a;
  float c;

  Hexagon(float cx, float cy, float r)
  {
    x=cx;
    y=cy;
    radi=r;
    a = sin(60 * PI/180) * r;
    c = a * .25;
  }

  void display() 
  {
    drawHex(); 
  }
  
  void drawHex()
  {
    fill(clr);
    beginShape();
    for (int i = 0; i < 6; i++)
    {
      vertex(x + radi * cos(radians(angle * i)), 
      y + radi * sin(radians(angle * i)));
    }
    endShape(CLOSE);
  }
  
  void drawCrack()
  {
    float x1 = x + radi * cos(radians(60));
    float y1 = y + a;
    float x2 = x + (a-c) * cos(radians(30)); 
    float y2 = y + (a-c) * sin(radians(30));
    float x3 = x + (a+c) * cos(radians(30)); 
    float y3 = y + (a+c) * sin(radians(30));
    float x4 = x + radi;
    float y4 = y;
    
    fill(255, 0, 0);
    beginShape();
    vertex(x1, y1);
    vertex(x2, y2);
    vertex(x4, y4);
    vertex(x3, y3);
    endShape(CLOSE);
  }
}

