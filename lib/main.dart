import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Leagues',
      theme: ThemeData(
        textTheme: const TextTheme(
            labelMedium: TextStyle(fontSize: 15, letterSpacing: 5),
            labelSmall: TextStyle(fontSize: 15, letterSpacing: 3)),
        cardTheme: CardTheme(
          elevation: 20,
          shadowColor: Color.fromARGB(255, 199, 211, 32),
          color: Color.fromARGB(255, 107, 11, 129),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          // RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(background: const Color.fromARGB(255, 4, 45, 68)),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Color.fromARGB(255, 241, 233, 166)),
          color: Color.fromARGB(255, 3, 25, 56),
          titleTextStyle: TextStyle(
              color: Color.fromARGB(255, 242, 225, 173),
              fontSize: 20,
              letterSpacing: 5),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color.fromARGB(255, 29, 2, 49),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 20, 47, 93),
          unselectedIconTheme: IconThemeData(
              size: 40, color: Color.fromARGB(255, 109, 130, 194)),
          selectedIconTheme: IconThemeData(
              size: 40, color: Color.fromARGB(255, 109, 130, 194)),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
