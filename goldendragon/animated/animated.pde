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
  
  lines.add(new Segment(0, height/2, 0, width, 0, 0, 0, true, color(200, 0, 255)));
  //lines.add(new Segment(0, height/2, 0, width, 0, 0, 0, false, color(200, 0, 255)));
}

void draw() {
  background(0);
  stroke(255);
  strokeWeight(1);

  translate(width/7 + width/15, height/5);
  scale(.7);
  
  boolean b = false;
  
  for (Segment s : lines) {
    s.render();
    if (abs(s.theta - s.targetTheta) < .1) {
      b = true;
    }
  }
  if (b) {
    step();
  }
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
    float x1 = (float) (s.x + s.l * cos(radians(s.targetTheta)));
    float y1 = (float) (s.y - s.l * sin(radians(s.targetTheta)));
    
    if (s.regular) {
      s1 = new Segment(s.x, s.y, s.z, r * s.l, s.targetTheta, s.targetTheta + dt, s.phi + dp, s.regular, s.c);
      s2 = new Segment(x1, y1, s.z, r * r * s.l, s.targetTheta + 180, s.targetTheta + dt2, s.phi - dp, s.regular, s.c);
      
    } else {
      s1 = new Segment(s.x, s.y, s.z, r * s.l, s.targetTheta, s.targetTheta - dt, s.phi + dp, s.regular, s.c);
      s2 = new Segment(x1, y1, s.z, r * r * s.l, s.targetTheta - 180, s.targetTheta - dt2, s.phi - dp, s.regular, s.c);
    }
    
    temp.add(s1);
    temp.add(s2);
  }
  
  lines = temp;
}


class Segment {

  float x, y, z, l, startTheta, theta, targetTheta, phi;
  boolean regular;
  color c;

  Segment(float x, float y, float z, float l, float theta, float targetTheta, float phi, boolean regular, color c) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.l = l;
    this.startTheta = theta;
    this.theta = theta;
    this.targetTheta = targetTheta;
    this.phi = phi;
    this.regular = regular;
    this.c = c;
  }

  void render() {
    stroke(this.c);
    
    this.theta = lerp(this.theta, this.targetTheta, .10);
    //this.theta = this.theta + (this.targetTheta - this.theta) / 10;
    
    line(this.x, this.y, (float) (this.x + this.l * cos(radians(this.theta))), (float) (this.y - this.l * sin(radians(this.theta)))); 
    //line(this.x, this.y, this.z, (float) (this.x + l * cos(radians(this.theta))), (float) (this.y - l * sin(radians(this.theta))), this.phi);
  }
}
