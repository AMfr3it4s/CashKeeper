import 'package:cashkeeper/utils/databasehelper.dart';
import 'package:cashkeeper/utils/libs/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartColumnWeek extends StatefulWidget {
  const ChartColumnWeek({super.key});

  @override
  State<ChartColumnWeek> createState() => _ChartColumnWeekState();
}

class _ChartColumnWeekState extends State<ChartColumnWeek> {
  double _dom = 0.0;
  double _seg = 0.0;
  double _ter = 0.0;
  double _qua = 0.0;
  double _qui = 0.0;
  double _sex = 0.0;
  double _sab = 0.0;
 
 
 @override
 void initState() 
 {
  super.initState();
  carregarValores();
 }

  Future<void> carregarValores () async 
  {
    final DatabaseHelper databaseHelper = DatabaseHelper();
    List<Map<String, dynamic>> valoresSemanaMap = await databaseHelper.obterValoresSemana();

     List<double> valoresSemana = valoresSemanaMap.map((mapa) {
    return double.tryParse(mapa['valor'].toString()) ?? 0.0; 
  }).toList();

    setState(() {
      _dom = valoresSemana[0];
      _seg = valoresSemana[1];
      _ter = valoresSemana[2];
      _qua = valoresSemana[3];
      _qui = valoresSemana[4];
      _sex = valoresSemana[5];
      _sab = valoresSemana[6];
    });
  }

  List<ChartColumnData> _getChartData() {
    return [
      if (_dom > 0) ChartColumnData('Dom', _dom),
      if (_seg > 0) ChartColumnData('Seg', _seg),
      if (_ter > 0) ChartColumnData('Ter', _ter),
      if (_qua > 0) ChartColumnData('Qua', _qua),
      if (_qui > 0) ChartColumnData('Qui', _qui),
      if (_sex > 0) ChartColumnData('Sex', _sex),
      if (_sab > 0) ChartColumnData('Sab', _sab),
      
      
    ];
  }




  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColor,
      surfaceTintColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Receitas",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: AppFonts.primaryFont,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Estatísticas da Semana",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontFamily: AppFonts.primaryFont,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert, size: 30)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 27,
                  height: 13,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Receitas",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: AppFonts.primaryFont,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 0),
            SfCartesianChart(
              plotAreaBackgroundColor: Colors.transparent,
              margin: const EdgeInsets.all(0),
              borderColor: Colors.transparent,
              borderWidth: 0,
              plotAreaBorderWidth: 0,
              enableSideBySideSeriesPlacement: false,
              primaryXAxis: CategoryAxis(
                axisLine: const AxisLine(width: 0.5),
                majorGridLines: const MajorGridLines(width: 0),
                majorTickLines: const MajorTickLines(width: 0),
                crossesAt: 0,
              ),
              primaryYAxis: NumericAxis(
                isVisible: false,
                minimum: 0,
                maximum: 700,
                interval: 100,
              ),
              series: <CartesianSeries>[
                ColumnSeries<ChartColumnData, String>(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  dataSource: _getChartData(),
                  width: 0.5,
                  color: AppColors.secondaryColor,
                  xValueMapper: (ChartColumnData data, _) => data.x,
                  yValueMapper: (ChartColumnData data, _) => data.y,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    textStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    labelAlignment: ChartDataLabelAlignment.outer,
                    offset: const Offset(0, -10)
                  ),
                  dataLabelMapper: (ChartColumnData data, _) =>
                      (data.y != null && data.y! > 0) ? data.y!.toStringAsFixed(2) : '',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChartColumnData {
  ChartColumnData(this.x, this.y);
  final String x;
  final double? y;
}