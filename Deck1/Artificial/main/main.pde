import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

color cardBG = #1b1916;
color bg = cardBG;

PostFXSupervisor supervisor;
BloomPass bloomPass;
BlurPass blurPass;
ColorPass colorPass;

// Function to create the tiles
PGraphics[] createTiles(int tileSizeX, int tileSizeY) {
    PGraphics[] tiles = new PGraphics[2];

    PGraphics tile1 = createGraphics(tileSizeX, tileSizeY, P2D);
    tile1.smooth(8);
    tile1.beginDraw();
    tile1.noStroke();
    tile1.fill(#ffffff);
    tile1.translate(tileSizeX / 2.0, tileSizeY / 2.0);
    tile1.rotate(PI/4.0);
    tile1.rectMode(CENTER);
    tile1.rect(0, 0, sqrt(pow(tileSizeX, 2) + pow(tileSizeY, 2)), tileSizeY/4.0, tileSizeX/8.0);
    tile1.endDraw();

    PGraphics tile2 = createGraphics(tileSizeX, tileSizeY, P2D);
    tile2.smooth(8);
    tile2.beginDraw();
    tile2.noStroke();
    tile2.fill(#ffffff);
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

    // Parameters
    int tileSizeX = 15;
    int tileSizeY = 15;
    
    float misTileChance = 0.1;

    int numY = 44;
    int numX = round(numY/3.5*2.2);

    // Create the tiles to choose from
    PGraphics[] tiles = createTiles(tileSizeX, tileSizeY);

    face.beginDraw();
    face.noStroke();

    face.imageMode(CENTER);

    int preferredIndex, otherIndex;

    for (float x = 0; x < numX; x++) {
        for (float y = 0; y < numY; y++) {
            
            if ((x + y) % 2 == 0) {
                preferredIndex = 0;
                otherIndex = 1;
            } else {
                preferredIndex = 1;
                otherIndex = 0;
            }
            
            int index;
            if (random(0, 1) < misTileChance) index = otherIndex;
            else index = preferredIndex;

            float coordX = map(x, 0, numX-1, tileSizeX, cardWidth-tileSizeX);
            float coordY = map(y, 0, numY-1, tileSizeY, cardHeight-tileSizeY);
            face.image(tiles[index], coordX, coordY);
        }
    }

    face.endDraw();

    PGraphics fin = createGraphics(cardWidth, cardHeight, P2D);

    blendMode(BLEND);
    image(face, width, height);
    blendMode(BLEND);
    supervisor.render(face);
    colorPass.setUniforms(width, height);
    supervisor.pass(bloomPass);
    supervisor.pass(colorPass);
    supervisor.compose(fin);
    blendMode(BLEND);

    return fin;
}

// Setup canvas and draw the card
void setup() {
    size(1200, 1200, P2D);

    supervisor = new PostFXSupervisor(this);
    bloomPass = new BloomPass(this, 0.01, 15, 500000);
    colorPass = new ColorPass();

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
    pushMatrix();
    translate(width/2-cardWidth/2, height/2-cardHeight/2);
    fill(bg);
    rect(0, 0, cardWidth*2, cardHeight*2);
    image(cardFace, 0, 0);
    
    popMatrix();
    // Draw the card's outline
    stroke(255, 255, 255);
    strokeWeight(cardOutline);
    noFill();
    rect(
        width/2.0+1, height/2.0+1,
        cardWidth+cardOutline-2, cardHeight+cardOutline-2,
        cardRoundedness
    );

    image(titleImage, 0, 0);
}

// This is probably going to be very minimal, most code should go in
// setup unless we are animating.
void draw() { 
}
