import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém a rota atual
    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    return Container(
      width: double.infinity,
      height: 90,
      color: Color(0xFF33404f),
      child: IconTheme(
        data: const IconThemeData(
          color: Color(0xfff8f8f8), //Normal Color
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: Icon(
                Icons.home_work_rounded,
                size: 30,
                color: currentRoute == '/' ? Color(0xff00dda3) : Color(0xfff8f8f8),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/details');
              },
              child: Icon(
                Icons.menu_book_rounded,
                size: 30,
                color: currentRoute == '/details' ? Color(0xff00dda3) : Color(0xfff8f8f8),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed('/random');
              },
              child: Icon(
                Icons.app_registration_outlined,
                size: 30,
                color: currentRoute == '/random' ? Color(0xff00dda3) : Color(0xfff8f8f8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
