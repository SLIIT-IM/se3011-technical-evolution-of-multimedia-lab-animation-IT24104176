int score = 0;
int timer = 30;
int state = 0; // 0: Start, 1: Play, 2: End

float px, py; // Player
float ox, oy, osX, osY; // Orb (Pos and Speed)
float hx, hy; // Helper (Easing)

void setup() {
  size(600, 600);
  resetGame();
}

void draw() {
  if (state == 0) {
    background(0);
    textAlign(CENTER);
    text("Press ENTER to Start", width/2, height/2);
  } 
  else if (state == 1) {
    background(30);

    // 1. Timer (60 frames = 1 second)
    if (frameCount % 60 == 0 && timer > 0) timer--;
    if (timer <= 0) state = 2;

    // 2. Player (Arrow Keys)
    if (keyPressed) {
      if (keyCode == UP) py -= 5;
      if (keyCode == DOWN) py += 5;
      if (keyCode == LEFT) px -= 5;
      if (keyCode == RIGHT) px += 5;
    }
    fill(0, 200, 255);
    rect(px, py, 30, 30);

    // 3. Orb Movement & Bouncing
    ox += osX;
    oy += osY;
    if (ox < 0 || ox > width) osX *= -1;
    if (oy < 0 || oy > height) osY *= -1;
    fill(255, 100, 0);
    ellipse(ox, oy, 20, 20);

    // 4. Collision (Catching)
    if (dist(px, py, ox, oy) < 30) {
      score++;
      ox = random(width);
      oy = random(height);
      osX *= 1.1; // Speed up
      osY *= 1.1;
    }

    // 5. Helper (Easing)
    hx += (px - hx) * 0.1;
    hy += (py - hy) * 0.1;
    fill(255, 100);
    ellipse(hx, hy, 10, 10);

    // HUD
    fill(255);
    text("Score: " + score + "  Time: " + timer, 60, 30);
  } 
  else if (state == 2) {
    background(100, 0, 0);
    text("Game Over! Score: " + score, width/2, height/2);
    text("Press R to Restart", width/2, height/2 + 40);
  }
}

void resetGame() {
  px = 300; py = 300;
  ox = 100; oy = 100;
  osX = 3; osY = 3;
  timer = 30;
  score = 0;
}

void keyPressed() {
  if (key == ENTER) state = 1;
  if (key == 'r' || key == 'R') {
    resetGame();
    state = 0;
  }
}
