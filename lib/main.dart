import 'package:epilepsy_app/splash.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'medication.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Epilepsy App",
      theme: ThemeData(
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: const WidgetStatePropertyAll(Colors.tealAccent),shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),elevation: const WidgetStatePropertyAll(3))) // For background
      ),
      home: const SharedUI(),
    );
  }
}

class SharedUI extends StatefulWidget {
  const SharedUI({super.key});

  @override
  State<SharedUI> createState() => _SharedUIState();
}

class _SharedUIState extends State<SharedUI> {
  int currentpageindex = 0;
  final List _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      HomePage(onScreenChange: screenChanges), // Passing screen change callback
      MedicationReminder(onScreenChange: screenChanges),
    ]);
  }

  screenChanges(int index){
    setState(() {
      currentpageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentpageindex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentpageindex,
        onDestinationSelected: screenChanges,
        indicatorColor: const Color.fromRGBO(255, 193, 7, 1),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Badge(label: Text('4') ,child: Icon(Icons.medication)), label: 'Medication'),
          NavigationDestination(icon: Icon(Icons.health_and_safety), label: 'Seizures'),
          NavigationDestination(icon: Badge(child: Icon(Icons.settings)), label: 'Settings'),
          
        ],
      ),
    );
  }
}

class garafs {
  
}