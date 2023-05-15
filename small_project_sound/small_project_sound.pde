import processing.sound.*;
// PROJECT 2 - Digital detox synthesizer
//----------------------------------------------------------------------------------------------------------------------------------
// REFERENCES
// - AUDIO FILE FROM FREE SOURCE AVAILABLE AT: https://pixabay.com/sound-effects/small-forest-stream-river-brook-nature-loop-111169/
// Sound source by Micheal from Pixabay
// - CLOUD IMAGE AVAILABLE AT: http://www.stickpng.com/img/nature/clouds/small-single-cloud
// - RAIN GRAPHICS: 
// The Coding Train ~ Coding Challenge #4: Purple Rain in Processing: https://www.youtube.com/watch?v=KkyIDI6rQJI
// Rain by Kelsierose94: https://editor.p5js.org/kelsierose94/sketches/MU2Y21aG0
// ---------------------------------------------------------------------------------------------------------------------------------
// SOUND AND SLIDERS VARIABLES
SoundFile file;
Slider amplitudeSlider, rateSlider, positionSlider;
float amplitude, rate, position;
// TOGGLES VARIABLES
// Create subtoggles array
SubToggle[] subtoggles = new SubToggle[3];
// Create main toggle
Toggle t = new Toggle(90, 110, false);
// TEXT VARIABLES
// Sound Manipulation titles
String[] titles = {"Rain Sound Effects:", "Light Rain", "Normal Rain", "Heavy Rain"};
String[] slidersTitles = {"Volume:", "Frequency:", "Panoramic position:"};
PFont font;
// COLOR VARIABLES
float   h, s, b;
// NOISE VARIABLES
BrownNoise brown;
PinkNoise pink;
WhiteNoise white;
Noise[] noises;
float brownAmplitude, whiteAmplitude;
// GRAPHIC RAIN VARIABLES
// Create rain drops array
Drop[] rainDrops = new Drop[1000];
String rainStatus = "";
// IMAGE VARIABLES
PImage cloud;
int cloudWidth = 200;
int cloudHeight = 100;
// DISPLAY VARIABLES
float rectPos;

void setup() {
  // Set window's width and height
  size(500, 850);
  surface.setTitle("Digital detox synthesizer");
  surface.setLocation(800, 30);
  font = createFont("SFPRO.OTF", 25);
  
  // Fill subtoggles array
  for (int i = 0; i < subtoggles.length; i++) {
    subtoggles[i] = new SubToggle(90, 160 + i*50, false);
  }
  
  // Fill rain drops array
  for (var i = 0; i < rainDrops.length; i++) {
    rainDrops[i] = new Drop();
  }
  
  // Create Sliders
  amplitudeSlider  = new Slider(width/2, 700);
  rateSlider = new Slider (width/2, 750);
  positionSlider = new Slider (width/2, 800);

  // Load a soundfile and play it back
  file = new SoundFile(this, "stream.wav");
  file.loop();

  // Create the brown, pink, white noise generator
  brown = new BrownNoise(this);
  pink = new PinkNoise(this);
  white = new WhiteNoise(this);

  // Load cloud image
  cloud = loadImage("cloud.png");
  cloud.resize(cloudWidth, cloudHeight);
}

