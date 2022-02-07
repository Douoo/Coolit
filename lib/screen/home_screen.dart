import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:coolet/services/weather.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

import 'main_screen.dart';

class HomePage extends StatefulWidget {
  static const String route = 'home';
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int? temprature;
  int? feelAlikeTemp;
  int? condition;
  String? cityName;
  String? weatherIcon;
  String? weatherMsg;
  String? conditionMain;
  String? conditionDescription;
  String? iconCode;
  DateTime now = DateTime.now();
  String? currentTime;
  String? currentDate;

  WeatherModel weather = WeatherModel();

  void updateUI(var weatherData) {
    temprature = weatherData['main']['temp'].toInt();
    double feelTemp = weatherData['main']['feels_like'];
    feelAlikeTemp = feelTemp.toInt();
    condition = weatherData['weather'][0]['id'];
    cityName = weatherData['name'];
    conditionMain = weatherData['weather'][0]['main'];
    conditionDescription = weatherData['weather'][0]['description'];
    iconCode = weatherData['weather'][0]['icon'];
    weatherIcon = weather.getWeatherIcon(condition!);
    weatherMsg = weather.getMessage(temprature!);
    currentTime = DateFormat('kk:mm a').format(now);
    currentDate = DateFormat('EEE d MMM').format(now);
  }
  Future getLocationData() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Text('Service is not enabled :(');
    }
  }

    @override
  void initState() {
    updateUI(widget.weatherData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "$currentDate",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: 200,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 30,
                          height: 10,
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Text(
                            'About',
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Text(
                                'Coolet is a simple app that will notify you with the live weather data of your local area and give you simple suggestions on what to wear/do'),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyText2,
                              children: [
                                TextSpan(text: "Made with love ❤️ in Ethiopia")
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icon(
              Icons.info_outline,
              color: Theme.of(context).primaryColor,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () async {
              //Navigate to the search page
              var searchData =
                  await showSearch(context: context, delegate: CitySearch());
              if (searchData != null) {
                var weatherData = await weather.getCityWeather(searchData);
                setState(() {
                  updateUI(weatherData);
                });
              }
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("$currentTime", style: TextStyle(fontSize: 16)),
            Text("$cityName", style: TextStyle(fontSize: 18)),
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: CachedNetworkImage(
                  imageUrl:
                      "http://openweathermap.org/img/wn/$iconCode@4x.png"),
            ),
            Row(
              children: [
                Expanded(
                    child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    children: [
                      TextSpan(
                          text: "$temprature°C\n",
                          style: Theme.of(context).textTheme.headline1),
                      TextSpan(text: "Feels like $feelAlikeTemp°C")
                    ],
                  ),
                )),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText1,
                      children: [
                        TextSpan(
                            text: "$conditionMain\n",
                            style: Theme.of(context).textTheme.headline2),
                        TextSpan(text: "$conditionDescription")
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: const Divider()),
            Row(
              children: [
                // Expanded(child: Text("Wearable", textAlign: TextAlign.center)),
                Expanded(
                    child: Text("$weatherMsg\n(suggestion)",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1))
              ],
            ),
            const Divider(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CitySearch extends SearchDelegate<String> {
  final recentCities = ["Addis Ababa"];
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              // close(context, null);
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, ''),
      );

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_city, size: 100),
            const SizedBox(height: 40),
            Text(
              query,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentCities
        : cities.where((city) {
            final cityLower = city.toLowerCase();
            final queryLower = query.toLowerCase();

            return cityLower.startsWith(queryLower);
          }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        final queryText = suggestion.substring(0, query.length);
        final remainingText = suggestion.substring(query.length);

        return ListTile(
          onTap: () {
            query = suggestion;
            close(context, suggestion);
          },
          leading: Icon(Icons.location_city),
          title: RichText(
            text: TextSpan(
              text: queryText,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: [
                TextSpan(
                    text: remainingText,
                    style: TextStyle(color: Colors.grey, fontSize: 18))
              ],
            ),
          ),
        );
      });
}
