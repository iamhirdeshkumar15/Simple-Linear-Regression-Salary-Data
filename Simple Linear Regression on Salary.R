# Simple Linear Regression On Salary Dataset
# Importing the dataset  

getwd()  
# Retrieves the current working directory where R is searching for files.
dataset = read.csv("C:/Users/Hirdesh Kumar Yadav/Downloads/R Predictive Analysis/Salary_Data.csv")  
# Reads the Salary_Data.csv file into the dataset variable.
View(dataset)  
# Opens the dataset in a new window, allowing for manual inspection.

## Splitting the dataset into the Training set and Test set  

install.packages('caTools')  
# Installs the caTools package, which provides the sample.split() function used for data splitting.
library(caTools)  
# Loads the caTools package into the session, making its functions accessible.
split = sample.split(dataset$Salary, SplitRatio = 0.7)  
# Randomly splits the dataset based on the 'Salary' column with 70% data for training and 30% for testing.
split  
# Displays the result of the split, where TRUE corresponds to training data and FALSE to test data.

## 0.7 means 70% training and 30% testing 
## Used to split the data for classification into training and testing sets.
trainingset = subset(dataset, split == TRUE)  
# Creates a training set from the dataset where split == TRUE.
View(trainingset)  
# Displays the training set for manual inspection.
testset = subset(dataset, split == FALSE)  
# Creates a test set from the dataset where split == FALSE.
View(testset)  
# Displays the test set for manual inspection.

## Fitting Simple Linear Regression to the Training set  
lm.r = lm(formula = Salary ~ YearsExperience, data = trainingset)  
# Fits a simple linear regression model on the training data, where 'Salary' is the dependent variable and 'YearsExperience' is the independent variable.

## lm is used to fit linear models, where formula describes the relationship between the dependent and independent variables.
coef(lm.r)  
# Extracts and displays the coefficients (intercept and slope) of the linear regression model.

## Predicting the Test set results  
ypred = predict(lm.r, newdata = testset)  
# Uses the trained linear model to predict 'Salary' for the test set based on 'YearsExperience'.

install.packages("ggplot2")  
# Installs the ggplot2 package for visualization.
library(ggplot2)  
# Loads the ggplot2 package into the session.

## Visualising the Training set results  
ggplot() + geom_point(aes(x = trainingset$YearsExperience, y = trainingset$Salary), colour = 'red') +  
  # Plots the training data points where 'YearsExperience' is on the x-axis and 'Salary' is on the y-axis; points are colored red.
  geom_line(aes(x = trainingset$YearsExperience, y = predict(lm.r, newdata = trainingset)), colour = 'blue') +  
  # Adds a regression line (based on the model predictions) over the training data points; the line is blue.
  ggtitle('Salary vs Experience (Training set)') +  
  # Adds a title to the plot.
  xlab('Years of experience') +  
  # Labels the x-axis as 'Years of experience'.
  ylab('Salary')  
  # Labels the y-axis as 'Salary'.

## Visualising the Test set results  
ggplot() +  
  geom_point(aes(x = testset$YearsExperience, y = testset$Salary), colour = 'red') +  
  # Plots the test data points with red color.
  geom_line(aes(x = trainingset$YearsExperience, y = predict(lm.r, newdata = trainingset)), colour = 'blue') +  
  # Plots the same regression line based on the training set model predictions.
  ggtitle('Salary vs Experience (Test set)') +  
  # Adds a title for the test set plot.
  xlab('Years of experience') +  
  # Labels the x-axis for the test set plot.
  ylab('Salary')  
  # Labels the y-axis for the test set plot.
