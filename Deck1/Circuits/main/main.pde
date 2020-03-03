// Parameters
color wireBG = #191919;
color wireColor1 = #554e6f;
color wireColor2 = #ffffff;
color wireColor3 = #e65a3d;
color bg = wireBG;

// Function for creating a new circuit. Return true if circuit was drawn,
// return false otherwise.
boolean dropCircuit(
    int numCols, int numRows, int startX, int startY,
    float deltaX, float deltaY, boolean filledTable[][],
    int circleSize, int strokeSize, PGraphics face
                                    ) {
    // Circuit parameters
    float turnChance = 0.2;
    float leftChance = 0.25;
    float endChance = 0.05;
    float color2Chance = 0.35;
    float color3Chance = 0.15;
    float offsetX = 5.0;
    float offsetY = 5.0;

    // Set the colors
    face.fill(wireBG);
    if (random(0, 1) < color2Chance) {
        if (random(0, 1) < color3Chance) face.stroke(wireColor3);
        else face.stroke(wireColor2);
    }
    else face.stroke(wireColor1);
    face.strokeWeight(strokeSize);
    // If the current starting space is already filled, return false
    if (filledTable[startX][startY] == true) return false;
    
    // Draw lines
    int x = startX;
    int y = startY;
    while (true) {
        int prevX = x;
        int prevY = y;

        if (random(0, 1) < endChance) {
            face.ellipse(deltaX*x+offsetX, deltaY*y+offsetY, circleSize, circleSize);
            filledTable[x][y] = true;
            break;
        }

        if (random(0, 1) < turnChance) {
            if (random(0, 1) < leftChance) {
                x -= 1;
                if (prevX-1 >= 0 && filledTable[prevX-1][prevY] && prevY+1 < numRows && filledTable[prevX][prevY+1]) {
                    if (startX != x || startY != y) face.ellipse(deltaX*prevX+offsetX, deltaY*prevY+offsetY, circleSize, circleSize);
                    break;
                }
            }
            else {
                x += 1;
                if (prevX+1 < numCols && filledTable[prevX+1][prevY] && prevY+1 < numRows && filledTable[prevX][prevY+1]) {
                    if (startX != x || startY != y) face.ellipse(deltaX*prevX+offsetX, deltaY*prevY+offsetY, circleSize, circleSize);
                    break;
                }
            }
        }
        y += 1;

        if (x < 0 || x >= numCols || y < 0 || y >= numRows) {
            break;
        }

        if (filledTable[x][y]) {
            face.ellipse(deltaX*prevX+offsetX, deltaY*prevY+offsetY, circleSize, circleSize);
            break;
        }

        if (filledTable[x][y]) break;
        face.line(prevX*deltaX+offsetX, prevY*deltaY+offsetY, x*deltaX+offsetX, y*deltaY+offsetY);
        filledTable[x][y] = true;
        filledTable[prevX][prevY] = true;
    }

    // Draw the starting circle
    if (startX != x || startY != y) { 
        face.ellipse(deltaX*startX+offsetX, deltaY*startY+offsetY, circleSize, circleSize);
        filledTable[startX][startY] = true;
    }

    return true;
}

// Template function for drawing
PGraphics drawSpecificCard(int cardWidth, int cardHeight) {
    // Circuit parameters
    int numCols = int(15*4.0);
    int numRows = int(25*4.0);
    int circleSize = 5;
    int strokeSize = 1;
    int numCircuitsDropped = 800;

    int tableOffset = 10;
    
    // Generate the final card face
    PGraphics face = createGraphics(cardWidth, cardHeight, P2D);
    face.smooth(8);
    face.beginDraw();

    face.fill(wireBG);
    face.rect(0, 0, cardWidth, cardHeight);

    // Create table that tells if a circuit has already been placed
    boolean filledTable[][] = new boolean[numCols+tableOffset][numRows+tableOffset];

    // Find out the spacing based on the number of rows and columns
    float deltaX = cardWidth / numCols;
    float deltaY = cardHeight / numRows;

    // Create circuits
    for (int i = 0; i < numCircuitsDropped; i++) {
        dropCircuit(
            numCols+tableOffset, numRows+tableOffset,
            int(random(0, numCols+tableOffset)), int(random(0, numRows+tableOffset)),
            deltaX, deltaY, filledTable,
            circleSize, strokeSize, face
        );
    }

    face.endDraw();
    return face;
}

// Setup canvas and draw the card
void setup() {
    size(1000, 1000, P2D);

    drawCard(bg, "C I R C U I T S");

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


void keyPressed() {
    wireBG = color(random(0, 255), random(0, 255), random(0, 255));
    wireColor1 = color(random(0, 255), random(0, 255), random(0, 255));
    wireColor2 = color(random(0, 255), random(0, 255), random(0, 255));
    wireColor3 = color(random(0, 255), random(0, 255), random(0, 255));
    bg = wireBG;

    drawCard(bg, "C I R C U I T S");

    saveFrame("output.png");
}