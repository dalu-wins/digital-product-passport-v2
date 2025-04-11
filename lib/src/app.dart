import 'package:digital_product_passport/navigation.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap MaterialApp with a DynamicColorBuilder.
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          // Otherwise, use fallback schemes.
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 195, 254),
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 195, 254),
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
            colorScheme: darkColorScheme,
          ),
          home: const Navigation(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
