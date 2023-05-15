// Rain drop class
class Drop {
  // Rain X position, Y postion , gravity and speed variables 
  float x, y, gravity, speed;

  public Drop() {
    this.x = random(22, width-22);
    this.y = random(0, -height);
  }

  void show() {
    noStroke();
    fill(255);
    ellipse(this.x, this.y, random(1, 5), random(1, 5));
  }

  void fall() {
    this.gravity = 1.05;
    
    // Check status of rain and update accordingly
    switch(rainStatus) {
    // No rain
    case "":
      this.y = 800;
      this.speed = 0;
      this.gravity = 0;
      break;
    // Light rain
    case "Light":
      this.speed = random(4, 6);
      break;
    // Normal rain
    case "Normal":
      this.speed = random(6, 9);
      break;
    // Heavy rain
    case "Heavy":
      this.speed = random(10, 14);
      break;
    }

    this.y = this.y + this.speed * this.gravity;
    
    // Reset rain Y position
    if (this.y > 368) {
      this.y = random(-400, -5);
      this.gravity = 0;
    }
  }
}
