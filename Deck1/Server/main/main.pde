color cardBG = #f2d492;
color bg = #202c39;
color etchColor2 = #f29559;
color etchColor3 = #283845;

color darkBG;
color lightBG;

// Template function for drawing
PGraphics drawSpecificCard(int cardWidth, int cardHeight) {
    PGraphics face = createGraphics(cardWidth, cardHeight, P2D);
    face.smooth(8);
    face.beginDraw();
    face.noStroke();

    // Parameters
    int numLinesX = 10;
    int numLinesY = 14;
    float strokeSize = 5;
    float circleSize = 25;
    float contrast = 10;
        
    color darkBG = color(
        int(max(0, red(cardBG)-contrast)),
        int(max(0, green(cardBG)-contrast)),
        int(max(0, blue(cardBG) - contrast))
    );
    color lightBG = color(
        int(min(255, red(cardBG)+contrast)),
        int(min(255, green(cardBG)+contrast)),
        int(min(255, blue(cardBG)+contrast))
    );

    // Draw background
    face.fill(cardBG);
    face.rect(0, 0, cardWidth, cardHeight);

    face.strokeWeight(strokeSize);
    face.stroke(darkBG);
    for (int x = 0; x < numLinesX; x++) {
        for (int y = 0; y < numLinesY; y++) {
            face.line(
                0, cardHeight / numLinesY * y,
                cardWidth, cardHeight / numLinesY * y
            );
        }
        face.line(
                cardWidth / numLinesX * x, 0, 
                cardWidth / numLinesX * x, cardHeight
        );
    }

    for (int x = 1; x < numLinesX; x++) {
        for (int y = 1; y < numLinesY; y++) {

            if (random(0, 1) < 0.15) {
                if (random(0, 1) < 0.35) {
                    face.fill(etchColor3);
                } else {
                    face.fill(etchColor2);
                }
            } else {
                face.fill(lightBG);
            }

            face.ellipse(
                cardWidth / numLinesX * x, cardHeight / numLinesY * y,
                circleSize, circleSize
            );
        }
    }

    face.endDraw();
    return face;
}

// Setup canvas and draw the card
void setup() {
    size(1200, 1200, P2D);

    drawCard(bg, "S E R V E R");

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

