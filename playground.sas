libname sasdata '/folders/myfolders/';
data mydata;
	set sasdata.assignmentdata;
run;

/* describe variables in data set */
proc contents data=mydata;
run;

/* print data in RESULT window */
proc print data=mydata;
	id Hour Sensor PPM; 		/* order to print variables */
	by Site; 					/* produces a separate report for each Site */
run;

/* sort observation on PPM */
proc sort data=mydata out=mydata;
	by PPM;
run;

proc print data=mydata;
	id Site Hour Sensor PPM;
run; 

/* report general statistics manually */
proc means data=mydata n mean std min max 
	range var sum stderr 
	mode median p50 q3 p75 
	lclm uclm					/* lower, upper confidence interval */
	skewness kurtosis kurt
	nmiss; 						/* number of missing values */
	var PPM;					/* var identifies the analysis variable(s) */
	class Site;					/* produce analysis for subgroup Site */
/* 	output out=work.name; */
run;

/* report general statistics automatically */
proc univariate data=mydata;
	var PPM;
run;

proc univariate data=mydata;
	var PPM;
	histogram PPM/normal;
	qqplot PPM/normal;
	ppplot PPM/normal;
run;

/* computes goodness-of-fit for normal distribution */
proc univariate data=mydata normal;
	var PPM;
run;

/* test operators */
data subdata;
	set sasdata.assignmentdata;
	where Site ^= 'Site4'; 		/* selects observations that satisfy condition */
	if PPM < 15					
		then delete;			/* statement excludes observation */
	else newPPM=PPM**2;
run;

/* keep statement */
data subset1;
	set sasdata.assignmentdata;
	keep Site PPM;
run;

/* drop statement */
data subset2;
	set sasdata.assignmentdata;
	drop Sensor;
run;

