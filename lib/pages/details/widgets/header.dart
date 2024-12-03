import 'package:cashkeeper/utils/databasehelper.dart';
import 'package:cashkeeper/utils/globals.dart';
import 'package:cashkeeper/utils/libs/constants.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool isWeek = false;
  double _receitaMensal = 0.0;
  double _receitaSemanal = 0.0;

  @override
  void initState() 
  {
    super.initState();
    isWeek = isWeekSelected.value;

    isWeekSelected.addListener((){
      if(mounted){
        setState(() {
          isWeek = isWeekSelected.value;
        });
      }
    });

    carregarValores();
  }

  Future<void> carregarValores () async 
  {
    final DatabaseHelper db = DatabaseHelper();
    double receitaMensal = await db.obterValorMensal();
    double receitaSemanal = await db.obterValorSemanal();
    setState(() {
      _receitaMensal = receitaMensal;
      _receitaSemanal = receitaSemanal;
    });
   }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      color: AppColors.primaryColor,
      child: Stack(
        children: [
          // ClipPath para aplicar a curva na parte inferior
          ClipPath(
            clipper: BottomCurveClipper(),
            child: Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Conteúdo do Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 80.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage('assets/images/logo_white.png'),
                      width: 35,
                      height: 35,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "CashKeeper",
                      style: TextStyle(
                        fontSize: 25,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.primaryFont,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Círculo no fundo
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width / 2 - 100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.tertiaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: ValueListenableBuilder<bool>(
                  valueListenable: isWeekSelected,
                  builder: (context, value, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 25,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.primaryFont,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          value ? "Semana" : "Mês",
                          style: TextStyle(
                            fontSize: 25,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.primaryFont,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          value ? "€ $_receitaSemanal" : "€ $_receitaMensal",
                          style: TextStyle(
                            fontSize: 25,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.primaryFont,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(3 * size.width / 4, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
