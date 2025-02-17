import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        bottom: true,
        child: Scaffold(
          backgroundColor: Colors.purple,
          bottomNavigationBar: CustomBottomNavBar(),
          body: Consumer<NavigationProvider>(
            builder: (context, provider, child) {
              return Center(
                child: Text(
                  provider.getCurrentScreen(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, "Home", 0, provider),
              _buildNavItem(Icons.favorite_border, "Favs", 1, provider),
              _buildNavItem(Icons.search, "Search", 2, provider),
              _buildNavItem(Icons.person, "Profile", 3, provider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    int index,
    NavigationProvider provider,
  ) {
    bool isSelected = provider.selectedIndex == index;
    return GestureDetector(
      onTap: () => provider.changeIndex(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? Colors.purple : Colors.black54),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.purple : Colors.black54,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationProvider extends ChangeNotifier {
  int selectedIndex = 0;
  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  String getCurrentScreen() {
    switch (selectedIndex) {
      case 0:
        return "Home";
      case 1:
        return "Favs";
      case 2:
        return "Search";
      case 3:
        return "Profile";
      default:
        return "Home";
    }
  }
}
