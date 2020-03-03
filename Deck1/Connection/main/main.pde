color wifiOn = #dcdcdd;
color wifiOff = #2c2b3c;
color possibleHeart = #bd6b73;
color cardBG = #121420;
color lowPower = #a30b37;
color bg = cardBG;

// Template function for drawing
PGraphics drawSpecificCard(int cardWidth, int cardHeight) {
    PGraphics face = createGraphics(cardWidth, cardHeight, P2D);
    face.smooth(8);
    face.beginDraw();
    face.noStroke();

    // Parameters
    float wifiBarHeight = 0.65;

    // Draw background
    face.fill(cardBG);
    face.rect(0, 0, cardWidth, cardHeight);

    // Draw heart layer 3
    float offset3 = 0.00045;
    face.fill(possibleHeart);
    face.arc(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*1.3, cardWidth*1.3, PI+PI/4.0+cardWidth*offset3, 3.0*PI/2.0-cardWidth*offset3);
    face.arc(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*1.3, cardWidth*1.3, 3.0*PI/2.0+cardWidth*offset3, 2.0*PI-PI/4.0-cardWidth*offset3);
    face.fill(cardBG);
    face.ellipse(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*1.2, cardWidth*1.2);

    // Draw heart layer 2
    float offset2 = 0.00025;
    face.fill(possibleHeart);
    face.arc(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*1.1, cardWidth*1.1, PI+PI/4.0+cardWidth*offset2, 3.0*PI/2.0-cardWidth*offset2);
    face.arc(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*1.1, cardWidth*1.1, 3.0*PI/2.0+cardWidth*offset2, 2.0*PI-PI/4.0-cardWidth*offset2);
    face.fill(cardBG);
    face.ellipse(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*1.0, cardWidth*1.0);

    // Draw heart layer 1
    float offset1 = 0.0001;
    face.fill(possibleHeart);
    face.arc(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*0.9, cardWidth*0.9, PI+PI/4.0+cardWidth*offset1, 3.0*PI/2.0-cardWidth*offset1);
    face.arc(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*0.9, cardWidth*0.9, 3.0*PI/2.0+cardWidth*offset1, 2.0*PI-PI/4.0-cardWidth*offset1);
    face.fill(cardBG);
    face.ellipse(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*0.8, cardWidth*0.8);

    // Draw wifi bar 3
    face.fill(wifiOff);
    face.arc(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*0.7, cardWidth*0.7, PI+PI/4.0, 2.0*PI-PI/4.0);
    face.fill(cardBG);
    face.ellipse(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*0.6, cardWidth*0.6);

    // Draw wifi bar 2
    face.fill(wifiOn);
    face.arc(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*0.5, cardWidth*0.5, PI+PI/4.0, 2.0*PI-PI/4.0);
    face.fill(cardBG);
    face.ellipse(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*0.4, cardWidth*0.4);

    // Draw wifi bar 1
    face.fill(wifiOn);
    face.arc(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*0.3, cardWidth*0.3, PI+PI/4.0, 2.0*PI-PI/4.0);
    face.fill(cardBG);
    face.ellipse(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*0.2, cardWidth*0.2);

    // Draw lowest wifi signal
    face.fill(wifiOn);
    face.ellipse(cardWidth/2, cardHeight*wifiBarHeight, cardWidth*0.1, cardWidth*0.1);

    // Draw ellipse at bottom
    face.fill(wifiOff);
    face.ellipse(cardWidth/2, cardHeight, cardWidth*1.5, cardHeight*0.35);

    // Draw iPhone button
    face.fill(cardBG);
    face.ellipse(cardWidth/2, cardHeight*0.92, cardWidth*0.15, cardWidth*0.15);
    face.rectMode(CENTER);
    face.stroke(wifiOn);
    face.strokeWeight(5);
    face.rect(cardWidth/2, cardHeight*0.92, cardWidth*0.075, cardWidth*0.075, cardWidth*0.01);

    // Draw battery
    face.fill(cardBG);
    face.stroke(wifiOff);
    face.strokeWeight(3);
    face.rect(cardWidth*0.85, cardHeight*0.05, cardWidth*0.075*2, cardWidth*0.075, cardWidth*0.01);
    face.noStroke();
    face.fill(wifiOff);
    face.arc(cardWidth*0.92+cardWidth*0.075/4, cardHeight*0.05, cardWidth*0.025, cardWidth*0.025, -PI/2, PI/2);
    face.fill(lowPower);
    face.rect(cardWidth*0.85-cardWidth*0.065*4.0/4.3, cardHeight*0.05, cardWidth*0.065/4.0, cardWidth*0.065, cardWidth*0.01);

    face.endDraw();
    return face;
}

// Setup canvas and draw the card
void setup() {
    size(1200, 1200, P2D);

    drawCard(bg, "C O N N E C T I O N");

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

