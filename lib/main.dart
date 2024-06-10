import 'package:flutter/material.dart';
import 'package:project__weather/controller/controllers/homeprovider.dart';
import 'package:project__weather/controller/controllers/searchprovider.dart';
import 'package:project__weather/view/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider())
      ],
      child: const MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
