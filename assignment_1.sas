libname sasdata '/folders/myfolders/';
data factorydata;
	set sasdata.assignmentdata;
run;

/* list of variables and attributes */
proc contents data=factorydata;
run;

/* assess data manually */
proc print data=factorydata;
	id Hour Sensor PPM;
	by Site;
run;

/* report general statistics */
proc univariate data=factorydata;
	var PPM;
	histogram PPM/lognormal;
	qqplot PPM/lognormal(zeta=EST sigma=EST);
	ppplot PPM/lognormal;
run;

/* report statistics per site */
proc univariate data=factorydata;
	var PPM;
	histogram PPM/lognormal;
	qqplot PPM/lognormal(zeta=EST sigma=EST);
	ppplot PPM/lognormal;
	class Site;
run;