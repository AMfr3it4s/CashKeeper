import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// Classe para gerenciar o banco de dados
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  Database? _database;

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  // Função para inicializar o banco de dados
  Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    // Recupera o diretório do banco de dados
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'meu_banco.db');

    // Abre o banco de dados (e cria se não existir)
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Criando a tabela 'registo'
        await db.execute(''' 
          CREATE TABLE registo(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            valor REAL,
            ano INTEGER,
            mes INTEGER,
            dia INTEGER
          )
        ''');

        // Criando a tabela 'metas'
        await db.execute('''
          CREATE TABLE metas(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            meta_anual REAL,
            meta_mensal REAL
          )
        ''');
        //Actividades
        await db.execute('''
          CREATE TABLE atividades (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            descricao TEXT NOT NULL,
            valor REAL,
            data TEXT NOT NULL
          )
        ''');
      },
    );

    return _database!;
  }

  // Função para inserir dados na tabela 'metas'
  Future<void> inserirMetas(double metaAnual, double metaMensal) async {
    final db = await getDatabase();

    await db.insert(
      'metas',
      {'meta_anual': metaAnual, 'meta_mensal': metaMensal},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Função para obter todos os registos
  Future<List<Map<String, dynamic>>> obterRegistos() async {
    final db = await getDatabase();
    return await db.query('registo');
  }

  // Função para obter todas as metas
  Future<List<Map<String, dynamic>>> obterMetas() async {
    final db = await getDatabase();
    return await db.query('metas');
  }

 // Função para obter o valor total mensal
Future<double> obterValorMensal() async {
  final db = await getDatabase();

  // Obtém o mês e o ano atual
  final DateTime now = DateTime.now();
  final int anoAtual = now.year;
  final int mesAtual = now.month;

  // Consulta SQL para somar os valores dos dias do mês atual
  final List<Map<String, dynamic>> resultado = await db.rawQuery('''
    SELECT SUM(valor) AS valorMensal
    FROM registo
    WHERE ano = ? AND mes = ?
  ''', [anoAtual, mesAtual]);

  // Retorna a soma ou 0 caso não haja valores
  return resultado.isNotEmpty && resultado[0]['valorMensal'] != null
      ? resultado[0]['valorMensal'] as double
      : 0.0;
}

  // Função para obter o valor total anual
  Future<double> obterValorAnual() async {
    final db = await getDatabase();

    // Obtém o ano atual
    final DateTime now = DateTime.now();
    final int anoAtual = now.year;

    // Consulta SQL para somar os valores de todos os meses do ano atual
    final List<Map<String, dynamic>> resultado = await db.rawQuery('''
      SELECT SUM(valor) AS valorAnual
      FROM registo
      WHERE ano = ?
    ''', [anoAtual]);

    // Se houver resultado, retorna a soma ou 0 caso não haja
    return resultado.isNotEmpty && resultado[0]['valorAnual'] != null
        ? resultado[0]['valorAnual'] as double
        : 0.0;
  }

  // Função para obter o valor total semanal
Future<double> obterValorSemanal() async {
  final db = await getDatabase();

  // Obtém a data atual
  final DateTime agora = DateTime.now();

  // Calcula o primeiro dia (domingo) e o último dia (sábado) da semana atual
  final DateTime primeiroDiaSemana = agora.subtract(Duration(days: agora.weekday % 7));
  final DateTime ultimoDiaSemana = primeiroDiaSemana.add(Duration(days: 6));

  // Consulta SQL para somar os valores dos dias da semana atual
  final List<Map<String, dynamic>> resultado = await db.rawQuery('''
    SELECT SUM(valor) AS valorSemanal
    FROM registo
    WHERE (ano = ? AND mes = ? AND dia >= ?)
       OR (ano = ? AND mes = ? AND dia <= ?)
  ''', [
    primeiroDiaSemana.year, primeiroDiaSemana.month, primeiroDiaSemana.day, // Início
    ultimoDiaSemana.year, ultimoDiaSemana.month, ultimoDiaSemana.day,       // Fim
  ]);

  // Retorna a soma ou 0 caso não haja valores
  return resultado.isNotEmpty && resultado[0]['valorSemanal'] != null
      ? resultado[0]['valorSemanal'] as double
      : 0.0;
}

  // Função para obter o valor da meta mensal
  Future<double> obterMetaMensal() async {
    final db = await getDatabase();

    // Consulta SQL para obter a meta mensal
    final List<Map<String, dynamic>> resultado = await db.query('metas');

    // Se houver resultados, retorna a meta mensal, caso contrário retorna 0
    return resultado.isNotEmpty && resultado[0]['meta_mensal'] != null
        ? resultado[0]['meta_mensal'] as double
        : 0.0;
  }

  // Função para obter o valor da meta anual
  Future<double> obterMetaAnual() async {
    final db = await getDatabase();

    // Consulta SQL para obter a meta anual
    final List<Map<String, dynamic>> resultado = await db.query('metas');

    // Se houver resultados, retorna a meta anual, caso contrário retorna 0
    return resultado.isNotEmpty && resultado[0]['meta_anual'] != null
        ? resultado[0]['meta_anual'] as double
        : 0.0;
  }

Future<void> inserirRegistoComDataAtual(double valor) async {
  final db = await getDatabase();

  // Obtém a data atual
  final DateTime agora = DateTime.now();
  String dateTimeString = agora.toString();

  // Extrai o ano, mês e dia da data atual
  final int anoAtual = agora.year;
  final int mesAtual = agora.month;
  final int diaAtual = agora.day;

  // Verifica se já existe um registro para essa data
  final List<Map<String, dynamic>> registrosExistentes = await db.query(
    'registo',
    where: 'ano = ? AND mes = ? AND dia = ?',
    whereArgs: [anoAtual, mesAtual, diaAtual],
  );

  if (registrosExistentes.isNotEmpty) {
      return;
  } else {
    // Se não houver registro para o dia, insere um novo
    await db.insert(
      'registo',
      {'valor': valor, 'ano': anoAtual, 'mes': mesAtual, 'dia': diaAtual},
    );
    await db.insert(
      'atividades',
      {'descricao': 'Adicionar Receita', 'valor': valor, 'data': dateTimeString}
    );
  }
}


// Função para atualizar o valor de um registo com base na data atual
Future<void> atualizarRegistoComDataAtual(double novoValor) async {
  final db = await getDatabase();

  // Obtém a data atual
  final DateTime agora = DateTime.now();
  String dateTimeString = agora.toString();

  // Extrai o ano, mês e dia da data atual
  int ano = agora.year;
  int mes = agora.month;
  int dia = agora.day;

  // Atualiza o valor na tabela 'registo' para o registro com a data atual
  await db.update(
    'registo',
    {'valor': novoValor},  // Atualiza o valor
    where: 'ano = ? AND mes = ? AND dia = ?',  // Condição para encontrar o registro
    whereArgs: [ano, mes, dia],  // Argumentos para a condição
  );
  await db.insert(
      'atividades',
      {'descricao': 'Atualizar Receita', 'valor': novoValor, 'data': dateTimeString}
    );
}

// Função para atualizar as metas anuais e mensais
Future<void> atualizarMetas(double metaAnual, double metaMensal) async {
  final db = await getDatabase();

  // Insere a nova meta ou atualiza caso já exista
  await db.insert(
    'metas',
    {'id': 1, 'meta_anual': metaAnual, 'meta_mensal': metaMensal}, // Novo valor das metas
    conflictAlgorithm: ConflictAlgorithm.replace, // Substitui os valores caso o 'id' já exista
  );
}

// Função para obter a soma dos valores de um mês específico no ano atual
Future<double> obterSomaDoMes(int mes) async {
  final db = await getDatabase();

  // Obtém o ano atual
  final DateTime agora = DateTime.now();
  final int anoAtual = agora.year;

  // Consulta SQL para somar os valores do mês específico no ano atual
  final List<Map<String, dynamic>> resultado = await db.rawQuery('''
    SELECT SUM(valor) AS somaMes
    FROM registo
    WHERE ano = ? AND mes = ?
  ''', [anoAtual, mes]);

  // Retorna o valor da soma ou 0 se não houver registros
  return resultado.isNotEmpty && resultado[0]['somaMes'] != null
      ? resultado[0]['somaMes'] as double
      : 0.0;
}

Future<List<Map<String, dynamic>>> obterValoresSemana() async {
  final db = await getDatabase();

  // Obtém a data atual
  final DateTime agora = DateTime.now();

  // Calcula o primeiro dia da semana (domingo) e o último (sábado)
  final DateTime primeiroDiaSemana = agora.subtract(Duration(days: agora.weekday % 7));
  final List<DateTime> diasSemana = List.generate(
    7,
    (index) => primeiroDiaSemana.add(Duration(days: index)),
  );

  // Lista para armazenar os valores dos dias da semana
  List<Map<String, dynamic>> valoresSemana = [];

  for (var dia in diasSemana) {
    // Busca o valor para o dia específico
    final List<Map<String, dynamic>> resultado = await db.query(
      'registo',
      where: 'ano = ? AND mes = ? AND dia = ?',
      whereArgs: [dia.year, dia.month, dia.day],
    );

    // Se houver registro, pega o valor; caso contrário, insere 0
    valoresSemana.add({
      'ano': dia.year,
      'mes': dia.month,
      'dia': dia.day,
      'valor': resultado.isNotEmpty ? resultado[0]['valor'] as double : 0.0,
    });
  }

  return valoresSemana;
}





}
