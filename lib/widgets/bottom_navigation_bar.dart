import 'package:flutter/material.dart';
import '../constants/my_flutter_app_icons.dart';

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
          label: 'Masks',
        ),
        BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.disinfectant),
          label: 'Hand Sanitizers',
        ),
        BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.soap),
          label: 'Soaps',
        ),
      ],
    );
  }
}
