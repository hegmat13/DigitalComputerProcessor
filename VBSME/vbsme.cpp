// Labs5-8.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>


int FindSadCount(int locx, int locy, int k, int l, int frame[4][4], int window[2][2]) {   //Traverse through values of array at point (0,0)
	int SadCount = 0;

	for (int m = 0; m < k; m++) {
		for (int n = 0; n < l; n++) {
			SadCount = abs(frame[m][n] - window[m + locx][n + locy]) + SadCount;     //Absolute Value of the difference and add it to the Sad 
		}
		n = 0;
	}
	return SadCount;   //Return the total Sad of the window on the specified location of the frame
}



int main()
{
	//printf("this works here");
	int  i = 4;   //size of rows of frame
	int  j = 4;   //size of columns of frame
	int  k = 2;    //size of rows of window
	int  l = 2;   //size of columns of window

	//Coortinates will be used to store the location of the window in the frame of the matrix
	int  xmax = i - k;   //max Coordinate location for x 
	int  ymax = j - l;   //max Coordinate location for y
	int locx = 0, locy = 0;   //Position of the entire window within the frame 
	int minlocx = 0, minlocy = 0;    //Minimum location of sad x and y coordinates 

	int  MinSad = 100000;  //Minimum Value stored from Sad Routine
	int  SadCount = 0;     //Temporary Sad count

	int frame[4][4] = { { 0,  0,  1,  2}, {0,  0,  3,  4}, {0,  0,  0,  0}, { 0,  0,  0,  0} };  //frame array values 
    int window[2][2] = { { 1, 2 }, { 3, 4 } };     //window array values 

	//printf("%d", frame[1][2]);
	//int size;

	if (locx == xmax && locy == ymax) {                               //If the frame is the same size as the window 
		SadCount = FindSadCount(locx, locy, k, l, frame, window);    //Calculate Sad for frame at locx = 0 and locy = 0 
		MinSad = SadCount;
	}

	//Need to write code for traversing through the frame and updating the Min Sad Value! 
	//Moving Algorithm: Enclosed in a while loop that makes sure it doesn't equal xmax or ymax
	
	while (locx != xmax && locy != ymax) {
		if (locy == ymax) {              //Check Edge case and move: if met move down, else right, Edge Case: if locy == ymax
			locx++;
		}
		else {
			locy++;
		}
		//Find Sad at window position and check if it is the minimum
		SadCount = FindSadCount(locx, locy, k, l, frame, window);
		if (SadCount < MinSad) {
			MinSad = SadCount;
			minlocx = locx;
			minlocy = locy;
		}

		for (int d = locy; (d > 0) || (locx == xmax); d--) {  //Move Diagonal Left until locy equals zero or locx == xmax
			locx++;
			locy--;
		}

		//Find Sad at window position and check if it is the minimum
		SadCount = FindSadCount(locx, locy, k, l, frame, window);
		if (SadCount < MinSad) {
			MinSad = SadCount;
			minlocx = locx;
			minlocy = locy;
		}

		if (locx == xmax) {              //Check Edge case and move: if met move right, else down, Edge Case: if locx == xmax
			locy++;
		}
		else {
			locx++;
		}

		//Find Sad at window position and check if it is the minimum
		SadCount = FindSadCount(locx, locy, k, l, frame, window);
		if (SadCount < MinSad) {
			MinSad = SadCount;
			minlocx = locx;
			minlocy = locy;
		}

		for (int f = locx; (f > 0) || (locy == ymax); f--) {  //Move Diagonal Right until locx equals zero or locy == ymax
			locx++;
			locy++;
		}

		//Find Sad at window position and check if it is the minimum
		SadCount = FindSadCount(locx, locy, k, l, frame, window);
		if (SadCount < MinSad) {
			MinSad = SadCount;
			minlocx = locx;
			minlocy = locy;
		}
	}

	printf("%d, %d", minlocx, minlocy);


	//***in MIPS assembly language will be reading values from asize1
	printf("Enter number of rows and columns of the frame array followed by a space:");  // Need to read in the dimensions of the frame and window
	//scanf("%d %d", i, j);
	printf("Enter number of rows and columns of the window array followed by a space:");
	//scanf("%d %d", k, l);

	return 0;
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
