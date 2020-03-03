// Parameters
color wallpaperBG = #6b022a;
color wallpaperFG = #97bfba;
color hexBG = #fcedf3;
color hexFG = #32a899;
color wallpaperBorder = #ffffff;
color bg = #32a899;

// Function to draw the hex for the hex grid
PGraphics drawHex(int patternWidth, int patternHeight) {
    // Hex parameters
    float strokeSize = 3;
    float radius = patternWidth/2;

    // Generate the PGraphics object
    PGraphics hex = createGraphics(patternWidth*2, patternHeight*2, P2D);
    hex.smooth(8);
    hex.beginDraw();

    // Draw the hex
    hex.noFill();
    hex.stroke(hexFG);
    hex.strokeWeight(strokeSize);

    hex.translate(patternWidth/2, patternHeight/2);
    hex.beginShape();

    for (float a = PI/6; a < TWO_PI+TWO_PI/6; a += TWO_PI/6) {
        hex.vertex(
            cos(a) * radius,
            sin(a) * radius
        );
    }

    hex.endShape();
    hex.endDraw();
    return hex;
}

// Function to draw the hex grid
PGraphics drawHexGrid(int cardWidth, int cardHeight) {
    // Hex Grid parameters
    int patternWidth = 80;
    int patternHeight = 80;

    // Generate the base hex
    PGraphics hex = drawHex(patternWidth, patternHeight);

    // Generate the grid
    PGraphics grid = createGraphics(cardWidth, cardHeight, P2D);
    grid.smooth(8);
    grid.beginDraw();

    grid.fill(hexBG);
    grid.rect(0, 0, cardWidth, cardHeight);

    int yCount = 0;
    for (float y = 0; y < cardHeight+patternHeight; y+=patternHeight*3.0/4.0) {
        for (float x = 0; x < cardWidth+patternWidth; x+=sqrt(3.0)*patternWidth/2) {
            float hexX = x;
            float hexY = y;
            if (yCount % 2 == 0) hexX -= sqrt(3.0)*patternWidth/4.0;
            grid.image(hex, hexX, hexY);
        }
        yCount++;
    }

    grid.endDraw();
    return grid;
}

