import 'package:epilepsy_app/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';
import 'medication.dart';
import 'seizure_recorder.dart';
import 'settings_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Just hide the status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MainApp());
}

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData get themeData {
    return _isDarkMode ? _darkTheme : _lightTheme;
  }

  static final _lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: Colors.deepPurple,
      secondary: Colors.deepPurple.shade300,
      background: Colors.grey[50]!,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.grey[50],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          )
        ),
        elevation: MaterialStateProperty.all(3)
      )
    ),
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: Colors.deepPurple.shade100,
      labelTextStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
      ),
    ),
  );

  static final _darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: Colors.deepPurple,
      secondary: Colors.deepPurple.shade300,
      brightness: Brightness.dark,
      background: Colors.grey[900]!,
      surface: Colors.grey[850]!,
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      color: Colors.grey[850],
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: Colors.deepPurple.shade700,
      labelTextStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Epilepsy App",
            theme: themeProvider.themeData,
            home: const SplashScreen(),
          );
        },
      ),
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
      SeizureRecorder(onScreenChange: screenChanges),
      SettingsPage(onScreenChange: screenChanges),
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
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home'
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.medication_outlined)
            ),
            selectedIcon: Badge(
              label: Text(''),
              child: Icon(Icons.medication)
            ),
            label: 'Medication'
          ),
          NavigationDestination(
            icon: Icon(Icons.health_and_safety_outlined),
            selectedIcon: Icon(Icons.health_and_safety),
            label: 'Seizures'
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.settings_outlined)),
            selectedIcon: Badge(child: Icon(Icons.settings)),
            label: 'Settings'
          ),
        ],
      ),
    );
  }
}

class garafs {
  
}