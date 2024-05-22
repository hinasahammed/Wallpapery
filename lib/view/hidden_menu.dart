import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:wallpapery/view/collection.dart';
import 'package:wallpapery/view/home.dart';
import 'package:wallpapery/view/search.dart';

class HiddenMenu extends StatefulWidget {
  const HiddenMenu({super.key});

  @override
  State<HiddenMenu> createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> {
  List<ScreenHiddenDrawer> itens = [];

  @override
  void initState() {
    super.initState();
    itens.add(
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          selectedStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          name: "🏠 Home",
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.deepPurple,
        ),
        const HomeView(),
      ),
    );

    itens.add(
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          selectedStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          name: "🔍 Search",
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.deepPurple,
        ),
        const Search(),
      ),
      
    );
     itens.add(
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          selectedStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          name: "💼 Collection",
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.deepPurple,
        ),
        const CollectionView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return HiddenDrawerMenu(
      backgroundColorMenu: theme.colorScheme.surface,
      backgroundColorAppBar: theme.appBarTheme.backgroundColor,
      screens: itens,
      slidePercent: 70.0,
      contentCornerRadius: 20.0,
    );
  }
}
