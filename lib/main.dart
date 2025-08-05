import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/view_models/favourites_view_model.dart';
import 'package:movies_app/view_models/home_view_model.dart';
import 'package:movies_app/views/favorites_page.dart';
import 'package:movies_app/views/now_playing_page.dart';
import 'dart:io';

import 'package:movies_app/views/trending_page.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider<FavouritesViewModel>(
          create: (context) => FavouritesViewModel()
        )
        
      ],
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Movies App', 
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: MyHomePage(),
      );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = TrendingPage();
        break;
      case 1: 
        page = NowPlayingPage();
        break;
      case 2:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError("no widget for ${selectedIndex}");
    }

    return Scaffold(
      body: Column (
        children: [
          AppBar(
            title: Text(
              'Movies App',
            ),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          Expanded(child: page),
          Container(
            // margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            color:Theme.of(context).colorScheme.secondaryContainer,
            child: NavigationBar(
              // height: 25,
              height: 55,
              destinations: [
                NavigationDestination(
                  label: 'Trending',
                  icon: Icon(
                    selectedIndex == 0 ? Icons.trending_up : Icons.trending_up_outlined
                  ),
                  tooltip: 'Trending',
                ),
                NavigationDestination(
                  label: 'Now Playing',
                  icon: Icon(
                    selectedIndex == 1 ? Icons.theaters : Icons.theaters_outlined
                  ),
                  tooltip: 'Now Playing',
                ),
                NavigationDestination(
                  label: 'Favorites',
                  icon: Icon(
                    selectedIndex == 2 ? Icons.favorite : Icons.favorite_border_outlined
                  ),
                  tooltip: 'Favorites',
                ),
              ],
              onDestinationSelected: (value) => {
                setState(() {
                  print("selected PAge ${value}");
                  selectedIndex = value;
                })
              },
            ),
          )
        ]
      )
    );
    }
}