import hypermedia.video.*;
import java.awt.Rectangle;

OpenCV opencv;

// contrast/brightness values
int contrast_value    = 0;
int brightness_value  = 1;
int col, row;
int xwidth, yheight;
PImage img;
int x,y;

void setup() {

    size( 1280, 960 );
    opencv = new OpenCV( this );
    opencv.capture( width, height );                   // open video stream
    opencv.cascade( OpenCV.CASCADE_FRONTALFACE_ALT );  // load detection description, here-> front face detection : "haarcascade_frontalface_alt.xml"
    // print usage
    println( "Drag mouse on X-axis inside this sketch window to change contrast" );
    println( "Drag mouse on Y-axis inside this sketch window to change brightness" );

}


public void stop() {
    opencv.stop();
    super.stop();
}



void draw() {

    // grab a new frame
    // and convert to gray
    opencv.read();
    opencv.convert( GRAY );
    opencv.contrast( contrast_value );
    opencv.brightness( brightness_value );

    // proceed detection
    Rectangle[] faces = opencv.detect( 1.5, 2, OpenCV.HAAR_DO_CANNY_PRUNING, 40, 40 );

    // display the image
    image( opencv.image(), 0, 0 );

    // draw face area(s)
      noFill();
    //stroke(0,0,0);
    for( int i=0; i<faces.length; i++ ) {
        rect( faces[i].x, faces[i].y, faces[i].width, faces[i].height ); 
         xwidth = faces[i].width;
         yheight = faces[i].height; 
         x=faces[i].x;
         y=faces[i].y;
    }
    col = (int)xwidth/7;
    row = (int)yheight/10;
    println("col"+col+"r0w"+row);
    img = opencv.image();  
    for (int i=0; i< 10; i++){
      for (int j=0; j <7; j++){
    //exchange
    PImage boxA = img.get (x, y, col, row);
    int changex;
    if (j < 3)
    {
    changex = x+(int)random(-5,0)*col;
    }
    else
    changex = x+(int)random(0,5)*col;
    int changey = y+(int)random(-6,6)*row;
    PImage boxB = img.get (changex, changey, col, row);
    image(boxB,x,y);
    image(boxA,changex, changey);
    x = x + col;
      }
    x = x- 7* col;
    y = y + row;
    }
    delay (100);
}

/**
 * Changes contrast/brigthness values
 */
void mouseDragged() {
    contrast_value   = (int) map( mouseX, 0, width, -128, 128 );
    brightness_value = (int) map( mouseY, 0, width, -128, 128 );
}