import 'package:flutter/material.dart';
import 'package:project__weather/controller/controllers.dart/provider.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    print('Inside initstate');

    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    weatherProvider.fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    print(weatherProvider.weather);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Consumer<WeatherProvider>(builder: (context, weatherProvider, _) {
        final weather = weatherProvider.weather;
        if (weatherProvider.isloading == false ||
            weatherProvider.weather != null) {
          return ListView(
            shrinkWrap: true,
            children: [
              /// City and Country Name
              Center(
                child: Text(
                  '${weather!.name}, ${weather!.sys!.country}',
                  style: const TextStyle(fontSize: 25, color: Colors.amber),
                ),
              ),
              Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    weatherProvider.lat.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    weatherProvider.lon.toString(),
                    style: const TextStyle(color: Colors.white),
                  )
                ]),
              ),

              /// Clouds
              Center(
                child: Text(
                  weather!.weather![0].main.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // CLouds Image
                  AnimatedOpacity(
                    duration: const Duration(seconds: 1),
                    opacity: 1,
                    child: Image.network(
                      'http://openweathermap.org/img/w/${weather!.weather![0].icon}.png',
                      width: 50,
                      height: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  // Temperature
                  Text(
                    '${weather!.main!.temp}°C',
                    style: const TextStyle(fontSize: 45, color: Colors.amber),
                  ),
                ],
              ),
              // Description
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    ' ${weather!.weather![0].description!.toUpperCase()}',
                    style: const TextStyle(fontSize: 15, color: Colors.amber),
                  ),
                ),
              ),

              /// Humidity
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Humidity',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.water_drop_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Center(
                        child: Text(
                          '${weather!.main!.humidity.toString()}%',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.amber),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Pressure
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pressure',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.timer,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Center(
                        child: Text(
                          '${weather!.main!.pressure.toString()} hPa',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.amber),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Maximum Temperature
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'MaxTemp',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.thermostat,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Text(
                        '${weather!.main!.tempMax.toString()}°C',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.amber),
                      ),
                    ],
                  ),
                ),
              ),

              /// Minimum Temperature
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'MinTemp',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.thermostat,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Text(
                        '${weather!.main!.tempMin.toString()}°C',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.amber),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          );
        } else if (weatherProvider.isloading == true) {
          return Center(
            child: Column(
              children: [
                Container(
                  height: 150,
                  color: Colors.black,
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Loading data',
                      style: TextStyle(fontSize: 24, color: Colors.amber),
                    ),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (weatherProvider.error.isNotEmpty) {
          return Center(
            child: Text(
              weatherProvider.error,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        } else {
          return Center(child: Text(''));
        }
      }),
    );
  }
}
