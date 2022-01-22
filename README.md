# Independant-Coursework-MOOCs-
These files were the result of "Building Big Data Pipelines with R &amp; Sparklyr &amp; PowerBI".  The product is EarthquakeVis.

Originally, processing occurred through the R library, Sparklyr.  The library was buttressed by the particular installation sequence of Java, & Apache Spark.  
I learned a great deal on how differing versions of such installations can interfere with software functioning.  Rather than interpret the course as broken, working with
differing software installation versions was a value-added moment.  These version conflicts prevented me from performing the final crucial step, the loading step 
in ETL (https://stackoverflow.com/questions/67775916/spark-write-csv-doesnt-work-anymore-with-sparklyr)

As an alternative, I used Pandas as a work around.  I referred to Lesson 6 in Geo-Python 2021.  After succeeding through Pandas, I loaded the two .csv files into Power BI.
The final third .csv file, predicted results, was produced in a separate MOOC (SpaDataVisML_Quakes).  The predicted results file was also loaded into Power BI.
