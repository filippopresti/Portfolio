class Slider {

  // Slider coordinates
  int x, y;


  public Slider(int x, int y) {
    this.x = x;
    this.y = y;
  }

  //draw Slider
  void display() {
    stroke(0);
    strokeWeight(3);
    line(20, y, width-20, y);
    noStroke();
    if (mousePressed && mouseX >= 25 && mouseX <= width-25 && mouseY > y-15 && mouseY < y+15) {
      x = mouseX;
      print(x);
    }
    stroke(237, 252, 255);
    line(20, y, x, y);
    noStroke();
    ellipse(x, y, 20, 20);
  }
}
