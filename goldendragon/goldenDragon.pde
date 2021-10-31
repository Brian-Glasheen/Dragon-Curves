float ratio = (float) ((1 + Math.sqrt(5)) / 2);
float r = (float) (Math.pow((1/ratio), (1/ratio)));

float dt = 32.89;
float dt2 = 133.01;
float dp = 3;

ArrayList<Segment> lines;
ArrayList<Segment> temp;

void setup() {
  size(800, 800);
  colorMode(HSB);
  
  lines = new ArrayList();
  
  lines.add(new Segment(0, height/2, 0, width, 0, 0, true, color(200, 0, 255)));
  lines.add(new Segment(0, height/2, 0, width, 0, 0, false, color(200, 0, 255)));
}

void draw() {
  background(0);
  stroke(255);
  strokeWeight(1);

  translate(width/7 + width/15, height/6);
  scale(.7);
  
  for (Segment s : lines) {
    s.render();
  }
  
  noLoop();
}

void keyPressed() {
  if (keyCode == ENTER)
  {
    step();
  }
  
}

void step() {  
  Segment s1, s2;

  temp = new ArrayList(); 

  for (Segment s : lines) {
    float x1 = (float) (s.x + s.l * cos(radians(s.theta)));
    float y1 = (float) (s.y - s.l * sin(radians(s.theta)));
    
    if (s.regular) {
      s1 = new Segment(s.x, s.y, s.z, r * s.l, s.theta + dt, s.phi + dp, s.regular, s.c);
      s2 = new Segment(x1, y1, s.z, r * r * s.l, s.theta + dt2, s.phi - dp, s.regular, s.c);
      
    } else {
      s1 = new Segment(s.x, s.y, s.z, r * s.l, s.theta - dt, s.phi + dp, s.regular, s.c);
      s2 = new Segment(x1, y1, s.z, r * r * s.l, s.theta - dt2, s.phi - dp, s.regular, s.c);
    }
    
    temp.add(s1);
    temp.add(s2);
  }
  
  lines = temp;
  redraw();
}
