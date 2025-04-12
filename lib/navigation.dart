import 'package:digital_product_passport/src/library/presentation/libraray_screen.dart';
import 'package:digital_product_passport/src/scan/presentation/scan_screen.dart';
import 'package:digital_product_passport/src/settings/presentation/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;

  void _setUiStyle() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Update the system UI based on the current brightness
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
        systemStatusBarContrastEnforced: false,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Apply "modern" look
    _setUiStyle();

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.qr_code),
            icon: Icon(Icons.qr_code_outlined),
            label: 'Scan',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.library_books),
            icon: Icon(Icons.library_books_outlined),
            label: 'Library',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        // Add SafeArea around screens if content overlaps system's status bar
        ScanScreen(),
        LibrarayScreen(),
        SettingsScreen(),
      ][currentPageIndex],
    );
  }
}
