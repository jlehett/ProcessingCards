color cardBG = #252323;
color bg = #a99985;
color darkBG = #201d1d;
color lightBG = #2a2828;
color etchColor = #dad2bc;
color etchColor2 = #70798c;
color etchColor3 = #ed6a5a;

void etchLine(
    PGraphics canvas, float stretchError, float varianceError,
    float x1, float y1, float x2, float y2, color c,
    float strokeSize
    ) {

    PVector gradient, perpendicularGradient;
    PVector p1 = new PVector(x1, y1);
    PVector p2 = new PVector(x2, y2);
    gradient = PVector.sub(p2, p1);
    if (x1 != x2 && y1 != y2) {
        perpendicularGradient = new PVector(
            (y2-y1), -(x2-x1)
        );
    }
    else if (x1 == x2) {
        perpendicularGradient = new PVector(
            1, 0
        );
    }
    else {
        perpendicularGradient = new PVector(
            0, 1
        );
    }
    gradient.normalize();
    perpendicularGradient.normalize();

    float stretchDistance, varianceDistance;
    //float lineMagnitude = PVector.sub(p2, p1).mag();
    float lineMagnitude = 100;

    stretchDistance = random(-stretchError*lineMagnitude, stretchError*lineMagnitude);
    varianceDistance = random(-varianceError*lineMagnitude, varianceError*lineMagnitude);
    PVector newP1 = PVector.add(PVector.add(new PVector(x1, y1), gradient.copy().mult(stretchDistance)), perpendicularGradient.copy().mult(varianceDistance));
    stretchDistance = random(-stretchError*lineMagnitude, stretchError*lineMagnitude);
    varianceDistance = random(-varianceError*lineMagnitude, varianceError*lineMagnitude);
    PVector newP2 = PVector.add(PVector.add(new PVector(x2, y2), gradient.copy().mult(stretchDistance)), perpendicularGradient.copy().mult(varianceDistance));

    canvas.stroke(c);
    canvas.strokeWeight(strokeSize);
    canvas.line(newP1.x, newP1.y, newP2.x, newP2.y);
}

void etchPattern(
    PGraphics canvas, float stretchError, float varianceError, 
    float[][] pattern, color c, float strokeSize,
    PVector gridMin, PVector gridMax, int cardWidth, int cardHeight
    ) {

    if (random(0, 1) < 0.15) {
        if (random(0, 1) < 0.15) c = etchColor3;
        else c = etchColor2;
    }
    else c = etchColor;

    for (int i = 0; i < pattern.length; i++) {
        for (int j = 0; j < 10; j++) {
            etchLine(
                canvas, stretchError, varianceError,
                map(pattern[i][0], 0.0, 1.0, gridMin.x*cardWidth, gridMax.x*cardWidth),
                map((1.0-pattern[i][1]), 0.0, 1.0, gridMin.y*cardHeight, gridMax.y*cardHeight),
                map(pattern[i][2], 0.0, 1.0, gridMin.x*cardWidth, gridMax.x*cardWidth),
                map((1.0-pattern[i][3]), 0.0, 1.0, gridMin.y*cardHeight, gridMax.y*cardHeight),
                c, strokeSize
            );
        }
    }
}

void writeHieroglyphs(
    PGraphics canvas, float stretchError, float varianceError,
    float[][][] alphabet, color c, float strokeSize,
    int cardWidth, int cardHeight, 
    int numSymbolsX, int numSymbolsY, float symbolSizeX, float symbolSizeY
    ) {

    float symbolSizeXRatio = symbolSizeX / cardWidth;
    float symbolSizeYRatio = symbolSizeY / cardHeight;
    for (int x = 0; x < numSymbolsX; x++) {
        for (int y = 0; y < numSymbolsY; y++) {

            float[][] glyph = alphabet[
                round(random(0, alphabet.length-1))
            ];

            PVector gridMin = new PVector(
                map(x, 0, numSymbolsX-1, symbolSizeXRatio*0.75, 1.0-symbolSizeXRatio*0.75-symbolSizeXRatio),
                map(y, 0, numSymbolsY-1, symbolSizeYRatio*0.75, 1.0-symbolSizeYRatio*0.75-symbolSizeYRatio)
            );
            PVector gridMax = new PVector(
                gridMin.x + symbolSizeXRatio,
                gridMin.y + symbolSizeYRatio
            );

            etchPattern(
                canvas, stretchError, varianceError, glyph, etchColor,
                strokeSize, gridMin, gridMax, cardWidth, cardHeight
            );
        }
    }
}

