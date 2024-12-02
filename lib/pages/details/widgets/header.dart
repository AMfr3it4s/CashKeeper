import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 400,
      child: Stack(
        children: [
          // ClipPath para aplicar a curva na parte inferior
          ClipPath(
            clipper: BottomCurveClipper(),
            child: Container(
              width: double.infinity,  // Garantir largura total
              height: 350,  // Definir a altura que corresponde ao SizedBox
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
                    // Logo
                    Image(
                      image: AssetImage('assets/images/logo_white.png'),
                      width: 35,
                      height: 35,
                    ),
                    const SizedBox(width: 10),
                    // Título
                    Text(
                      "CashKeeper",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Parkinsans',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Círculo no fundo
          Positioned(
            bottom: -0,  
            left: MediaQuery.of(context).size.width / 2 - 100,  // Alinha o círculo horizontalmente
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xff00dda3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Parkinsans',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Semana",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Parkinsans',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "€ 300",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Parkinsans',
                      ),
                    ),
                  ],
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
    path.lineTo(0, 0); // Início do caminho (topo esquerdo)
    path.lineTo(0, size.height - 80); // Linha até o final do lado esquerdo, com a curva para baixo
    path.quadraticBezierTo(
        size.width / 4, size.height, // Curva suave para baixo à esquerda
        size.width / 2, size.height); // Curva suave para baixo à direita
    path.quadraticBezierTo(
        3 * size.width / 4, size.height, // Curva suave para baixo à direita
        size.width, size.height - 80); // Linha até o final do lado direito
    path.lineTo(size.width, 0); // Linha até o topo direito
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
