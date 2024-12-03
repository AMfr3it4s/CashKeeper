import 'package:cashkeeper/utils/databasehelper.dart';
import 'package:cashkeeper/utils/libs/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartColumn extends StatefulWidget {
  const ChartColumn({super.key});

  @override
  State<ChartColumn> createState() => _ChartColumnState();
}

class _ChartColumnState extends State<ChartColumn> {
  double _metaMensal = 0.0;
  double _jan = 0.0;
  double _fev = 0.0;
  double _mar = 0.0;
  double _abr = 0.0;
  double _mai = 0.0;
  double _jun = 0.0;
  double _jul = 0.0;
  double _ago = 0.0;
  double _set = 0.0;
  double _out = 0.0;
  double _nov = 0.0;
  double _dez = 0.0;

  @override
  void initState() {
    super.initState();
    carregarValores();
  }

  Future<void> carregarValores() async {
    final DatabaseHelper databaseHelper = DatabaseHelper();
    double metaMensal = await databaseHelper.obterMetaMensal();
    double jan = await databaseHelper.obterSomaDoMes(1);
    double fev = await databaseHelper.obterSomaDoMes(2);
    double mar = await databaseHelper.obterSomaDoMes(3);
    double abr = await databaseHelper.obterSomaDoMes(4);
    double mai = await databaseHelper.obterSomaDoMes(5);
    double jun = await databaseHelper.obterSomaDoMes(6);
    double jul = await databaseHelper.obterSomaDoMes(7);
    double ago = await databaseHelper.obterSomaDoMes(8);
    double set = await databaseHelper.obterSomaDoMes(9);
    double out = await databaseHelper.obterSomaDoMes(10);
    double nov = await databaseHelper.obterSomaDoMes(11);
    double dez = await databaseHelper.obterSomaDoMes(12);

    setState(() {
      _metaMensal = metaMensal;
      _jan = jan;
      _fev = fev;
      _mar = mar;
      _abr = abr;
      _mai = mai;
      _jun = jun;
      _jul = jul;
      _ago = ago;
      _set = set;
      _out = out;
      _nov = nov;
      _dez = dez;
    });
  }

  List<ChartColumnData> _getChartData() {
    return [
      if (_jan > 0) ChartColumnData('Jan', _jan),
      if (_fev > 0) ChartColumnData('Fev', _fev),
      if (_mar > 0) ChartColumnData('Mar', _mar),
      if (_abr > 0) ChartColumnData('Abr', _abr),
      if (_mai > 0) ChartColumnData('Mai', _mai),
      if (_jun > 0) ChartColumnData('Jun', _jun),
      if (_jul > 0) ChartColumnData('Jul', _jul),
      if (_ago > 0) ChartColumnData('Ago', _ago),
      if (_set > 0) ChartColumnData('Set', _set),
      if (_out > 0) ChartColumnData('Out', _out),
      if (_nov > 0) ChartColumnData('Nov', _nov),
      if (_dez > 0) ChartColumnData('Dez', _dez),
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
                      "Estatísticas do Mês",
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
                    color: AppColors.tertiaryColor,
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
                maximum: _metaMensal * 2,
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
                  color: AppColors.tertiaryColor,
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
