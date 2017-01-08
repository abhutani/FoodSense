The required files for this code are:
kmeans_main.m: The file which contains the code to train the data. Change folder/path for reading the image according to your needs.
testkmeans.m: Once the model is ready, run this to test your data.
main.m: Main function for MFO+GSA.
MFO_GSA.m: Code for the hybrid algorithm.
initializaiton.m: To initialize the population for MFO+GSA
func_plot.m: For plotting the convergence curve of the optimization
Get_Function_Details.m: For running the optimization on the benchmark functions

To run the code, 
1. Open MATLAB
2. Open file named 'kmeans_main'
3. Click on the Run button to run the code
4. Label each cluster in the terminal
5. The features generated will be written to lbp_features.csv
6. Run testkmeans.m to test the data on the features generated above.