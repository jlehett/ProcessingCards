color cardBG = #121420;
color bg = cardBG;

// Function to create the tiles
PGraphics[] createTiles(int tileSizeX, int tileSizeY) {
    PGraphics[] tiles = new PGraphics[2];

    PGraphics tile1 = createGraphics(tileSizeX, tileSizeY, P2D);
    tile1.smooth(8);
    tile1.beginDraw();
    tile1.noStroke();
    tile1.translate(tileSizeX / 2.0, tileSizeY / 2.0);
    tile1.rotate(PI/4.0);
    tile1.rectMode(CENTER);
    tile1.rect(0, 0, sqrt(pow(tileSizeX, 2) + pow(tileSizeY, 2)), tileSizeY/4.0, tileSizeX/8.0);
    tile1.endDraw();

    PGraphics tile2 = createGraphics(tileSizeX, tileSizeY, P2D);
    tile2.smooth(8);
    tile2.beginDraw();
    tile2.noStroke();
    tile2.translate(tileSizeX / 2.0, tileSizeY / 2.0);
    tile2.rotate(-PI/4.0);
    tile2.rectMode(CENTER);
    tile2.rect(0, 0, sqrt(pow(tileSizeX, 2) + pow(tileSizeY, 2)), tileSizeY/4.0, tileSizeX/8.0);
    tile2.endDraw();

    tiles[0] = tile1;
    tiles[1] = tile2;
    return tiles;
}

// Template function for drawing
PGraphics drawSpecificCard(int cardWidth, int cardHeight) {
    PGraphics face = createGraphics(cardWidth, cardHeight, P2D);
    face.smooth(8);
    face.beginDraw();
    face.noStroke();

    // Parameters
    int tileSizeX = 40;
    int tileSizeY = 40;
    int xOffset = 10;
    int yOffset = 10;

    // Draw background
    face.fill(cardBG);
    face.rect(0, 0, cardWidth, cardHeight);
    face.endDraw();

    // Create the tiles to choose from
    PGraphics[] tiles = createTiles(tileSizeX, tileSizeY);

    face.beginDraw();

    for (float x = 0; x < cardWidth; x+=tileSizeX) {
        for (float y = 0; y < cardHeight; y+=tileSizeY) {
            int index = round(random(0, 1));
            face.image(tiles[index], x, y);
        }
    }

    face.endDraw();
    return face;
}

// Setup canvas and draw the card
void setup() {
    size(1200, 1200, P2D);

    drawCard(bg, "A R T I F I C I A L");

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

