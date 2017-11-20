// blocks will analyze rectangles within the camera image, so we do analysis on larger areas
// than pixels (less noise)
class Block {
	int x, y;
	PImage chunk;
	boolean active = false;

	Block(int x, int y) {
		this.x = x;
		this.y = y;
		// set up PImage chunk
		chunk = new PImage(blockW, blockH);

	}

	void test() {
		// reset to inactive
		active = false;

		// copy piece of image for analysis
		chunk = movementImg.get(x, y, blockW, blockH);

		chunk.loadPixels();
		int totalBrightness = 0;
		// go thru each pixel in block
		for (int i = 0; i < blockW * blockH; i++) {
			totalBrightness += brightness(chunk.pixels[i]);
		}

		// if we crossed the threshold...
		int outOf = blockW * blockH * 255;
		if (totalBrightness > (outOf * blockThreshold)) {
			if (diagnostics) {
				fill(255, 255, 0, 255);
				noStroke();
				rect(x, y, blockW, blockH);
			}

			active = true;	// it's "on"
		}
	}
}