 /$$$$$$$$ /$$$$$$  /$$   /$$ /$$$$$$ /$$$$$$$   /$$$$$$  /$$$$$$$$ /$$$$$$ 
|__  $$__//$$__  $$| $$  / $$|_  $$_/| $$__  $$ /$$__  $$|__  $$__//$$__  $$
   | $$  | $$  \ $$|  $$/ $$/  | $$  | $$  \ $$| $$  \ $$   | $$  | $$  \ $$
   | $$  | $$$$$$$$ \  $$$$/   | $$  | $$  | $$| $$$$$$$$   | $$  | $$$$$$$$
   | $$  | $$__  $$  >$$  $$   | $$  | $$  | $$| $$__  $$   | $$  | $$__  $$
   | $$  | $$  | $$ /$$/\  $$  | $$  | $$  | $$| $$  | $$   | $$  | $$  | $$
   | $$  | $$  | $$| $$  \ $$ /$$$$$$| $$$$$$$/| $$  | $$   | $$  | $$  | $$
   |__/  |__/  |__/|__/  |__/|______/|_______/ |__/  |__/   |__/  |__/  |__/  
 
  
by Charlie Hack  
  
Here are a few utilities, scripts and queries I made while examining the NYC Taxi data set
with BigQuery.  

* `preprocess.py`  
This script can be tweaked to format geodata for use with OpenHeatMap.

* `taxidata.sql`  
A few GQL queries that were used for the article in SuperCompressor.

* `taxidata.ipynb`  
A basic visual exploration of the data, and a few plots. Run `ipython notebook --pylab inline`
to display the plots right inline with the notebook.

The data is BigQuery'd up and ready to go [here](https://bigquery.cloud.google.com/table/833682135931:nyctaxi.trip_data).

