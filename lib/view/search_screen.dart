import 'package:flutter/material.dart';
import 'package:project__weather/controller/controllers.dart/provider.dart';
import 'package:project__weather/controller/controllers.dart/search_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  String searchKey = "";
  @override
  void initState() {
    super.initState();
    searchController.addListener(_printLatestValue);
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    weatherProvider.fetchWeather();
  }

  void _printLatestValue() {
    final text = searchController.text;
    setState(() {
      searchKey = text;
    });
    Provider.of<SearchProvider>(context, listen: false).searchweather(
      searchKey.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber, width: 2),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search Location',
                        hintStyle: TextStyle(color: Colors.amber),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            searchKey.isNotEmpty
                ?

                /// searched location data
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Card(
                        color: Colors.amber,
                        child: Consumer<SearchProvider>(
                          builder: (context, searchProvider, _) {
                            final weather = searchProvider.weatherModel;
                            if (weather != null) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // City Name
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${weather.name}, ${weather.sys?.country ?? ""}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      'Latitude ${weather.coord!.lat.toString()},Longitude ${weather.coord!.lon.toString() ?? ""}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      // Cloud Image (if available)
                                      if (weather.weather != null &&
                                          weather.weather!.isNotEmpty)
                                        Image.network(
                                          'http://openweathermap.org/img/w/${weather.weather![0].icon}.png',
                                          width: 100,
                                          height: 100,
                                          color: Colors.black,
                                        ),
                                      // Temperature (if available)
                                      Text('${weather.main?.temp}°C',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 35)),
                                    ],
                                  ),
                                  Text(
                                    weather!.weather![0]!.description
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )
                                ],
                              );
                            } else {
                              // Placeholder when no weather data is available
                              return const Center(
                                  child: Text('No data available'));
                            }
                          },
                        ),
                      ),
                    ),
                  )
                :

                /// showing current location data
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Card(
                        color: Colors.amber,
                        child: Consumer<WeatherProvider>(
                          builder: (context, weatherProvider, _) {
                            final weather = weatherProvider.weather;
                            if (weather != null) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // City Name
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${weather.name}, ${weather.sys?.country ?? ""}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      'Latitude ${weather.coord!.lat.toString()},Longitude ${weather.coord!.lon.toString() ?? ""}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      // Cloud Image (if available)
                                      if (weather.weather != null &&
                                          weather.weather!.isNotEmpty)
                                        Image.network(
                                          'http://openweathermap.org/img/w/${weather.weather![0].icon}.png',
                                          width: 100,
                                          height: 100,
                                          color: Colors.black,
                                        ),
                                      // Temperature (if available)
                                      Text('${weather.main?.temp}°C',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 35)),
                                    ],
                                  ),
                                  Text(
                                    weather!.weather![0]!.description
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )
                                ],
                              );
                            } else {
                              // Placeholder when no weather data is available
                              return const Center(
                                  child: Text('No data available'));
                            }
                          },
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
