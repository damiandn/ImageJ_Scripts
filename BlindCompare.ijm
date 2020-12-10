
/* 
Script for blind comparison of images two groups of images
Select a folder containing control images, and a folder containing treated images
script will compare one random control image with one random treated image, and prompt you to guess which is treated
Images must all be the same size, for now
*/



control_dir = getDirectory("Choose the folder containing the control images");
treated_dir = getDirectory("Choose the folder containing the treated images");
control_files = getFileList(control_dir);
treated_files = getFileList(treated_dir);
correct_guesses = 0
total_guesses = 0
setFont("SansSerif", 38, true);

number_of_trials = getNumber("How many trials", 10);

for (i=0; i<number_of_trials; i++) {
	
	setBatchMode(true);
	
	random_control = control_dir + control_files[floor(random * control_files.length)];
	random_treated = treated_dir + treated_files[floor(random * treated_files.length)];
	open(random_control);
	rename("control");
	image_width = getWidth();
	image_height = getHeight();
	
	open(random_treated);
	rename("treated");
	
	if (round(random) == 0) {
		treated_answer = 2;
		run("Combine...", "stack1=control stack2=treated");
	} else {
		run("Combine...", "stack1=treated stack2=control");
		treated_answer = 1;
	}
	
	makeText('1', 0, 0);
	run("Draw");
	makeText('2', image_width, 0);
	run("Draw");
	run("Select None");
	
	setBatchMode(false);
	
	guess_number = getNumber("Enter the number of the treated embryo", 1);
	if (guess_number == treated_answer) {
		correct_guesses = correct_guesses + 1;
		total_guesses = total_guesses + 1;
	}else {
		total_guesses = total_guesses + 1;
	}

	while (nImages>0) { 
			  selectImage(nImages); 
			  close(); 
			 } 

}

Dialog.createNonBlocking("Results")
Dialog.addMessage("You got " + correct_guesses + " out of " + total_guesses + " correct, for a score of " + correct_guesses / total_guesses * 100 + "%");
Dialog.show()



