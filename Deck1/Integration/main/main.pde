
// Template function for drawing
PGraphics drawSpecificCard(int cardWidth, int cardHeight) {
    PGraphics face = createGraphics(cardWidth, cardHeight, P2D);
    face.beginDraw();
    
    // Draw background
    face.fill(#05386b);
    face.rect(0, 0, cardWidth, cardHeight);

    // Box parameters
    float boxRadius = 35.0;
    float rotationNoise = 0.8;
    float numBoxesX = 10;
    float numBoxesY = 17;

    float randomX = int(random(0, numBoxesX));
    float randomY = int(random(0, numBoxesY));

    // Draw rotated boxes in a grid
    face.noStroke();
    face.rectMode(CENTER);
    for (float x = 0; x < numBoxesX; x++) {
        for (float y = 0; y < numBoxesY; y++) {
            float boxX = map(x, 0, numBoxesX-1, boxRadius, cardWidth-boxRadius);
            float boxY = map(y, 0, numBoxesY-1, boxRadius, cardHeight-boxRadius);
            float rotation = map(
                noise(x*rotationNoise, y*rotationNoise),
                0, 1, -HALF_PI/2.0, HALF_PI/2.0
            );
            face.pushMatrix();
            face.translate(boxX, boxY);
            face.rotate(rotation);
            if (random(0, 1) > 0.75) {
                face.fill(#5cdb95);
                face.ellipse(0, 0, boxRadius, boxRadius);
            }
            else {
                face.fill(#379683);
                face.rect(0, 0, boxRadius, boxRadius);
            }
            face.popMatrix();
        }
    }

    face.endDraw();
    return face;
}

// Setup canvas and draw the card
void setup() {
    size(1200, 1200, P2D);

    drawCard(#05386b, "I N T E G R A T I O N");

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
