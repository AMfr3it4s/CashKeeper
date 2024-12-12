import 'package:cashkeeper/utils/libs/constants.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 128,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 46.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Logo
                    Image(
                      image: AssetImage('assets/images/logo_dark.png'),
                      width: 35,
                      height: 35,
                    ),
                    const SizedBox(width: 10),
                    // Título
                    Text(
                      "CashKeeper",
                      style: TextStyle(
                        fontSize: 25,
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.primaryFont,
                      ),
                    ),
                    // Espaço flexível
                    Spacer(),
                    // Ícone à direita
                    Icon(Icons.apple_rounded, color: AppColors.secondaryColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
