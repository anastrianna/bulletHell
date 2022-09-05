/// @desc Set attributes

state = "default";

maxTime = 20;
minutes = 19;
wave = 1;

//0 - top, 1 - right, 2 - down, 3 - left 
quadrant = 0;
lymphoDelay = 0;

enum waveControlCols {
	endTime,
	isBoss,
	neutroCount,
	neutroMax,
	lymphoDelay,
	lymphoMax,
	count
}

waveControl = createGrid(
	["End Time", "Boss?", "Neutrophil Count", "Max Neutrophils", "Lymphocyte Spawn Delay", "Max Lymphocytes"],
	[19, false, 2, 30, 0, 0],
	[18, false, 4, 50, 5, 5],
	[17, true, 2, 20, 10, 3],
	[16, false, 6, 70, 4, 10],
	[14, false, 10, 50, 0, 0],
	[13, false, 6, 50, 1, 15],
	[0, false, 20, 100, 3, 10]
);