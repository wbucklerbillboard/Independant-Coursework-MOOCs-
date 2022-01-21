library(sparklyr)
library(dplyr)

# Configure spark session
sc <- spark_connect(
  master = 'local',
  app_name = 'quakes_etl'
)


# Load the dataset
df_load <- spark_read_csv(sc, name = "df_load", path = 'C:/Users/Will Buckler/Desktop/SWEFC/R_Data/database.csv',header = TRUE)
head(df_load)

# Create a subset of df_load
df_load_sub <- select(df_load, 'Date', 'Latitude', 'Longitude', 'Type', 'Depth', 'Magnitude', 'Magnitude_Type', 'ID')
# Preview df_load_sub
head(df_load_sub)

# Create a year field and add it to df_load_sub
df_load_sub <- df_load_sub %>%
  mutate(Year = year(to_date(Date, 'dd/MM/yyyy')))

# Preview df_load_sub
head(df_load_sub)

# Build the quakes frequency dataframe using the year field and counts for each year 
df_quake_freq <- df_load_sub %>%
  group_by(Year) %>%
  summarise(Count = n())
# Preview df_quake_freq
head(df_quake_freq)

# Create avg magnitude and max magnitude field and add to df_quake_freq
df_max <- df_load_sub %>%
  group_by(Year) %>%
  summarise(Max_Magnitude = max(Magnitude))
# Preview df_max
head(df_max)

df_avg <- df_load_sub %>%
  group_by(Year) %>%
  summarise(Avg_Magnitude = mean(Magnitude))
head(df_avg)

# Join df_max and df_avg to df_quake_freq
df_quake_freq <- left_join(df_quake_freq, df_max, by='Year')
df_quake_freq <- left_join(df_quake_freq, df_avg, by='Year')
# Preview df_quake_freq
head(df_quake_freq)

# Preview dfs
head(df_load_sub)
head(df_quake_freq)

# Write dfs to csv on FS
spark_write_csv(df_load_sub, path = 'C:/Users/Will Buckler/Desktop/SWEFC/DataPipe_R_Spark_Java/quakes', header = TRUE, delimiter = ',')
spark_write_csv(df_quake_freq, path = 'C:/Users/Will Buckler/Desktop/SWEFC/DataPipe_R_Spark_Java/quake_freq', header = TRUE, delimiter = ',')
