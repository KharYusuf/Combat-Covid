import 'package:flutter/material.dart';
import './my_flutter_app_icons.dart';

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
          icon: Icon(MyFlutterApp.mask),
          title: Text('Masks'),
        ),
        BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.disinfectant),
          title: Text('Hand Sanitizers'),
        ),
        BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.soap),
          title: Text('Soaps'),
        ),
      ],
    );
  }
}
