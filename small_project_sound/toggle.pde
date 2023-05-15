class Toggle {

  // Initial coordinates and coordinates to return to when the toggle is switched off
  float x, y;

  // Current position
  float currentX;

  // Toggle color
  color toggleBgColor = 43;
  color switchColor = 142;

  boolean status; // ON-OFF

  // Define toggle properties
  public Toggle(float x, float y, boolean status) {
    this.x = x;
    this.y = y + 300;
    this.status = status;
    currentX = x;
  }

  //draw Toggle
  void display() {
    noStroke();
    fill(toggleBgColor);
    rect(width-x, y, 70, 40, 72);
    fill(switchColor);
    ellipse(width-currentX+20, y+20, 35, 35);
  }

  // Switch toggle on and off
  void switchToggle() {
    if (mousePressed && mouseX > width-x && mouseX < width-x+35 && mouseY > y && mouseY < y+35) {
      currentX = x - 30;
      toggleBgColor = color(104, 205, 102);
      switchColor = 255;
      status = true;
    } else if (mousePressed && mouseX > width-currentX && mouseX < width-currentX+35 && mouseY > y && mouseY < y+35) {
      currentX = x;
      toggleBgColor = 43;
      switchColor = 142;
      status = false;
    }
    display();
  }
}
