import pandas as pd 

data = pd.read_csv("data/weather_year.csv")

data

data["EDT"]

data[["EDT", "Mean TemperatureF"]]


data.columns = ["date", "max_temp", "mean_temp", "min_temp", "max_dew",
                "mean_dew", "min_dew", "max_humidity", "mean_humidity",
                "min_humidity", "max_pressure", "mean_pressure",
                "min_pressure", "max_visibilty", "mean_visibility",
                "min_visibility", "max_wind", "mean_wind", "min_wind",
                "precipitation", "cloud_cover", "events", "wind_dir"]

data

data.mean_temp.head()
data.mean_temp.std()

data.mean_temp.hist()

dataframe.columns
dataframe = dataframe.columns.rename({'a':'b'})

data.std()

first_date = data.date.values[0]
first_date

from datetime import datetime
datetime.strptime(first_date, "%Y-%m-%d")

datetime.datetime(2012, 3, 10, 0, 0)

data.date = data.date.apply(lambda d: datetime.strptime(d, "%Y-%m-%d"))
data.date.head()

data.index = data.date
data


data = data.drop(["date"], axis=1)
data.columns



empty = data.apply(lambda col: pd.isnull(col))
empty

empty.events.head(10)



data.dropna(subset=["events"])

data.events = data.events.fillna("NA")
data.events.head(10)  
data.irow(0)
data.ix[datetime(2013, 1, 1)]

num_rain = 0
for idx, row in data.iterrows():
    if "Rain" in row["events"]:
        num_rain += 1

"Days with rain: {0}".format(num_rain)
  

  freezing_days = data[data.max_temp <= 32]
freezing_days

data[(data.max_temp <= 32) & (data.min_temp >= 20)]

temp_max = data.max_temp <= 32
type(temp_max)
temp_max

temp_min = data.min_temp >= 20
temp_min

temp_min & temp_max

temp_both = temp_min & temp_max
temp_both.any()


data[data.events.apply(lambda e: "Rain" in e)]

cover_temps = {}
for cover, cover_data in data.groupby("cloud_cover"):
    cover_temps[cover] = cover_data.mean_temp.mean()  # The mean mean temp!
cover_temps 

for (cover, events), group_data in data.groupby(["cloud_cover", "events"]):
    print "Cover: {0}, Events: {1}, Count: {2}".format(cover, events, len(group_data))

data.events.unique()


for event_kind in ["Rain", "Thunderstorm", "Fog", "Snow"]:
    col_name = event_kind.lower()  # Turn "Rain" into "rain", etc.
    data[col_name] = data.events.apply(lambda e: event_kind in e)
data

data.rain


data[data.rain & data.snow]
data.max_temp.plot()


data.max_temp.tail().plot()



data.max_temp.tail().plot(kind="bar", rot=10)

ax = data.max_temp.plot(title="Min and Max Temperatures")
data.min_temp.plot(style="red", ax=ax)
ax.set_ylabel("Temperature (F)")    