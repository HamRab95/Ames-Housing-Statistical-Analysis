/******************************************************************************************
   AMES HOUSING
******************************************************************************************/

/* Data preparation – convert character vars to numeric where needed */
data work.ames;
   set work.ames_raw;
   
   LogPrice = log(price);
   
   if Neighborhood in ('NoRidge', 'NridgHt') then NorthridgeGroup = 1;
   else NorthridgeGroup = 0;
   
   /* Convert character to numeric for model vars */
   TotalBsmtSF_num = input('Total.Bsmt.SF'n, best32.);
   GarageCars_num = input('Garage.Cars'n, best32.);
   
   label 
      price = 'Sale Price (USD)'
      LogPrice = 'Log(Sale Price)'
      area = 'Above-Ground Living Area (sq ft)'
      'Overall.Qual'n = 'Overall Quality (1-10)'
      'Lot.Area'n = 'Lot Area (sq ft)'
      'Year.Built'n = 'Year Built'
      NorthridgeGroup = '1 = NoRidge/NridgHt, 0 = Other'
      TotalBsmtSF_num = 'Total Basement SF (numeric)'
      GarageCars_num = 'Garage Cars (numeric)';
run;

/* RQ1: One-sample t-test */
title 'RQ1: Is mean area significantly different from 1,500 sq ft?';
proc ttest data=work.ames h0=1500 alpha=0.05 sides=2;
   var area;
run;

/* RQ2: Two-sample t-test */
title 'RQ2: Do homes in NoRidge/NridgHt have higher sale prices?';
proc ttest data=work.ames;
   class NorthridgeGroup;
   var LogPrice;
run;

/* RQ3: One-way ANOVA */
title 'RQ3: Effect of Overall Quality on Sale Price';
proc glm data=work.ames;
   class 'Overall.Qual'n;
   model LogPrice = 'Overall.Qual'n / solution;
   means 'Overall.Qual'n / tukey cldiff alpha=0.05;
run;
quit;

/* RQ4: Correlations */
title 'RQ4: Correlations among key variables';
proc corr data=work.ames nosimple;
   var price area 'Lot.Area'n 'Year.Built'n;
run;

/* RQ5: Multiple regression with moderation – use numeric vars */
title 'RQ5: Multiple Regression + Moderation';
proc glm data=work.ames;
   class NorthridgeGroup;
   model LogPrice = area 'Overall.Qual'n TotalBsmtSF_num GarageCars_num 'Full.Bath'n 
                    'Year.Remod.Add'n NorthridgeGroup area*NorthridgeGroup
                    / solution clparm;
   lsmeans NorthridgeGroup / at area=1500;
run;
quit;

/* Interaction plot */
title 'Moderation Effect: Area × Neighborhood Prestige';
proc sgplot data=work.ames;
   reg x=area y=LogPrice / group=NorthridgeGroup clm cli lineattrs=(thickness=3);
   xaxis label='Above-Ground Living Area (sq ft)';
   yaxis label='Log(Sale Price)';
   keylegend / title='1 = Prestige Neighborhood';
run;

/* Export to PDF */
ods pdf file='/home/u63855294/Ames_Housing_Results.pdf' style=journal pdftoc=1;
ods noproctitle;

proc means data=work.ames n mean std min max;
   var price LogPrice area 'Overall.Qual'n;
   title 'Descriptive Statistics';
run;

title 'RQ1: One-sample t-test';
proc ttest data=work.ames h0=1500; var area; run;

title 'RQ2: Northridge vs Other Neighborhoods';
proc ttest data=work.ames; class NorthridgeGroup; var LogPrice; run;

title 'RQ3: ANOVA by Overall Quality';
proc glm data=work.ames; 
   class 'Overall.Qual'n; 
   model LogPrice = 'Overall.Qual'n; 
   means 'Overall.Qual'n / tukey; 
run; quit;

title 'RQ4: Correlation Matrix';
proc corr data=work.ames; var price area 'Lot.Area'n 'Year.Built'n; run;

title 'RQ5: Final Regression with Interaction';
proc glm data=work.ames;
   class NorthridgeGroup;
   model LogPrice = area 'Overall.Qual'n TotalBsmtSF_num GarageCars_num NorthridgeGroup area*NorthridgeGroup;
run; quit;

title 'Interaction Plot';
proc sgplot data=work.ames;
   reg x=area y=LogPrice / group=NorthridgeGroup;
run;

ods pdf close;

data _null_;
   put '=================================================================';
   put 'PDF saved: /home/u63855294/Ames_Housing_Results.pdf';
   put '=================================================================';
run;