// Template function for drawing
PGraphics drawSpecificCard(int cardWidth, int cardHeight) {
    PGraphics face = createGraphics(cardWidth, cardHeight, P2D);
    face.smooth(8);
    face.beginDraw();
    face.noStroke();

    // Parameters
    float strokeSize = 1;
    float stretchError = 0.06;
    float varianceError = 0.035;
    int numSymbolsX = 9;
    int numSymbolsY = 9;
    int symbolSizeX = 50;
    int symbolSizeY = 50;

    // Draw background
    face.fill(cardBG);
    face.rect(0, 0, cardWidth, cardHeight);

    // Draw patterns
    float[][][] patterns = {
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.5, 0.8, 0.8},
            {0.2, 0.7, 0.7, 0.95}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.9, 0.8, 0.7},
            {0.8, 0.7, 0.8, 0.1}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.9, 0.8, 0.7},
            {0.8, 0.7, 0.2, 0.5}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.9, 0.2, 0.8},
            {0.5, 0.9, 0.8, 0.8},
            {0.5, 0.6, 0.2, 0.5},
            {0.5, 0.6, 0.8, 0.5}
        },
        {
            {0.2, 0.9, 0.3, 0.5},
            {0.3, 0.5, 0.7, 0.7},
            {0.7, 0.7, 0.7, 0.1}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.9, 0.8, 0.7},
            {0.2, 0.6, 0.8, 0.4}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.9, 0.8, 0.7},
            {0.8, 0.7, 0.2, 0.5},
            {0.2, 0.5, 0.8, 0.1}
        },
        {
            {0.2, 0.5, 0.8, 0.9},
            {0.2, 0.5, 0.8, 0.1}
        },
        {
            {0.2, 0.9, 0.8, 0.1},
            {0.2, 0.1, 0.8, 0.9}
        },
        {
            {0.2, 0.1, 0.5, 0.4},
            {0.5, 0.9, 0.5, 0.1},
            {0.5, 0.4, 0.8, 0.1},
            {0.2, 0.9, 0.5, 0.6},
            {0.8, 0.9, 0.5, 0.6},
            {0.5, 0.7, 0.8, 0.5},
            {0.8, 0.5, 0.5, 0.3},
            {0.5, 0.7, 0.2, 0.5},
            {0.2, 0.5, 0.5, 0.3}
        },
        {
            {0.2, 0.9, 0.2, 0.3},
            {0.2, 0.3, 0.8, 0.7},
            {0.8, 0.7, 0.8, 0.1},
            {0.05, 0.8, 0.35, 0.8},
            {0.65, 0.2, 0.95, 0.2}
        },
        {
            {0.5, 0.8, 0.3, 0.7},
            {0.3, 0.7, 0.15, 0.5},
            {0.15, 0.5, 0.3, 0.3},
            {0.3, 0.3, 0.5, 0.2},
            {0.5, 0.2, 0.7, 0.3},
            {0.7, 0.3, 0.85, 0.5},
            {0.85, 0.5, 0.7, 0.7},
            {0.7, 0.7, 0.5, 0.8},
            {0.5, 0.8, 0.5, 0.2},
            {0.15, 0.5, 0.85, 0.5}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.2, 0.7, 0.8, 0.4}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.9, 0.2, 0.7},
            {0.2, 0.7, 0.5, 0.5}
        },
        {
            {0.5, 0.1, 0.5, 0.9}
        },
        {
            {0.45, 0.7, 0.2, 0.5},
            {0.2, 0.5, 0.5, 0.1},
            {0.55, 0.4, 0.8, 0.7},
            {0.8, 0.7, 0.5, 0.9}
        },
        {
            {0.2, 0.9, 0.2, 0.1},
            {0.55, 0.7, 0.2, 0.9},
            {0.55, 0.3, 0.2, 0.1},
            {0.8, 0.9, 0.55, 0.7},
            {0.8, 0.1, 0.55, 0.3}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.2, 0.9, 0.5, 0.7},
            {0.8, 0.9, 0.5, 0.7}
        },
        {
            {0.6, 0.9, 0.2, 0.5},
            {0.2, 0.5, 0.8, 0.5},
            {0.8, 0.5, 0.4, 0.1}
        },
        {
            {0.5, 0.9, 0.5, 0.1},
            {0.5, 0.9, 0.3, 0.7},
            {0.2, 0.5, 0.8, 0.5},
            {0.2, 0.5, 0.3, 0.3},
            {0.5, 0.1, 0.7, 0.3},
            {0.8, 0.5, 0.7, 0.7}
        },
        {
            {0.2, 0.9, 0.8, 0.1},
            {0.2, 0.1, 0.8, 0.9},
            {0.5, 0.8, 0.3, 0.5},
            {0.3, 0.5, 0.5, 0.2},
            {0.5, 0.2, 0.7, 0.5},
            {0.7, 0.5, 0.5, 0.8}
        },
        {
            {0.2, 0.1, 0.5, 0.2},
            {0.5, 0.2, 0.65, 0.5},
            {0.65, 0.5, 0.5, 0.9},
            {0.5, 0.9, 0.35, 0.5},
            {0.35, 0.5, 0.8, 0.1}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.2, 0.8, 0.8, 0.4},
            {0.2, 0.4, 0.8, 0.8}
        },
        {
            {0.3, 0.1, 0.3, 0.9},
            {0.3, 0.9, 0.6, 0.7}
        },
        {
            {0.8, 0.9, 0.2, 0.5},
            {0.2, 0.5, 0.8, 0.1},
            {0.2, 0.9, 0.8, 0.5},
            {0.8, 0.5, 0.2, 0.1}
        },
        {
            {0.2, 0.8, 0.8, 0.8},
            {0.8, 0.8, 0.2, 0.2},
            {0.2, 0.2, 0.8, 0.2},
            {0.8, 0.2, 0.2, 0.8}
        },
        {
            {0.2, 0.1, 0.8, 0.6},
            {0.8, 0.6, 0.5, 0.9},
            {0.5, 0.9, 0.2, 0.6},
            {0.2, 0.6, 0.8, 0.1}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.5, 0.5, 0.55},
            {0.5, 0.55, 0.75, 0.8},
            {0.75, 0.8, 0.8, 0.9},
            {0.2, 0.75, 0.5, 0.8},
            {0.5, 0.8, 0.55, 0.9}
        },
        {
            {0.2, 0.9, 0.8, 0.1},
            {0.2, 0.1, 0.8, 0.9},
            {0.2, 0.5, 0.4, 0.7},
            {0.2, 0.5, 0.4, 0.3},
            {0.8, 0.5, 0.6, 0.7},
            {0.8, 0.5, 0.6, 0.3}
        },
        {
            {0.35, 0.9, 0.2, 0.8},
            {0.35, 0.9, 0.45, 0.8},
            {0.35, 0.9, 0.35, 0.5},
            {0.35, 0.5, 0.8, 0.7},
            {0.8, 0.7, 0.8, 0.1}
        },
        {
            {0.1, 0.1, 0.3, 0.3},
            {0.3, 0.3, 0.5, 0.1},
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.9, 0.7, 0.7},
            {0.7, 0.7, 0.9, 0.9}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.9, 0.7, 0.6},
            {0.7, 0.6, 0.7, 0.1},
            {0.2, 0.45, 0.3, 0.4},
            {0.3, 0.4, 0.5, 0.1}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.9, 0.5, 0.9},
            {0.5, 0.9, 0.5, 0.1},
            {0.5, 0.1, 0.8, 0.3},
            {0.2, 0.7, 0.5, 0.7}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.9, 0.6, 0.7},
            {0.6, 0.7, 0.9, 0.9},
            {0.2, 0.7, 0.6, 0.5},
            {0.6, 0.5, 0.9, 0.7}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.2, 0.7, 0.8, 0.5},
            {0.2, 0.5, 0.8, 0.3}
        },
        {
            {0.8, 0.1, 0.8, 0.9},
            {0.8, 0.7, 0.6, 0.9},
            {0.8, 0.5, 0.45, 0.9}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.3, 0.8, 0.1}
        },
        {
            {0.2, 0.9, 0.2, 0.1},
            {0.2, 0.9, 0.8, 0.7},
            {0.8, 0.7, 0.8, 0.1},
            {0.5, 0.6, 0.3, 0.45},
            {0.35, 0.45, 0.5, 0.3},
            {0.5, 0.3, 0.65, 0.45},
            {0.65, 0.45, 0.5, 0.6}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.3, 0.9, 0.7, 0.9}
        },
        {
            {0.2, 0.4, 0.5, 0.1},
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.9, 0.8, 0.6},
            {0.5, 0.4, 0.8, 0.4}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.5, 0.8, 0.2},
            {0.2, 0.7, 0.8, 0.4},
            {0.8, 0.1, 0.8, 0.9}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.9, 0.8, 0.5},
            {0.8, 0.1, 0.8, 0.9},
            {0.8, 0.9, 0.2, 0.5}
        },
        {
            {0.2, 0.4, 0.5, 0.1},
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.9, 0.8, 0.9},
            {0.8, 0.9, 0.8, 0.1},
            {0.5, 0.7, 0.8, 0.7}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.7, 0.3, 0.5},
            {0.3, 0.5, 0.5, 0.3},
            {0.5, 0.3, 0.7, 0.5},
            {0.7, 0.5, 0.5, 0.7}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.8, 0.2, 0.5},
            {0.2, 0.5, 0.5, 0.2},
            {0.5, 0.2, 0.8, 0.5},
            {0.8, 0.5, 0.5, 0.8}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.7, 0.3, 0.75},
            {0.3, 0.75, 0.2, 0.9},
            {0.5, 0.7, 0.7, 0.75},
            {0.7, 0.75, 0.8, 0.9}
        },
        {
            {0.8, 0.9, 0.2, 0.7},
            {0.2, 0.7, 0.8, 0.5},
            {0.8, 0.5, 0.2, 0.3},
            {0.2, 0.3, 0.8, 0.1}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.9, 0.6, 0.7},
            {0.6, 0.7, 0.2, 0.5},
            {0.2, 0.5, 0.8, 0.3},
            {0.8, 0.3, 0.2, 0.1}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.1, 0.2, 0.4},
            {0.5, 0.1, 0.8, 0.4}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.3, 0.8, 0.5, 0.9},
            {0.7, 0.2, 0.5, 0.1}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.7, 0.5, 0.5},
            {0.2, 0.3, 0.5, 0.5}
        },
        {
            {0.2, 0.9, 0.3, 0.5},
            {0.7, 0.7, 0.3, 0.5},
            {0.8, 0.1, 0.7, 0.7}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.9, 0.2, 0.6},
            {0.5, 0.9, 0.8, 0.6}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.7, 0.7, 0.9}
        },
        {
            {0.3, 0.9, 0.7, 0.9},
            {0.7, 0.9, 0.8, 0.4},
            {0.8, 0.4, 0.2, 0.4},
            {0.2, 0.4, 0.3, 0.9},
            {0.2, 0.1, 0.2, 0.4},
            {0.5, 0.1, 0.5, 0.4},
            {0.8, 0.1, 0.8, 0.4}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.3, 0.3, 0.1},
            {0.5, 0.3, 0.7, 0.1}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.8, 0.1, 0.8, 0.9},
            {0.2, 0.8, 0.8, 0.6},
            {0.2, 0.6, 0.8, 0.4},
            {0.2, 0.4, 0.8, 0.2}
        },
        {
            {0.5, 0.4, 0.5, 0.1},
            {0.5, 0.4, 0.3, 0.6},
            {0.3, 0.4, 0.5, 0.6},
            {0.5, 0.6, 0.5, 0.9},
            {0.5, 0.6, 0.7, 0.4},
            {0.5, 0.4, 0.7, 0.6}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.5, 0.2, 0.7},
            {0.5, 0.5, 0.8, 0.7}
        },
        {
            {0.4, 0.1, 0.4, 0.9},
            {0.4, 0.9, 0.8, 0.6},
            {0.4, 0.5, 0.2, 0.4},
            {0.2, 0.4, 0.4, 0.3},
            {0.4, 0.3, 0.5, 0.4},
            {0.5, 0.4, 0.4, 0.5}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.9, 0.8, 0.7},
            {0.5, 0.5, 0.2, 0.3}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.7, 0.3, 0.9},
            {0.5, 0.7, 0.7, 0.9},
            {0.5, 0.3, 0.3, 0.1},
            {0.5, 0.3, 0.7, 0.1}
        },
        {
            {0.5, 0.7, 0.3, 0.5},
            {0.3, 0.5, 0.5, 0.3},
            {0.5, 0.3, 0.7, 0.5},
            {0.7, 0.5, 0.5, 0.7}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.1, 0.2, 0.25},
            {0.5, 0.9, 0.8, 0.75},
            {0.35, 0.5, 0.65, 0.5}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.9, 0.3, 0.7},
            {0.3, 0.7, 0.1, 0.9},
            {0.5, 0.9, 0.7, 0.7},
            {0.7, 0.7, 0.9, 0.9}
        },
        {
            {0.5, 0.1, 0.5, 0.9},
            {0.5, 0.1, 0.2, 0.3},
            {0.5, 0.1, 0.8, 0.3},
            {0.5, 0.9, 0.2, 0.7},
            {0.5, 0.9, 0.8, 0.7}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.8, 0.1, 0.8, 0.9},
            {0.2, 0.6, 0.8, 0.4}
        },
        {
            {0.2, 0.1, 0.2, 0.9},
            {0.2, 0.1, 0.8, 0.9},
            {0.8, 0.9, 0.8, 0.1}
        }
    };

    face.stroke(lightBG);
    face.strokeWeight(10);
    face.fill(darkBG);
    face.ellipse(cardWidth/2, cardHeight/2, 500, 500);
    

    writeHieroglyphs(
        face, stretchError, varianceError, patterns, etchColor, strokeSize,
        cardWidth, cardHeight, numSymbolsX, numSymbolsY, symbolSizeX, symbolSizeY
    );

    face.endDraw();
    return face;
}

// Setup canvas and draw the card
void setup() {
    size(1200, 1200, P2D);

    drawCard(bg, "E T C H I N G");

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

