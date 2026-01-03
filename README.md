 Ames Housing Price Analysis (SAS)

Overview
This project analyzes residential housing data from Ames, Iowa to identify the key drivers of home sale prices and quantify how neighborhood context changes the value of property features. The goal is to translate statistical results into actionable insights that support pricing, valuation, and investment decisions.

Business Problem
Home prices vary widely even for similar properties. Real estate professionals, investors, and analysts need to understand:
- Which property features most strongly influence sale price
- Whether the value of these features changes by neighborhood
- How to price or renovate homes more strategically based on location

Data
- Source: Ames Housing Dataset
- Observations: 2,900+ residential properties
- Key variables: Sale Price, Living Area, Overall Quality, Neighborhood, Lot Size, Year Built

Tools & Methods
- SAS (Base SAS)
- PROC CORR – correlation analysis
- PROC TTEST – group comparisons
- PROC GLM – regression and moderation analysis
- PROC LOGISTIC – categorical outcome modeling
- Data cleaning, feature selection, and model diagnostics

Key Insights
- Living area has a strong positive relationship with sale price (correlation ≈ 0.71)
- Overall quality is one of the strongest predictors of price across all models
- Neighborhood significantly moderates the effect of living area on price
- In high-value neighborhoods, additional square footage yields substantially higher returns
- Renovation quality improvements often outperform lot size increases in price impact

Business Impact
- Supports neighborhood-specific pricing strategies
- Helps investors prioritize renovation decisions with higher ROI
- Enables more accurate valuation models for real estate analytics
- Demonstrates how statistical modeling informs real-world business decisions

Repository Structure
- /code – SAS programs used for analysis
- /docs – Executive summary and presentation materials
- /appendix – Full statistical output for reference

Author:
Hamza Rabiu  
MS Management Information Systems (Data & Analytics)  
Northern Illinois University
