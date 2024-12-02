import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AppHeader extends StatefulWidget {
  const AppHeader({super.key});

  @override
  _AppHeaderState createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  bool _isTabOpen = false; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 370,
      child: Stack(
        children: [
          // Fundo com a imagem
          ClipPath(
            clipper: BottomCurveClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Overlay
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40.0),
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
                    // Espaço flexível
                    Spacer(),
                    // Ícone à direita
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isTabOpen = !_isTabOpen; // Alterna o estado da tab
                        });
                      },
                      icon: Icon(Icons.menu_rounded),
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Olá, Junior!",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 40,
                      fontFamily: 'Knewave',
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Resumo",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Knewave',
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Total Mês à esquerda
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Total Mês",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                            fontFamily: 'Parkinsans',
                          ),
                        ),
                        Text(
                          "€ 6.000", // Este valor será dinâmico
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Parkinsans',
                          ),
                        ),
                        const SizedBox(height: 3),
                        // Barra de progresso do Mês
                        LinearPercentIndicator(
                          width: 100,
                          animation: true,
                          lineHeight: 6.0,
                          percent: 0.123,
                          backgroundColor: Colors.grey,
                          progressColor: Color(0xff00dda3),
                          barRadius: Radius.circular(2),
                        ),
                      ],
                    ),
                    // Total Anual à direita
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Total Anual",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                            fontFamily: 'Parkinsans',
                          ),
                        ),
                        Text(
                          "€ 20.000", // Este valor será dinâmico
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Parkinsans',
                          ),
                        ),
                        const SizedBox(height: 3),
                        // Barra de progresso do Ano
                        LinearPercentIndicator(
                          width: 150,
                          animation: true,
                          lineHeight: 6.0,
                          percent: 0.8,
                          backgroundColor: Colors.grey,
                          progressColor: Color(0xff00dda3),
                          barRadius: Radius.circular(2),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Tab lateral slide
          AnimatedPositioned(
            duration: Duration(milliseconds: 300), 
            right: _isTabOpen ? 0 : -MediaQuery.of(context).size.width / 2.5, 
            top: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 2.5, 
                color: Colors.white,
                child: Column(
                  children: [
                    // Conteúdo da tab
                    Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: Column(
                        children:[ 
                          Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            IconButton(
                              onPressed: () {
                                setState(() {
                                _isTabOpen = !_isTabOpen; 
                              });
                              },
                              icon: Icon(Icons.menu_rounded),
                              color: Color(0xff33404f),
                            ),
                          ],
                        
                        ),
                        const SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[ 
                            Icon(
                              Icons.ads_click_rounded,
                              color: Color(0xff33404f)
                              ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                _showMetaAnualDialog(context);
                              },
                              child: Text(
                              "Meta Mensal",
                                style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff33404f),
                                fontFamily: 'Parkinsans',
                                ),
                              ),
                            ),
                          ]
                        ),
                        
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[ 
                            Icon(
                              Icons.ads_click_rounded,
                              color: Color(0xff33404f)
                              ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                _showMetaAnualDialog(context);
                              },
                              child: Text(
                              "Meta Anual",
                                style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff33404f),
                                fontFamily: 'Parkinsans',
                                ),
                              ),
                            ),
                          ]
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[ 
                            Icon(
                              Icons.notifications_rounded,
                              color: Color(0xff33404f)
                              ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                _showNotificacoesDialog(context);
                              },
                              child: Text(
                              "Notificações",
                                style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff33404f),
                                fontFamily: 'Parkinsans',
                                ),
                              ),
                            ),
                          ]
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[ 
                            Icon(
                              Icons.settings_rounded,
                              color: Color(0xff33404f)
                              ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () 
                              {
                                _showConfiguracoesDialog(context);
                              },
                              child: Text(
                              "Definições",
                                style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff33404f),
                                fontFamily: 'Parkinsans',
                                ),
                              ),
                            ),
                          ]
                        ),
                        ]
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
    path.lineTo(-1, 0); // Início do caminho (topo esquerdo)
    path.lineTo(0, size.height - 20); // Linha até o final do lado esquerdo, com a curva para baixo
    path.quadraticBezierTo(
        size.width / 4, size.height, // Curva suave para baixo à esquerda
        size.width / 2, size.height); // Curva suave para baixo à direita
    path.quadraticBezierTo(
        3 * size.width / 4, size.height, // Curva suave para baixo à direita
        size.width, size.height - 20); // Linha até o final do lado direito
    path.lineTo(size.width, 0); // Linha até o topo direito
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// Função para exibir o pop-up de Meta Mensal
void _showMetaMensalDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Meta Mensal"),
        content: Text("Aqui você pode configurar sua meta mensal."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Fechar"),
          ),
        ],
      );
    },
  );
}

// Função para exibir o pop-up de Meta Anual
void _showMetaAnualDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Meta Anual"),
        content: Text("Aqui você pode configurar sua meta anual."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Fechar"),
          ),
        ],
      );
    },
  );
}

// Função para exibir o pop-up de Notificações
void _showNotificacoesDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Notificações"),
        content: Text("Aqui você pode configurar suas notificações."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Fechar"),
          ),
        ],
      );
    },
  );
}

// Função para exibir o pop-up de Definições
void _showConfiguracoesDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Definições"),
        content: Text("Aqui você pode ajustar suas configurações."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Fechar"),
          ),
        ],
      );
    },
  );
}
