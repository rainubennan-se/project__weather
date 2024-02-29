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
    // print(weatherProvider.weather);
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    // final now = DateTime.now();
    // bool isloading = true;
    // final formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(now);
    print(weatherProvider.weather);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          if (weatherProvider.weather != null)
            ListView(
              shrinkWrap: true,
              children: [
                /// City and Country Name
                Center(
                  child: Text(
                    '${weatherProvider.weather!.name}, ${weatherProvider.weather!.sys!.country}',
                    style: const TextStyle(fontSize: 25, color: Colors.amber),
                  ),
                ),

                /// Clouds
                Center(
                  child: Text(
                    weatherProvider.weather!.weather![0].main.toString(),
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
                        'http://openweathermap.org/img/w/${weatherProvider.weather!.weather![0].icon}.png',
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
                      '${weatherProvider.weather!.main!.temp}°C',
                      style: const TextStyle(fontSize: 45, color: Colors.amber),
                    ),
                  ],
                ),
                // Description
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      ' ${weatherProvider.weather!.weather![0].description!.toUpperCase()}',
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
                            '${weatherProvider.weather!.main!.humidity.toString()}%',
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
                            '${weatherProvider.weather!.main!.pressure.toString()} hPa',
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
                          '${weatherProvider.weather!.main!.tempMax.toString()}°C',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.amber),
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
                          '${weatherProvider.weather!.main!.tempMin.toString()}°C',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          if (weatherProvider.weather == null)
            const Text(
              'No weather data',
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
        ],
      ),
    );
  }
}
