
class Faller {
	float x, y;

	Faller() {
		x = random(width);
		y = random(height);

	}

	void update() {
		// fall, faller!
		y += 20;

		// what column is this faller in?
		int c = round(map(x, 0, width, 0, topBlock.length));

		// should this be resting?
		if (y > topBlock[c]) {
			y = topBlock[c];	// set y to the top block of whatever column we are in
		}

		fill(255);
		// subtract Y so that we arent drawing topleft corner of rect where the base of movement is
			//image(balls, x, y-blockH);
	rect(x, y-blockH, blockW, blockH);
	}
}