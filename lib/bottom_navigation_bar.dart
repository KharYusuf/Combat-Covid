import 'package:flutter/material.dart';

class BottomTabs extends StatelessWidget {
  final int _currentPageIndex;
  final Function _setSelectedPage;
  BottomTabs(this._currentPageIndex, this._setSelectedPage);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentPageIndex,
      type: BottomNavigationBarType.shifting,
      onTap: _setSelectedPage,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.adb),
          title: Text('Masks'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.adb),
          title: Text('Hand Sanitizers'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.adb),
          title: Text('Soaps'),
        ),
      ],
    );
  }
}
