import 'package:flutter/material.dart';
import 'package:weather_app/views/home_view.dart';
import 'package:weather_app/views/info_view.dart';
import 'package:weather_app/views/autors_view.dart';
import 'package:weather_app/utils/custom_colors.dart';
class Material3BottomNav extends StatefulWidget {
  const Material3BottomNav({Key? key}) : super(key: key);

  @override
  State<Material3BottomNav> createState() => _Material3BottomNavState();
}

class _Material3BottomNavState extends State<Material3BottomNav> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomeView(),
    InfoView(),
    AuthorsView()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Eco Clima Tracker'), backgroundColor: CustomColors.secondGradientColor),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(

        animationDuration: const Duration(seconds: 1),
        selectedIndex: _selectedIndex,
        backgroundColor: Colors.white,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: _navBarItems,
      ),
    );
  }
}

const _navBarItems = [
  NavigationDestination(
    icon: Icon(Icons.home_outlined),
    selectedIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  NavigationDestination(
    icon: Icon(Icons.info_outline_rounded),
    selectedIcon: Icon(Icons.info_rounded),
    label: 'Acerca de',
  ),
  NavigationDestination(
    icon: Icon(Icons.group_outlined),
    selectedIcon: Icon(Icons.group),
    label: 'Creado por',
  ),
];

