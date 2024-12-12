import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cashkeeper/utils/databasehelper.dart';
import 'package:cashkeeper/utils/libs/constants.dart';
import 'package:cashkeeper/utils/notifications.dart';
import 'package:cashkeeper/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';



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
  bool isNotificationsEnabled = false; // Variável para controlar o slider
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

 
  

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
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.primaryFont,
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
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Olá, Junior!",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 40,
                      fontFamily: AppFonts.scondaryFont,
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
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.scondaryFont,
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
                            color: AppColors.primaryColor.withOpacity(0.8),
                            fontFamily: AppFonts.primaryFont,
                          ),
                        ),
                        Text(
                          "€ $_receitaMensal", // Este valor será dinâmico
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.primaryFont,
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
                          progressColor: AppColors.tertiaryColor,
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
                            color: AppColors.primaryColor.withOpacity(0.8),
                            fontFamily: AppFonts.primaryFont,
                          ),
                        ),
                        Text(
                          "€ $_receitaAnual", // Este valor será dinâmico
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.primaryFont,
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
                          progressColor: AppColors.tertiaryColor,
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
            right: _isTabOpen ? 0 : -MediaQuery.of(context).size.width / 2.8, 
            top: 50,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 2.8, 
                color: AppColors.primaryColor,
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
                              color: AppColors.secondaryColor,
                            ),
                          ],
                        
                        ),
                        const SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[ 
                            Icon(
                              Icons.ads_click_rounded,
                              color: AppColors.secondaryColor
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
                                color: AppColors.secondaryColor,
                                fontFamily: AppFonts.primaryFont,
                                fontWeight: FontWeight.w700
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
                              color: AppColors.secondaryColor
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
                                color: AppColors.secondaryColor,
                                fontFamily: AppFonts.primaryFont,
                                fontWeight: FontWeight.w700
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
                              color: AppColors.secondaryColor
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
                                color: AppColors.secondaryColor,
                                fontFamily: AppFonts.primaryFont,
                                fontWeight: FontWeight.w700
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
        title: Text("Definir Metas", style: TextStyle(fontSize: 18, fontFamily: AppFonts.primaryFont)),
        content: SizedBox(
          height: 300,
          width: 300,
          child: Column(
            children: [
              Text("Meta Mensal", style: TextStyle(fontFamily: AppFonts.primaryFont)),
              const SizedBox(height: 5),
              TextField(
                controller: controller1,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                decoration: const InputDecoration(
                  hintText: "Digite a Meta Mensal",
                  hintStyle: TextStyle(fontFamily: AppFonts.primaryFont),
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
              ),
              const SizedBox(height: 20),
              Text("Meta Anual",style: TextStyle(fontFamily: AppFonts.primaryFont)),
              const SizedBox(height: 5),
              TextField(
                controller: controller2,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                decoration: const InputDecoration(
                  hintText: "Digite a Meta Anual",
                  hintStyle: TextStyle(fontFamily: AppFonts.primaryFont),
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
              ),
              const SizedBox(width: 40),
              ElevatedButton(
                onPressed: () {
                  final inputValue1 = controller1.text;
                  final inputValue2 = controller2.text;
                  final DatabaseHelper databaseHelper = DatabaseHelper();
                  if (inputValue1.isNotEmpty && inputValue2.isNotEmpty) {
                      final value1 = double.tryParse(inputValue1);
                      final value2 = double.tryParse(inputValue2);
                      if (value1 != null && value1 != 0 && value2 != null && value2 != 0) {
                      databaseHelper.atualizarMetas(double.parse(inputValue2), double.parse(inputValue1));
                      controller1.clear();
                      controller2.clear();
                      SnackbarHelper.showAwesomeSnackbar(context, title: "Success", message: "Submetidas as Metas", duration: 3, contentType: ContentType.success);
                      }else {
                        SnackbarHelper.showAwesomeSnackbar(context, title: "Error", message: "Os valores não podem ser 0 ou inválidos.", duration: 3, contentType: ContentType.failure);
                      }
                  }
                  else {
                    SnackbarHelper.showAwesomeSnackbar(context, title: "Warning", message: "Por favor, insere um número", duration: 3, contentType: ContentType.warning);
                  }
                  
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  foregroundColor: AppColors.secondaryColor.withOpacity(0.7)
                  ),
                  child: const Text("Submit", style: TextStyle(color: AppColors.primaryColor, fontFamily: AppFonts.primaryFont)),
                  ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Fechar", style: TextStyle(fontFamily: AppFonts.primaryFont)),
          ),
        ],
      );
    },
  );
}


void _showNotificacoesDialog(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  bool isNotificationsEnabled = prefs.getBool('notificationsEnabled') ?? false;
  final notificationService = NotificationService();

  void updateNotifications(bool value) async {
    prefs.setBool('notificationsEnabled', value);
    if (value) {
      // To implement
      await notificationService.scheduleNotificationsIfNeeded();
    } else {
      await NotificationService.flutterLocalNotificationsPlugin.cancelAll();
      
      
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text(
              "Notificações",
              style: TextStyle(fontFamily: AppFonts.primaryFont),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ativar notificações",
                  style: TextStyle(fontFamily: AppFonts.primaryFont),
                ),
                Switch(
                  value: isNotificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      isNotificationsEnabled = value;
                    });
                    updateNotifications(value);
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Fechar",
                  style: TextStyle(fontFamily: AppFonts.primaryFont),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}



// Função para exibir o pop-up de Definições
void _showConfiguracoesDialog(BuildContext context) {
  final DatabaseHelper db = DatabaseHelper();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Definições", style: TextStyle(fontFamily: AppFonts.primaryFont)),
        content: SizedBox(
          height: 310,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_amber_rounded, size: 50, color: Colors.red),
                  Text(
                    "Cuidado",
                    style: TextStyle(fontFamily: AppFonts.primaryFont, color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("Tudo o que fizeres aqui é irreversível por isso, pensa bem antes de executares uma acção por engano!", style: TextStyle(fontFamily: AppFonts.primaryFont)),
              const SizedBox(height: 45),
              ElevatedButton(
                onPressed: () {
                  _showConfirmacaoDialog(context, db.apagarRegistroHoje()); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                child: Text('Eliminar os registos de hoje!', style: TextStyle(color: AppColors.primaryColor, fontFamily: AppFonts.primaryFont)),
              ),
              const SizedBox(height: 45),
              ElevatedButton(
                onPressed: () {
                  _showConfirmacaoDialog(context, db.apagarTodosOsDados()); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text('Eliminar todos os registos!', style: TextStyle(color: AppColors.primaryColor, fontFamily: AppFonts.primaryFont)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Fechar", style: TextStyle(fontFamily: AppFonts.primaryFont)),
          ),
        ],
      );
    },
  );
}

void _showConfirmacaoDialog(BuildContext context, Future<void> funcao) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirmação", style: TextStyle(fontFamily: AppFonts.primaryFont)),
        content: Text("Tem a certeza que deseja executar esta ação? Esta ação não pode ser revertida.", style: TextStyle(fontFamily: AppFonts.primaryFont)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo de confirmação
            },
            child: Text("Cancelar", style: TextStyle(fontFamily: AppFonts.primaryFont)),
          ),
          TextButton(
            onPressed: () async{
              await funcao;
              Navigator.of(context).pop(); // Fecha o diálogo de confirmação
            },
            child: Text("Confirmar", style: TextStyle(fontFamily: AppFonts.primaryFont)),
          ),
        ],
      );
    },
  );
}

