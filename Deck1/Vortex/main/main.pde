color bg = #1a181b;
color bigRing = #2cda9d;
color smallRing = #3e8989;
color bubbles = #2cda9d;
color squares = #05f140;
color bgCircle = #1a181b;

// Template function for drawing
PGraphics drawSpecificCard(int cardWidth, int cardHeight) {
    PGraphics face = createGraphics(cardWidth, cardHeight, P2D);
    face.beginDraw();
    
    // Draw background
    face.fill(bg);
    face.rect(0, 0, cardWidth, cardHeight);

    float size = random(150.0, 250.0);

    // Draw circle border
    face.pushMatrix();
    face.translate(cardWidth/2, cardHeight/2);
    face.noStroke();
    face.fill(bgCircle);
    face.ellipse(0, 0, size*2+40, size*2+40);
    face.popMatrix();

    // Draw squares
    for (int i = 0; i < random(250, 5000); i++) {
        float radiusPos = random(0.0, 500.0);
        float squareSize = random(3.0, 20.0);
        float squareAngle = random(0.0, 2.0*PI);
        if (radiusPos < size + 25.0) continue;
        face.pushMatrix();
        face.translate(cardWidth/2, cardHeight/2);
        face.rotate(squareAngle);
        face.noFill();
        face.stroke(squares, random(50, 250));
        face.strokeWeight(3);
        face.rect(0, radiusPos, squareSize, squareSize);
        face.popMatrix();
    }

    // Draw radial clock border
    float startingAngle = 0.0;
    float subdivisions = 60.0;
    for (float i = 0.0; i < subdivisions; i++) {
        float angle = startingAngle + 2.0 * PI / subdivisions * i;
        face.pushMatrix();
        face.translate(cardWidth/2, cardHeight/2);
        face.rotate(angle);
        if (i % 5.0 == 0.0) {
            face.fill(bigRing);
            face.noStroke();
            float _size = 15.0 + random(-5, 5);
            face.ellipse(0.0, size+random(-5, 5), _size, _size);
        } else {
            face.noFill();
            face.stroke(smallRing);
            face.strokeWeight(2);
            float _size = 7.0 + random(-3.5, 3.5);
            face.ellipse(0.0, size+random(-5, 5), _size, _size);
        }
        face.popMatrix();
    }

    // Draw hour hand
    /*
    float minuteAngle = random(0.0, 2.0*PI);
    float hourSize = 100.0;
    face.pushMatrix();
    face.translate(cardWidth/2, cardHeight/2);
    face.rotate(minuteAngle);
    face.noFill();
    face.stroke(bigRing);
    face.strokeWeight(8);
    face.line(0, 0, hourSize, 0.0);
    face.popMatrix();

    // Draw hour hand
    float hourAngle = random(0.0, 2.0*PI);
    float minuteSize = 150.0;
    face.pushMatrix();
    face.translate(cardWidth/2, cardHeight/2);
    face.rotate(hourAngle);
    face.noFill();
    face.stroke(bigRing);
    face.strokeWeight(8);
    face.line(0, 0, minuteSize, 0.0);
    face.popMatrix();
    */

    // Draw center dot
    face.pushMatrix();
    face.translate(cardWidth/2, cardHeight/2);
    face.fill(bigRing, random(50, 255));
    face.noStroke();
    float centerSize = random(20.0, 50.0);
    face.ellipse(0, 0, centerSize, centerSize);
    face.popMatrix();

    // Draw random arcs
    float baseOpacity = random(5, 30);
    int numArcs = int(random(40, 160*8));
    for (int i = 0; i < numArcs; i++) {
        float sAngle = random(0.0, 2.0*PI);
        float angleSize = random(-2.0*PI, 2.0*PI);
        float radiusPos = map(i, 0, numArcs-1, 50.0, size+150.0);
        face.pushMatrix();
        face.translate(cardWidth/2, cardHeight/2);
        face.rotate(sAngle);
        face.noFill();
        face.stroke(bubbles, baseOpacity + random(-3, 3));
        face.strokeWeight(2);
        face.arc(0, 0, radiusPos, radiusPos, 0, angleSize);
        face.popMatrix();
    }

    face.endDraw();
    return face;
}

// Setup canvas and draw the card
void setup() {
    size(1200, 1200, P2D);

    drawCard(bg, "V O R T E X");

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
