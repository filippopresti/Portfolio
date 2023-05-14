// IMAGE AVAILABLE AT: https://www.pngitem.com/middle/ThTiR_eye-eyes-lightblue-cool-cute-beautiful-tumblr-grey/
PImage eyeBall;
// Set bottom-left for the initial scale method
String scaleMethod = "bottom-left";

// Create variables to manage the rotation of the eye ball
float angle = 300;
int scalar = 420;
float startX = -375;
float startY = 225;
// Create variables to manage the oscillation of the bars representig the abstract rainbow
float oscillation = 0;
int increment = 0;
// Assign gray color to the background
color backgroundColor = color(200);
// Assign white color to shapes in the background
color col = color(255);
// Create color pallette to use for the abstract rainbow
color[] colors =
  {
  #FA9189,
  #FCAE7C,
  #FFE699,
  #F9FFB5,
  #B3F5BC,
  #D6F6FF,
  #E2CBF7,
  #D1BDFF,
};

void setup() {
  // Set screen width and height
  size(700, 700);
  surface.setTitle("Enigma - Abstract Rainbow");
  // Load eye ball image
  eyeBall = loadImage("eyeball.png");
}

void draw() {
  // Set background color
  background(backgroundColor);
  // Draw background shapes
  fill(col);
  drawShapes();

  // Set new 0,0 cordinates to the middle of the screen
  pushMatrix();
  translate(width/2, height/2);
  fill(255);

  // Draw eye + abstract rainbow
  drawEye();
  popMatrix();
}

void drawEye() {
  // scale method controlled by using keyboard numbers
  switch(scaleMethod) {
  case "top-left":
    scale(1, -1);
    break;
  case "top-right":
    scale(-1, -1);
    break;
  case "bottom-right":
    scale(-1, 1);
    break;
  case "bottom-left":
    scale(1, 1);
    break;
  }
  // Eye section

  // Draw eye
  fill(255, 250);
  circle(-300, 300, 1000);

  float x = startX + scalar * cos(angle);
  float y = startY + scalar * sin(angle);
  // Display eye ball image on screen
  image(eyeBall, x, y, 150, 150);

  // Increment angle value
  angle += 0.01;

  // Abstract rainbow section
  pushStyle();
  noStroke();
  // Draw abstract rainbow
  for (int i = 0; i < 4; i++) {
    // Draw vertical bars
    fill(colors[i], 200);
    rect(-280 + (i*35), -300 + oscillation*(i+1), 30, 500);
    // Draw horizontal bars
    fill(colors[i+4], 200);
    rect(-295 + oscillation*(i+1), 150 +(i*35), 500, 30);
  }
  popStyle();

  // Control oscillation bars in order to draw them within screen size
  if (oscillation == 35) {
    increment = -1;
  } else if (oscillation == 0) {
    increment = 1;
  }
  oscillation += increment;
}

void drawShapes() {
  // scale method controlled by using keyboard numbers
  switch(scaleMethod) {
  case "top-left":
    // Draw triangles in the background
    for (int counter = 0; counter < height; counter+=50) {
      for (int j = 0; j < 7; j++) {
        triangle(100*j, 50 + counter, 50 + (j*100), 0 + counter, 100*(j+1), 50 + counter);
      }
    }
    break;
  case "top-right":
    // Draw circles in the background
    for (int counter = 0; counter <= height; counter+=50) {
      for (int j = 0; j < 15; j++) {
        ellipse(50*j, counter, 50, 50);
      }
    }
    break;
  case "bottom-right":
    // Draw arcs in the background
    for (int counter = 0; counter <= height; counter+=50) {
      for (int j = 0; j < 15; j++) {
        arc(50*j, counter, 50, 50, PI, TWO_PI);
      }
    }
    break;
  case "bottom-left":
    // Draw squares in the background
    for (int counter = 0; counter < height; counter+=50) {
      for (int j = 0; j < 14; j++) {
        // Set background color or shape color to the square in order to have a chessboard effect
        if (counter%100 == 50 && j%2 == 1) {
          fill(col);
        } else if (counter%100 == 0 && j%2 == 0) {
          fill(col);
        } else {
          fill(backgroundColor);
        }
        square(50*j, 0 + counter, 50);
      }
    }
    break;
  }
  // Add lines on top of the shapes to add more texture
  for (int i = 1; i < height; i++) {
    line(i*5, 0, i*5, height);
  }
}

// Event listener functions
void mousePressed() {
  // Assign new color based on mouse click
  // LFT mouse btn clicked --> shapes color
  // RGT mouse btn clicked --> backgound color
  if (mouseButton == LEFT) {
    col = get(mouseX, mouseY);
  } else if (mouseButton == RIGHT) {
    backgroundColor = get(mouseX, mouseY);
  }
}

void keyPressed() {
  // Change scale method using first 4 numbers of keyboard
  switch(key) {
  case '1':
    scaleMethod = "top-left";
    break;
  case '2':
    scaleMethod = "top-right";
    break;
  case '3':
    scaleMethod = "bottom-right";
    break;
  case '4':
    scaleMethod = "bottom-left";
    break;
  }
}