void draw() {
  // BACKGROUND

  // Set background color
  background(100);

  // DISPLAY

  pushStyle();
  noStroke();
  colorMode(HSB, 360, 100, 100);
  fill(h, b, s);
  rect(20, 20, width-40, 350);
  
  // TITLES

  // Add rain Sound effect titles
  textFont(font);
  colorMode(RGB, 255, 255, 255);
  changeTextColor(t.status, 142);
  text(titles[0], 20, 442);

  for (int i = 0; i < titles.length-1; i++) {
    changeTextColor(subtoggles[i].status, 43);
    text(titles[i+1], 20, 492 + 50*i);
  }

  // TOGGLES

  // Display main toggle next to rain sound effect titles
  t.switchToggle();
  // Iterate over subtoggles array and display subtoggles
  for (int i = 0; i < subtoggles.length; i++) {
    subtoggles[i].switchSubToggle();
  }
  popStyle();

  // SLIDERS

  // Map x value between 0 and 1 in order to change sound amplitude when slider is used
  amplitude = map(amplitudeSlider.x, 20, width-20, 0.0, 1.0);
  // Map x value between 0.5 and 2 in order to change playback rate when slider is used
  rate = map(rateSlider.x, 20, width-20, 0.5, 2.0);
  // Map x value between -1.0 and 1.0 in order to change panoramil position when slider is used
  position = map(positionSlider.x, 20, width-20, -1.0, 1.0);

  // Map HSB values using sliders' values (H - Volume; S - Rate; B - Position)
  h = int(map(amplitudeSlider.x, 20, width-20, 180, 240));
  s = int(map(rateSlider.x, 20, width-20, 50, 100));
  b = int(map(positionSlider.x, 20, width-20, 50, 100));

  pushStyle();
  rectMode(CENTER);
  fill(h, s, b);
  rectPos = int(map(positionSlider.x, 20, width-20, 150, width-150));
  popStyle();

  // Add Slider titles
  for (int i = 0; i < slidersTitles.length; i++) {
    text(slidersTitles[i], 20, 685 + 50*i);
  }

  // Display volume, rate and position sliders
  amplitudeSlider.display();
  rateSlider.display();
  positionSlider.display();

  // SOUND

  // Update sound file based on changes made with the sliders
  file.set(rate, position, amplitude, 0.0);

  // Map brown and white noise in order to be able to hear the sound file in the background
  brownAmplitude = map(amplitude, 0, 1, 0, 0.2);
  whiteAmplitude = map(amplitude, 0, 1, 0, 0.6);

  // Add rain effect when the status of correspondent toggle is true (toggle activated)
  addRainSound(0, pink, amplitude);
  addRainSound(1, white, whiteAmplitude);
  addRainSound(2, brown, brownAmplitude);
  
  // GRAPHIC RAIN
  // Display rain drops and update rain status
  for (int i = 0; i < rainDrops.length; i++) {
    rainDrops[i].show();
    rainDrops[i].fall();
  }
  
  addRainGraphic();
  
  // Create line of clouds
  for (int i = 0; i < 301; i += 100){
    image(cloud, i, -15);
  }
  
  pushStyle();
  fill(100);
  rect(0, 0, width, 20);
  rect(0, 0, 20, 100);
  rect(width-20, 0, 20, 100);
  popStyle();
  
  
}

// Change titles color when corresponding toggle is active
void changeTextColor(boolean status, int col) {
  if (status) {
    fill(255);
  } else {
    fill(col);
  }
}

// Play rain sound when corresponding toggle is on
void addRainSound(int index, Noise noise, float volume) {
  if (subtoggles[index].status) {
    noise.set(volume, 0.0, position);
    noise.play();
  } else {
    noise.stop();
  }
}

// Update rain status according to which toggle is on 
void addRainGraphic() {
  if (subtoggles[0].status && subtoggles[1].status == false && subtoggles[2].status == false) {
    rainStatus = "Light";
  } else if (subtoggles[0].status == false && subtoggles[1].status && subtoggles[2].status == false || subtoggles[0].status && subtoggles[1].status && subtoggles[2].status == false ) {
    rainStatus = "Normal";
  } else if (subtoggles[0].status == false && subtoggles[1].status == false && subtoggles[2].status || subtoggles[0].status && subtoggles[1].status == false && subtoggles[2].status || subtoggles[0].status == false && subtoggles[1].status && subtoggles[2].status || subtoggles[0].status && subtoggles[1].status && subtoggles[2].status ) {
    rainStatus = "Heavy"; 
  } else if (subtoggles[0].status == false && subtoggles[1].status == false && subtoggles[2].status == false) {
    rainStatus = "";
  } 
}

void keyPressed() {
  // SLIDERS
  
  if (key == CODED) {
    // Amplitude slider using UP/DOWN keys
    if (keyCode == UP && amplitudeSlider.x <= (width-30)) {
      amplitudeSlider.x = ceil(amplitudeSlider.x/10)*10+10;;
    }
    if (keyCode == DOWN && amplitudeSlider.x >= 30.) {
      amplitudeSlider.x = (floor(amplitudeSlider.x/10))*10-5;
    }
    // Rate slider using LEFT/RIGHT keys
    if (keyCode == RIGHT && rateSlider.x <= (width-30)) {
      rateSlider.x = ceil(rateSlider.x/10)*10+10;;
    }
    if (keyCode == LEFT && rateSlider.x >= 30) {
      rateSlider.x = (floor(rateSlider.x/10))*10-5;
    }
  }
  // Panoramic position slider using '<'/'>' keys
  if (key == '>' && positionSlider.x <= (width-30) || key == '.' && positionSlider.x <= (width-30)) {
    positionSlider.x = ceil(positionSlider.x/10)*10+10;
  }
  if (key == '<' && positionSlider.x >= 30|| key == ',' && positionSlider.x >= 30) {
    positionSlider.x = (floor(positionSlider.x/10))*10-5;
  }
}
