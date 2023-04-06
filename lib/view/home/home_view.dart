import 'package:flutter/material.dart';
import 'package:tmdb_movie/utils/theme/app_colors.dart';

import 'package:tmdb_movie/view/latest/latest_movies.dart';
import 'package:tmdb_movie/view/popular/popular_movies.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    PopularMovies(),
    LatestMovies(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Poplular',
            backgroundColor: AppColors.primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Latest',
            backgroundColor: AppColors.primaryColor,
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        unselectedFontSize: 14,
        onTap: _onItemTapped,
        elevation: 5,
      ),
    );
  }
}
