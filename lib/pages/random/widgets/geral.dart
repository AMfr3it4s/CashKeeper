import 'package:cashkeeper/utils/databasehelper.dart';
import 'package:cashkeeper/utils/libs/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Geral extends StatefulWidget {
  const Geral({super.key});

  @override
  State<Geral> createState() => _GeralState();
}

class _GeralState extends State<Geral> {
  bool isMonthSelected = true;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 244,
      child: Column(
        children: [       
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0), 
              child: Row(
                children:[ 
                  Text(
                  "Geral",
                  style: TextStyle(
                    fontSize: 25,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.scondaryFont,
                  ),
                ),
                const SizedBox(width: 3),
                Text(
                  "- Entrada Diária de Receita",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.scondaryFont,
                  ),
                )
                ]),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Botão "Mês"
              isMonthSelected
                  ? OutlinedButton(
                      onPressed: () {
                        setState(() {
                          isMonthSelected = true;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.tertiaryColor, width: 2),
                      ),
                      child: Text('Adicionar', style: TextStyle(color: AppColors.tertiaryColor)),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isMonthSelected = true;
                        
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                      ),
                      child: Text('Adicionar', style: TextStyle(color: AppColors.primaryColor)),
                    ),
              // Botão "Semana"
              !isMonthSelected
                  ? OutlinedButton(
                      onPressed: () {
                        setState(() {
                          isMonthSelected = false;
                        
                          
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.tertiaryColor, width: 2),
                      ),
                      child: Text('Atualizar', style: TextStyle(color: AppColors.tertiaryColor)),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isMonthSelected = false;
                          
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                      ),
                      child: Text('Atualizar', style: TextStyle(color: AppColors.primaryColor)),
                    ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            child: isMonthSelected ?
            Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: 380, // Ajuste o tamanho conforme necessário
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: false,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Digite o valor diário",
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: [
                              // Use input formatters para filtrar números
                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            final inputValue = _controller.text;
                            final DatabaseHelper databaseHelper = DatabaseHelper();
                            if (inputValue.isNotEmpty) {
                              databaseHelper.inserirRegistoComDataAtual(double.parse(inputValue));
                              _controller.clear();
                              print("Valor submetido: $inputValue");
                            } else {
                              print("Por favor, insira um número.");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            foregroundColor: AppColors.secondaryColor.withOpacity(0.7)
                          ),
                          child: const Text("Submit", style: TextStyle(color: AppColors.primaryColor)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
            :Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: 380, // Ajuste o tamanho conforme necessário
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: false,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Atualizar o valor diário",
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: [
                              // Use input formatters para filtrar números
                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            final inputValue = _controller.text;
                            final DatabaseHelper databaseHelper = DatabaseHelper();
                            if (inputValue.isNotEmpty) {
                              databaseHelper.atualizarRegistoComDataAtual(double.parse(inputValue));
                              _controller.clear();
                              print("Valor submetido: $inputValue");
                            } else {
                              print("Por favor, insira um número.");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            foregroundColor: AppColors.secondaryColor.withOpacity(0.7),
                          ),
                          child: const Text("Submit", style: TextStyle(color: AppColors.primaryColor),),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
            ,
          )
        ],
      ),
    );
  }
}