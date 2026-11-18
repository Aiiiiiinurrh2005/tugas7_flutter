import 'package:flutter/material.dart';
import 'pages/dashboard_page.dart';
import 'pages/practice_list_page.dart';
import 'pages/about_page.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StateManagementDemoApp());
}

/// Root widget aplikasi
class StateManagementDemoApp extends StatelessWidget {
  const StateManagementDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigationScreen(),
    );
  }
}

/// Container utama dengan BottomNavigationBar 3 Menu:
/// 1. Home (DashboardPage)
/// 2. Praktik (PracticeListPage)
/// 3. Tentang (AboutPage)
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  // Index tab yang sedang aktif
  int _currentIndex = 0;

  // Daftar halaman navigasi
  final List<Widget> _pages = const [
    DashboardPage(),
    PracticeListPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code_outlined),
            activeIcon: Icon(Icons.code_rounded),
            label: 'Praktik',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline_rounded),
            activeIcon: Icon(Icons.info_rounded),
            label: 'Tentang',
          ),
        ],
      ),
    );
  }
}
