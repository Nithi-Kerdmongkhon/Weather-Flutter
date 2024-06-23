import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week8/data_classes/weather_data/weather_data.dart';
import 'package:week8/search.dart';
import 'package:week8/util/open_weather.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<WeatherData> weatherData;
  @override
  void initState() {
    super.initState();
    weatherData = OpenWeather.fetchBycurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Report"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Center(
              child: FutureBuilder(
                  future: weatherData,
                  builder: ((context, AsyncSnapshot<WeatherData> snapshot) {
                    List<Widget> children = [];
                    if (snapshot.hasData) {
                      var iconID =
                          snapshot.data!.weather!.first.icon.toString();
                      children = [
                        Text(snapshot.data!.name.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                        Text(snapshot.data!.sys!.country.toString(),
                            style: const TextStyle(
                                color: Colors.white38,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Text(
                          DateFormat('yyyy-MM-dd').format(
                            DateTime.now().toUtc(),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                    imageUrl:
                                        'http://openweathermap.org/img/wn/$iconID@2x.png',
                                    progressIndicatorBuilder:
                                        (context, url, progress) => Center(
                                              child: CircularProgressIndicator(
                                                  value: progress.progress),
                                            )),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      (snapshot.data!.main!.temp! - 273.15)
                                          .toStringAsFixed(1),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "   ํC ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "MAX : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                      child: Text(
                                        (snapshot.data!.main!.tempMax! - 273.15)
                                            .toStringAsFixed(1),
                                        style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 1,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                                      child: Text(
                                        "MIN : ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                      child: Text(
                                        (snapshot.data!.main!.tempMin! - 273.15)
                                            .toStringAsFixed(1),
                                        style: const TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                    snapshot.data!.weather!.first.description
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.pinkAccent,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),

                        // Text(snapshot.data.toString()),
                      ];
                    } else if (snapshot.hasError) {
                      children.add(const Center(
                        child: Icon(
                          Icons.error,
                          size: 80,
                          color: Colors.red,
                        ),
                      ));
                      children.add(const Text('SORRY!!!'));
                      children.add(const Text('AREA NOT FOUND'));
                    } else {
                      children.add(const Text('Waiting....'));
                    }
                    return Column(
                      children: children,
                    );
                  })),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextButton(
                      onPressed: () async {
                        var cityName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Search()),
                        );
                        if (cityName != null) {
                          weatherData =
                              OpenWeather.fetchByCityName(cityName: cityName);
                          setState(() {});
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: const Color(0xffeb1555)),
                      child: const Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
