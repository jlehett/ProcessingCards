color bg = #252627;
color moon = #f2efe9;
color[] cs = {
    #20fc8f,
    #3f5e5a,
    #38423b
};

// Template function for drawing
PGraphics drawSpecificCard(int cardWidth, int cardHeight) {
    PGraphics face = createGraphics(cardWidth, cardHeight, P2D);
    face.beginDraw();
    
    // Draw background
    boolean light;
    if (random(0, 1) < 0.5) {
        light = true;
    } else light = true;
    if (light) face.fill(#2d2d2a);
    else face.fill(bg);
    face.rect(0, 0, cardWidth, cardHeight);

    // Draw white circles
    float xFac = random(250, 1000);
    float yFac = random(250, 1000);
    if (random(0, 1) < 0.5) {
        int numCircles = int(random(150, 250));
        for (int i = 0; i < numCircles; i++) {
            float opacity = random(10, 150);
            face.stroke(bg, 75);
            face.strokeWeight(random(3, 8));
            float cSize = random(10, 100);
            float xLoc = random(0, cardWidth);
            float yLoc = random(0, cardHeight);
            float nVal = noise(xLoc/xFac, yLoc/yFac);
            color c = #000000;
            if (nVal < 0.48) c = cs[0];
            else if (nVal >= 0.48 && nVal < 0.62) c = cs[1];
            else c = cs[2];
            face.fill(c, opacity*2);
            face.ellipse(xLoc, yLoc, cSize, cSize);
        }
    } else {
        xFac /= 2;
        yFac /= 1;
        int numCircles = int(random(150/2, 250));
        for (int i = 0; i < numCircles; i++) {
            float opacity;
            face.stroke(bg, 75);
            face.strokeWeight(random(3, 8));
            float cSize = random(5, 75);
            float xLoc = random(0, cardWidth/2);
            float yLoc = random(0, cardHeight);
            face.pushMatrix();
            face.translate(cardWidth/2, 0);
            float nVal = noise(xLoc/xFac, yLoc/yFac);
            color c = #000000;
            if (nVal < 0.48) c = cs[0];
            else if (nVal >= 0.48 && nVal < 0.62) c = cs[1];
            else c = cs[2];
            opacity = random(50, 150);
            face.fill(c, opacity*2);
            float offset = 50.0;
            face.ellipse(xLoc+random(-offset, offset), yLoc+random(-offset, offset), cSize, cSize);
            opacity = random(50, 150);
            face.fill(c, opacity*2);
            face.ellipse(-xLoc+random(-offset, offset), yLoc+random(-offset, offset), cSize, cSize);
            face.popMatrix();
        }
    }

    face.endDraw();
    return face;
}

// Setup canvas and draw the card
void setup() {
    size(1200, 1200, P2D);

    drawCard(#20fc8f, "F O A M");

    saveFrame("output.png");
}

// Template function for drawing cards
void drawCard(color bg, String cardName) {
    // Set card parameters
    int cardHeight = int(height * 0.8);
    float cardRoundedness = 5;
    float cardOutline = 25;
    float shadowScaling = 1.05;
    float shadowOpacity = 0.25 * (255.0);
    int shadowOffsetX = 25;
    int shadowOffsetY = 20;

    // Determine the size of the card given the desired height
    int cardWidth = int(float(cardHeight) / 3.5 * 2.2);
    // Logic for drawing a card will go here.
    PGraphics cardFace = drawSpecificCard(cardWidth, cardHeight);
    
    // Draw the background in the desired color.
    background(bg);
    // Write the card name on either side of the card
    float textX1 = width/8.0+35.0;
    float textX2 = width*7.0/8.0-35.0;
    float textY = height/2.0;

    PGraphics titleImage = createGraphics(width, height, P2D);
    titleImage.beginDraw();

    titleImage.fill(255);
    titleImage.textAlign(CENTER, CENTER);

    PFont font = loadFont("liberation.vlw");
    titleImage.textFont(font, 24);

    titleImage.pushMatrix();
    titleImage.translate(textX1, textY);
    titleImage.rotate(-HALF_PI);
    titleImage.text(cardName, 0, 0);
    titleImage.popMatrix();
    titleImage.pushMatrix();
    titleImage.translate(textX2, textY);
    titleImage.rotate(HALF_PI);
    titleImage.text(cardName, 0, 0);
    titleImage.popMatrix();
    
    titleImage.endDraw();

    image(titleImage, 0, 0);
    // Draw the card's silhouette with appropriate scaling and shadow
    // strength
    rectMode(CENTER);
    noStroke();
    fill(0, 0, 0, shadowOpacity);
    rect(
        width/2.0 + shadowOffsetX, height/2.0 + shadowOffsetY, 
        cardWidth * shadowScaling, cardHeight * shadowScaling,
        cardRoundedness + 20
    );
    // Draw the card's generated face
    imageMode(CENTER);
    image(cardFace, width/2, height/2);
    // Draw the card's outline
    stroke(255, 255, 255);
    strokeWeight(cardOutline);
    noFill();
    rect(
        width/2.0+1, height/2.0+1,
        cardWidth+cardOutline-2, cardHeight+cardOutline-2,
        cardRoundedness
    );
}

// This is probably going to be very minimal, most code should go in
// setup unless we are animating.
void draw() { 
}
