import 'package:cashkeeper/utils/databasehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AppHeader extends StatefulWidget {
  const AppHeader({super.key});

  @override
  _AppHeaderState createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  bool _isTabOpen = false;
  double _receitaMensal = 0.0;
  double _receitaAnual = 0.0;
  double _percentAnual = 0.0;
  double _percentMensal = 0.0;
 
  

  @override
  void initState() 
  {
    super.initState();
    carregarValores();

  }

  Future<void> carregarValores() async 
  {
    final DatabaseHelper db = DatabaseHelper();
    double metaMensal = await db.obterMetaMensal();
    double metaAnual = await db.obterMetaAnual();
    double receitaMensal = await db.obterValorMensal();
    double receitaAnual = await db.obterValorAnual();
    setState(() {
      _receitaMensal = receitaMensal;
      _receitaAnual = receitaAnual;
      _percentAnual = (receitaAnual/metaAnual);
      _percentMensal = (receitaMensal/metaMensal);
    });

  }

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
                          "€ $_receitaMensal", // Este valor será dinâmico
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
                          percent: _percentMensal.clamp(0.0, 1.0),
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
                          "€ $_receitaAnual", // Este valor será dinâmico
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
                          percent: _percentAnual.clamp(0.0, 1.0),
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
                                _showMetaDialog(context);
                              },
                              child: Text(
                              "Definir Metas",
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


// Função para exibir o pop-up de Meta Anual
void _showMetaDialog(BuildContext context) {
   final TextEditingController controller1 = TextEditingController();
   final TextEditingController controller2 = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Definir Metas"),
        content: SizedBox(
          height: 300,
          width: 300,
          child: Column(
            children: [
              Text("Meta Mensal"),
              const SizedBox(height: 5),
              TextField(
                controller: controller1,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                decoration: const InputDecoration(
                  hintText: "Digite a Meta Mensal",
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
              ),
              const SizedBox(height: 20),
              Text("Meta Anual"),
              const SizedBox(height: 5),
              TextField(
                controller: controller2,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                decoration: const InputDecoration(
                  hintText: "Digite a Meta Anual",
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  final inputValue1 = controller1.text;
                  final inputValue2 = controller2.text;
                  final DatabaseHelper databaseHelper = DatabaseHelper();
                  if (inputValue1.isNotEmpty && inputValue2.isNotEmpty) {
                    databaseHelper.atualizarMetas(double.parse(inputValue2), double.parse(inputValue1));
                    controller1.clear();
                    controller2.clear();
                  } else {
                    print("Por favor, insira um número.");
                  }
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff33404f),
                  foregroundColor: Color(0xff33404f).withOpacity(0.7)
                  ),
                  child: const Text("Submit", style: TextStyle(color: Colors.white)),
                  ),
            ],
          ),
        ),
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
