import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class NavigationPage extends StatefulWidget {
  const NavigationPage({required this.child,super.key});
  final Widget child;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  int calculateSelectedIndex(BuildContext context) {

    final String location = GoRouterState.of(context).uri.path;

    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/b')) {
      return 1;
    }
    if (location.startsWith('/c')) {
      return 2;
    }
    return 0;
  }
  void onTap(int index) {
    switch (index) {
      case 0:
        return context.go('/home');
      case 1:
        return context.go('/b');
      case 2:
        return context.go('/c');
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            label: 'Вторая',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            label: 'Третья',
          ),
        ],
        selectedItemColor: Colors.red,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedFontSize: 15.0,
        unselectedFontSize: 13.0,
        currentIndex: calculateSelectedIndex(context),
        onTap: (int idx) => onTap(idx),
      ),
      body: widget.child,
    );
  }
}
