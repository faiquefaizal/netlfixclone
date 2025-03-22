import 'package:flutter/material.dart';
import 'package:netflixclone/screens/home_screen.dart';
import 'package:netflixclone/screens/new&hot.dart';
import 'package:netflixclone/screens/search.dart';

class BottomNavigatorBar extends StatelessWidget {
  const BottomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: Container(
            color: Colors.black,
            child: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: "Home",
                ),
                Tab(
                  icon: Icon(Icons.search),
                  text: "Search",
                ),
                Tab(
                  icon: Icon(Icons.home),
                  text: "New & Hot",
                )
              ],
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
            ),
          ),
          body:
              TabBarView(children: [HomeScreen(), SearchScreen(), Newandhot()]),
        ));
  }
}
