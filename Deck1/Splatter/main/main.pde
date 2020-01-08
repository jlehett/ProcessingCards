
color bg = #01200f;
color cardBG = #01200f;
color c1 = #9ec5ab;
color c2 = #32746d;
color c3 = #104f55;
color c4 = #32746d;

PShader metaballShader;
PVector[] metaballs = new PVector[5];
float[] metaballsRadii = new float[5];
String[] metaballRadiiStrings = {"mbr1", "mbr2", "mbr3", "mbr4", "mbr5"};
String[] metaballStrings = {"mb1", "mb2", "mb3", "mb4", "mb5"};

// Template function for drawing
PGraphics drawSpecificCard(int cardWidth, int cardHeight) {
    PGraphics face = createGraphics(cardWidth, cardHeight, P2D);
    face.smooth(8);
    face.beginDraw();

    // Parameters
    int numClusters = 10;
    float clusterVariance = 50.0;
    float minClusterRadius = 10.0/800000;
    float maxClusterRadius = 40.0/800000;
    float minBigRadius = 0.0000002 * cardWidth;
    float maxBigRadius = 0.0000003 * cardWidth;
    
    // Draw background
    face.fill(cardBG);
    face.rect(0, 0, cardWidth, cardHeight);
    metaballShader.set("uRes", cardWidth, cardHeight);

    // Draw metaball clusters
    for (int i = 0; i < numClusters; i++) {
        PVector clusterCenter = new PVector(random(0, cardWidth), random(0, cardHeight));
        int numBalls = int(random(2, 5.99));
        for (int j = 0; j < numBalls; j++) {
            metaballs[j] = new PVector(
                random(clusterCenter.x-clusterVariance, clusterCenter.x+clusterVariance),
                random(clusterCenter.y-clusterVariance, clusterCenter.y+clusterVariance)
            );
            metaballsRadii[j] = random(minClusterRadius, maxClusterRadius);
        }
        for (int j = numBalls; j < 5; j++) {
            metaballs[j] = new PVector(-1, -1);
            metaballsRadii[j] = -1;
        }
        for (int j = 0; j < 5; j++) {
            metaballShader.set(metaballStrings[j], metaballs[j].x, metaballs[j].y);
            metaballShader.set(metaballRadiiStrings[j], metaballsRadii[j]);
        }
        metaballShader.set("color", red(c4), green(c4), blue(c4));
        face.shader(metaballShader);
        face.rect(0, 0, cardWidth, cardHeight);
    }

    // Draw metaball clusters
    for (int i = 0; i < numClusters; i++) {
        PVector clusterCenter = new PVector(random(0, cardWidth), random(0, cardHeight));
        int numBalls = int(random(2, 5.99));
        for (int j = 0; j < numBalls; j++) {
            metaballs[j] = new PVector(
                random(clusterCenter.x-clusterVariance, clusterCenter.x+clusterVariance),
                random(clusterCenter.y-clusterVariance, clusterCenter.y+clusterVariance)
            );
            metaballsRadii[j] = random(minClusterRadius, maxClusterRadius);
        }
        for (int j = numBalls; j < 5; j++) {
            metaballs[j] = new PVector(-1, -1);
            metaballsRadii[j] = -1;
        }
        for (int j = 0; j < 5; j++) {
            metaballShader.set(metaballStrings[j], metaballs[j].x, metaballs[j].y);
            metaballShader.set(metaballRadiiStrings[j], metaballsRadii[j]);
        }
        metaballShader.set("color", red(c3), green(c3), blue(c3));
        face.shader(metaballShader);
        face.rect(0, 0, cardWidth, cardHeight);
    }

    // Draw metaball clusters
    for (int i = 0; i < numClusters; i++) {
        PVector clusterCenter = new PVector(random(0, cardWidth), random(0, cardHeight));
        int numBalls = int(random(2, 5.99));
        for (int j = 0; j < numBalls; j++) {
            metaballs[j] = new PVector(
                random(clusterCenter.x-clusterVariance, clusterCenter.x+clusterVariance),
                random(clusterCenter.y-clusterVariance, clusterCenter.y+clusterVariance)
            );
            metaballsRadii[j] = random(minClusterRadius, maxClusterRadius);
        }
        for (int j = numBalls; j < 5; j++) {
            metaballs[j] = new PVector(-1, -1);
            metaballsRadii[j] = -1;
        }
        for (int j = 0; j < 5; j++) {
            metaballShader.set(metaballStrings[j], metaballs[j].x, metaballs[j].y);
            metaballShader.set(metaballRadiiStrings[j], metaballsRadii[j]);
        }
        metaballShader.set("color", red(c2), green(c2), blue(c2));
        face.shader(metaballShader);
        face.rect(0, 0, cardWidth, cardHeight);
    }

    // Draw large front metaball structure
    metaballs[0] = new PVector(0.35*cardWidth, 0.3*cardHeight);
    metaballs[1] = new PVector(0.65*cardWidth, 0.7*cardHeight);
    metaballsRadii[0] = random(minBigRadius, maxBigRadius);
    metaballsRadii[1] = random(minBigRadius, maxBigRadius);
    for (int i = 2; i < 5; i++) {
        metaballs[i] = new PVector(-1, -1);
        metaballsRadii[i] = -1;
    }
    for (int i = 0; i < 5; i++) {
        metaballShader.set(metaballStrings[i], metaballs[i].x, metaballs[i].y);
        metaballShader.set(metaballRadiiStrings[i], metaballsRadii[i]);
    }
    metaballShader.set("color", red(c1), green(c1), blue(c1));
    face.shader(metaballShader);
    face.rect(0, 0, cardWidth, cardHeight);

    face.endDraw();
    return face;
}

// Setup canvas and draw the card
void setup() {
    size(1000, 1000, P2D);

    loadShaders();

    drawCard(bg, "S P L A T T E R");

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

void loadShaders() {
    metaballShader = loadShader("metaball.frag");
}