// Function to draw wallpaper with cutout
PGraphics drawWallpaper(int cardWidth, int cardHeight) {
    // Pattern parameters
    int patternWidth = 90;
    int patternHeight = 90;
    int numPatternsX = int(27/2.95);
    int numPatternsY = int(43/3.35);

    // Pattern randomize parameters
    float petalWidthMean = random(0.15, 0.25);
    float petalWidthVariance = 0.025;
    float petalHeightMean = random(0.25, 0.35);
    float petalHeightVariance = 0.025;
    float petalHeightOffsetMean = random(0.1, 0.2);
    float petalHeightOffsetVariance = 0.05;

    float dividerVertexMean = random(0.3, 0.5);
    float dividerVertexVariance = 0.05;
    float dividerCurveoutMean = random(0.02, 0.18);
    float dividerCurveoutVariance = 0.02;

    // Cutout parameters
    float cutoutHeightLeft = random(0.1, 0.9);
    float cutoutHeightRight = random(0.1, 0.9);
    float cutoutWidth = random(10, 30);
    float flip = random(0, 1);

    // Generate the wallpaper
    PGraphics wallpaper = createGraphics(cardWidth, cardHeight, P2D);
    wallpaper.smooth(8);
    wallpaper.beginDraw();

    wallpaper.fill(wallpaperBG);
    wallpaper.rect(0, 0, cardWidth, cardHeight);

    // Blit the pattern on the wallpaper
    wallpaper.imageMode(CENTER);
    for (int x = 0; x < numPatternsX; x++) {
        for (int y = 0; y < numPatternsY; y++) {
            float patternX = map(
                x, 0, numPatternsX-1,
                -patternWidth, cardWidth+patternWidth
            );
            if (
                y % 2 == 0 && x % 2 == 0 ||
                y % 2 == 1 && x % 2 == 1
                ) {
                float patternY = map(
                    y, 0, numPatternsY-1, 
                    -patternHeight, cardHeight+patternHeight
                );

                // Generate the pattern to be used on the wallpaper
                {
                    // More pattern parameters
                    float petalWidth = random(petalWidthMean-petalWidthVariance, petalWidthMean+petalWidthVariance);
                    float petalHeight = random(petalHeightMean-petalHeightVariance, petalHeightMean+petalHeightVariance);
                    float petalHeightOffset = random(petalHeightOffsetMean-petalHeightOffsetVariance, petalHeightOffsetMean+petalHeightOffsetVariance);

                    // Draw pattern
                    wallpaper.noStroke();
                    wallpaper.fill(wallpaperFG);

                    wallpaper.pushMatrix();
                    wallpaper.translate(patternX, patternY);
                
                    for (int i = 0; i < 8; i++) {
                        wallpaper.rotate(HALF_PI/2.0);
                        wallpaper.ellipse(
                            0, patternHeight*petalHeight/2+petalHeightOffset*patternHeight, 
                            petalWidth*patternWidth, petalHeight*patternHeight
                        );
                    }

                    wallpaper.popMatrix();
                }
            }
        }
    }

    // Blit the divider pattern on the wallpaper
    wallpaper.imageMode(CENTER);
    for (int x = 0; x < numPatternsX; x++) {
        for (int y = 0; y < numPatternsY; y++) {
            float patternX = map(
                x, 0, numPatternsX-1,
                -patternWidth, cardWidth+patternWidth
            );
            if (
                y % 2 == 0 && x % 2 == 1 ||
                y % 2 == 1 && x % 2 == 0
                ) {
                float patternY = map(
                    y, 0, numPatternsY-1, 
                    -patternHeight, cardHeight+patternHeight
                );

                // Generate the pattern to be used in the wallpaper
                {
                    // Wallpaper divider parameters
                    float dividerTop = random(dividerVertexMean-dividerVertexVariance, dividerVertexMean+dividerVertexVariance);
                    float dividerBottom = random(dividerVertexMean-dividerVertexVariance, dividerVertexMean+dividerVertexVariance);
                    float dividerLeft = random(dividerVertexMean-dividerVertexVariance, dividerVertexMean+dividerVertexVariance);
                    float dividerRight = random(dividerVertexMean-dividerVertexVariance, dividerVertexMean+dividerVertexVariance);
                    float dividerCurveout1 = random(dividerCurveoutMean-dividerCurveoutVariance, dividerCurveoutMean+dividerCurveoutVariance);
                    float dividerCurveout2 = random(dividerCurveoutMean-dividerCurveoutVariance, dividerCurveoutMean+dividerCurveoutVariance);
                    float dividerCurveout3 = random(dividerCurveoutMean-dividerCurveoutVariance, dividerCurveoutMean+dividerCurveoutVariance);
                    float dividerCurveout4 = random(dividerCurveoutMean-dividerCurveoutVariance, dividerCurveoutMean+dividerCurveoutVariance);

                    // Draw pattern
                    wallpaper.noStroke();
                    wallpaper.fill(wallpaperFG);

                    wallpaper.pushMatrix();
                    wallpaper.translate(patternX, patternY);
                    wallpaper.beginShape();
                    
                    wallpaper.vertex(0, patternHeight/2*dividerTop);
                    wallpaper.bezierVertex(
                        patternWidth/2*dividerCurveout1, patternHeight/2*dividerCurveout1,
                        patternWidth/2*dividerCurveout1, patternHeight/2*dividerCurveout1,
                        patternWidth/2*dividerRight, 0
                    );
                    wallpaper.bezierVertex(
                        patternWidth/2*dividerCurveout2, -patternHeight/2*dividerCurveout2,
                        patternWidth/2*dividerCurveout2, -patternHeight/2*dividerCurveout2,
                        0, -patternHeight/2*dividerBottom
                    );
                    wallpaper.bezierVertex(
                        -patternWidth/2*dividerCurveout3, -patternHeight/2*dividerCurveout3,
                        -patternWidth/2*dividerCurveout3, -patternHeight/2*dividerCurveout3,
                        -patternWidth/2*dividerLeft, 0
                    );
                    wallpaper.bezierVertex(
                        -patternWidth/2*dividerCurveout4, patternHeight/2*dividerCurveout4,
                        -patternWidth/2*dividerCurveout4, patternHeight/2*dividerCurveout4,
                        0, patternHeight/2*dividerTop
                    );

                    wallpaper.endShape();
                    wallpaper.popMatrix();
                }
            }
        }
    }

    // Draw the wallpaper border
    wallpaper.fill(wallpaperBorder);
    wallpaper.noStroke();

    wallpaper.beginShape();
    wallpaper.vertex(0, cardHeight*cutoutHeightLeft);
    wallpaper.vertex(cardWidth, cardHeight*cutoutHeightRight);
    if (flip > 0.5) cutoutWidth *= -1;
    wallpaper.vertex(cardWidth, cardHeight*cutoutHeightRight+cutoutWidth);
    wallpaper.vertex(0, cardHeight*cutoutHeightLeft+cutoutWidth);
    wallpaper.endShape();

    wallpaper.endDraw();

    // Generate the PGraphics wallpaper cutout
    PGraphics wallpaperCutout = createGraphics(cardWidth, cardHeight, P2D);
    wallpaperCutout.smooth(8);

    wallpaperCutout.beginDraw();
    wallpaperCutout.noStroke();

    wallpaperCutout.fill(255);
    wallpaperCutout.rect(0, 0, cardWidth, cardHeight);

    wallpaperCutout.fill(0);
    wallpaperCutout.beginShape();
    wallpaperCutout.vertex(0, cardHeight*cutoutHeightLeft);
    wallpaperCutout.vertex(cardWidth, cardHeight*cutoutHeightRight);
    if (flip > 0.5) {
        wallpaperCutout.vertex(cardWidth, cardHeight);
        wallpaperCutout.vertex(0, cardHeight);
    } else {
        wallpaperCutout.vertex(cardWidth, 0);
        wallpaperCutout.vertex(0, 0);
    }
    wallpaperCutout.endShape();

    wallpaperCutout.endDraw();

    // Generate final wallpaper product
    PGraphics wallpaperFinal = createGraphics(cardWidth, cardHeight, P2D);
    wallpaperFinal.beginDraw();

    wallpaperFinal.image(wallpaper, 0, 0);
    wallpaperFinal.mask(wallpaperCutout);

    wallpaperFinal.endDraw();

    return wallpaperFinal;
}

// Template function for drawing
PGraphics drawSpecificCard(int cardWidth, int cardHeight) {
    // Generate the wallpaper
    PGraphics wallpaper = drawWallpaper(cardWidth, cardHeight);

    // Generate the hex
    PGraphics hexGrid = drawHexGrid(cardWidth, cardHeight);
    
    // Generate the final card face
    PGraphics face = createGraphics(cardWidth, cardHeight, P2D);
    face.beginDraw();

    // Blit the final hexgrid product to the card face
    face.image(hexGrid, 0, 0);

    // Blit the final wallpaper product to the card face
    face.image(wallpaper, 0, 0);

    face.endDraw();
    return face;
}

// Setup canvas and draw the card
void setup() {
    size(1000, 1000, P2D);

    drawCard(bg, "P E E L I N G");

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
