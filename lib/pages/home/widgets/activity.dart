import 'package:cashkeeper/utils/libs/constants.dart';
import 'package:flutter/material.dart';
import 'package:cashkeeper/utils/databasehelper.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<Map<String, dynamic>>> fetchRecentActivities() async {
    // Obtém o banco de dados já inicializado
    final db = await _databaseHelper.getDatabase();

    // Realiza a consulta na tabela `atividades`
    return await db.query(
      'atividades',
      orderBy: 'id DESC',
      limit: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10),
            child: Text(
              "Atividades",
              style: TextStyle(
                fontSize: 25,
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.scondaryFont,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchRecentActivities(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Erro ao carregar atividades"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Nenhuma atividade registrada"));
                }

                final activities = snapshot.data!;

                return ListView.builder(
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    final activity = activities[index];
                    final isPositive = activity['descricao'].contains("Adicionar");

                    return ListTile(
                      leading: Icon(
                        isPositive ? Icons.file_upload_outlined : Icons.file_download_outlined,
                        color: isPositive ?  AppColors.tertiaryColor :  AppColors.secondaryColor,
                      ),
                      title: Text(
                        activity['descricao'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        activity['data'],
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      trailing: Text(
                        '${isPositive ? '+' : ''}${activity['valor']} €',
                        style: TextStyle(
                          fontSize: 16,
                          color: isPositive ?  AppColors.tertiaryColor :  AppColors.secondaryColor,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
