class Segment {

  float x, y, z, l, theta, phi;
  boolean regular;
  color c;

  Segment(float x, float y, float z, float l, float theta, float phi, boolean regular, color c) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.l = l;
    this.theta = theta;
    this.phi = phi;
    this.regular = regular;
    this.c = c;
  }

  void render() {
    stroke(this.c);
    line(this.x, this.y, (float) (this.x + l * cos(radians(theta))), (float) (this.y - l * sin(radians(theta)))); 
    //line(this.x, this.y, this.z, (float) (this.x + l * cos(radians(this.theta))), (float) (this.y - l * sin(radians(this.theta))), this.phi);
  }
}
