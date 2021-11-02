import 'package:flutter/material.dart';
import 'package:pisto/screens/main_drawer.dart';
import 'package:pisto/services/mongo_service_helper.dart';
import 'package:pisto/widgets/app_bar_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pisto/widgets/loading_page.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isDashLoading = true;
  Map<String, dynamic> res = {};
  Future<void> dashData() async {
    // LocalDatabaseHelper dbh = LocalDatabaseHelper.instance;
    Map<String, dynamic> _res = await DashBoardService().getDashData();
    setState(() {
      res = _res;
      isDashLoading = false;
    });
  }

  @override
  void initState() {
    dashData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = TextStyle(fontSize: 15.0);
    final TextStyle lblStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20.0);
    final List<List<double>> charts = [
      [
        0.0,
        0.3,
        0.7,
        0.6,
        0.55,
        0.8,
        1.2,
        1.3,
        1.35,
        0.9,
        1.5,
        1.7,
        1.8,
        1.7,
        1.2,
        0.8,
        1.9,
        2.0,
        2.2,
        1.9,
        2.2,
        2.1,
        2.0,
        2.3,
        2.4,
        2.45,
        2.6,
        3.6,
        2.6,
        2.7,
        2.9,
        2.8,
        3.4
      ],
      [
        0.0,
        0.3,
        0.7,
        0.6,
        0.55,
        0.8,
        1.2,
        1.3,
        1.35,
        0.9,
        1.5,
        1.7,
        1.8,
        1.7,
        1.2,
        0.8,
        1.9,
        2.0,
        2.2,
        1.9,
        2.2,
        2.1,
        2.0,
        2.3,
        2.4,
        2.45,
        2.6,
        3.6,
        2.6,
        2.7,
        2.9,
        2.8,
        3.4,
        0.0,
        0.3,
        0.7,
        0.6,
        0.55,
        0.8,
        1.2,
        1.3,
        1.35,
        0.9,
        1.5,
        1.7,
        1.8,
        1.7,
        1.2,
        0.8,
        1.9,
        2.0,
        2.2,
        1.9,
        2.2,
        2.1,
        2.0,
        2.3,
        2.4,
        2.45,
        2.6,
        3.6,
        2.6,
        2.7,
        2.9,
        2.8,
        3.4,
      ],
      [
        0.0,
        0.3,
        0.7,
        0.6,
        0.55,
        0.8,
        1.2,
        1.3,
        1.35,
        0.9,
        1.5,
        1.7,
        1.8,
        1.7,
        1.2,
        0.8,
        1.9,
        2.0,
        2.2,
        1.9,
        2.2,
        2.1,
        2.0,
        2.3,
        2.4,
        2.45,
        2.6,
        3.6,
        2.6,
        2.7,
        2.9,
        2.8,
        3.4,
        0.0,
        0.3,
        0.7,
        0.6,
        0.55,
        0.8,
        1.2,
        1.3,
        1.35,
        0.9,
        1.5,
        1.7,
        1.8,
        1.7,
        1.2,
        0.8,
        1.9,
        2.0,
        2.2,
        1.9,
        2.2,
        2.1,
        2.0,
        2.3,
        2.4,
        2.45,
        2.6,
        3.6,
        2.6,
        2.7,
        2.9,
        2.8,
        3.4,
        0.0,
        0.3,
        0.7,
        0.6,
        0.55,
        0.8,
        1.2,
        1.3,
        1.35,
        0.9,
        1.5,
        1.7,
        1.8,
        1.7,
        1.2,
        0.8,
        1.9,
        2.0,
        2.2,
        1.9,
        2.2,
        2.1,
        2.0,
        2.3,
        2.4,
        2.45,
        2.6,
        3.6,
        2.6,
        2.7,
        2.9,
        2.8,
        3.4
      ]
    ];

    final List<String> chartDropdownItems = [
      'Last 7 days',
      'Last month',
      'Last year'
    ];
    String actualDropdown = chartDropdownItems[0];
    int actualChart = 0;

    // (isDashLoading)?return

    final _mainDash = StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          //total users
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                        color: Colors.blue,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.person,
                              color: Colors.white, size: 30.0),
                        )),
                    Padding(padding: EdgeInsets.only(bottom: 16.0)),
                    Text('Total Users', style: titleStyle),
                    Text('${res['users']}',
                        style: lblStyle),
                  ]),
            ),
          ),
          //total request loan
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                        color: Colors.blue,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.money,
                              color: Colors.white, size: 30.0),
                        )),
                    Padding(padding: EdgeInsets.only(bottom: 16.0)),
                    Text('Total Loans', style: titleStyle),
                    Text('${res['loans']}', style: lblStyle),
                  ]),
            ),
          ),
          //total approved loans
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                        color: Colors.green,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.check,
                              color: Colors.white, size: 30.0),
                        )),
                    Padding(padding: EdgeInsets.only(bottom: 16.0)),
                    Text('Approved Loans', style: titleStyle),
                    Text('${res['approved']}', style: lblStyle),
                  ]),
            ),
          ),
          //total pending loans
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                        color: Colors.amber,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.pending,
                              color: Colors.white, size: 30.0),
                        )),
                    Padding(padding: EdgeInsets.only(bottom: 16.0)),
                    Text('Pending Loans', style: titleStyle),
                    Text('${res['pending']}', style: lblStyle),
                  ]),
            ),
          ),
          //total cancelled loans
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Cancelled Loans', style: titleStyle),
                        Text('${res['cancelled']}', style: lblStyle)
                      ],
                    ),
                    Material(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(Icons.cancel,
                              color: Colors.white, size: 30.0),
                        )))
                  ]),
            ),
          ),
          //user to loan amount request
          _buildTile(
            Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Loan Request Amount', style: titleStyle),
                            // Text('\$16K',
                            //     style: TextStyle(
                            //         color: Colors.black,
                            //         fontWeight: FontWeight.w700,
                            //         fontSize: 34.0)),
                          ],
                        ),
                        DropdownButton(
                            isDense: true,
                            value: actualDropdown,
                            onChanged: (String value) => setState(() {
                                  actualDropdown = value;
                                  actualChart = chartDropdownItems
                                      .indexOf(value); // Refresh the chart
                                }),
                            items: chartDropdownItems.map((String title) {
                              return DropdownMenuItem(
                                value: title,
                                child: Text(title,
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0)),
                              );
                            }).toList())
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 4.0)),
                    Container(
                      height: 140,
                      child: LineChart(
                        sampleData1(),
                        swapAnimationDuration:
                            const Duration(milliseconds: 250),
                      ),
                    )
                    // Sparkline(
                    //   data: charts[actualChart],
                    //   lineWidth: 5.0,
                    //   lineColor: Colors.greenAccent,
                    // )
                  ],
                )),
          ),
          //user to loan request freq
          _buildTile(
            Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Loan Request Frequency', style: titleStyle),
                            // Text('\$16K',
                            //     style: TextStyle(
                            //         color: Colors.black,
                            //         fontWeight: FontWeight.w700,
                            //         fontSize: 34.0)),
                          ],
                        ),
                        DropdownButton(
                            isDense: true,
                            value: actualDropdown,
                            onChanged: (String value) => setState(() {
                                  actualDropdown = value;
                                  actualChart = chartDropdownItems
                                      .indexOf(value); // Refresh the chart
                                }),
                            items: chartDropdownItems.map((String title) {
                              return DropdownMenuItem(
                                value: title,
                                child: Text(title,
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0)),
                              );
                            }).toList())
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 4.0)),
                    Container(
                      height: 140,
                      child: LineChart(
                        sampleData1(),
                        swapAnimationDuration:
                            const Duration(milliseconds: 250),
                      ),
                    )
                    // Sparkline(
                    //   data: charts[actualChart],
                    //   lineWidth: 5.0,
                    //   lineColor: Colors.greenAccent,
                    // )
                  ],
                )),
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(1, 180.0), //total users
          StaggeredTile.extent(1, 180.0), //totol loans
          StaggeredTile.extent(1, 180.0), //approved
          StaggeredTile.extent(1, 180.0), //pending
          StaggeredTile.extent(2, 110.0), //canelled
          StaggeredTile.extent(2, 220.0), //user to loan
          StaggeredTile.extent(2, 220.0), //user to loan freq
        ]);

    return Scaffold(
      appBar: MyAppBar(),
      drawer: MainDrawer(),
      body: (isDashLoading) ? LoadingPage(): _mainDash,
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        // touchTooltipData: LineTouchTooltipData(

        // ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          // reservedSize: 10,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            // fontWeight: FontWeight.bold,
            // fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
            }
            return '';
          },
          // margin: 8,
          // reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 1,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    // final LineChartBarData lineChartBarData1 = LineChartBarData(
    //   spots: [
    //     FlSpot(1, 1),
    //     FlSpot(3, 1.5),
    //     FlSpot(5, 1.4),
    //     FlSpot(7, 3.4),
    //     FlSpot(10, 2),
    //     FlSpot(12, 2.2),
    //     FlSpot(13, 1.8),
    //   ],
    //   isCurved: true,
    //   colors: [
    //     const Color(0xff4af699),
    //   ],
    //   barWidth: 8,
    //   isStrokeCapRound: true,
    //   dotData: FlDotData(
    //     show: false,
    //   ),
    //   belowBarData: BarAreaData(
    //     show: false,
    //   ),
    // );
    // final LineChartBarData lineChartBarData2 = LineChartBarData(
    //   spots: [
    //     FlSpot(1, 1),
    //     FlSpot(3, 2.8),
    //     FlSpot(7, 1.2),
    //     FlSpot(10, 2.8),
    //     FlSpot(12, 2.6),
    //     FlSpot(13, 3.9),
    //   ],
    //   isCurved: true,
    //   colors: [
    //     const Color(0xffaa4cfc),
    //   ],
    //   barWidth: 8,
    //   isStrokeCapRound: true,
    //   dotData: FlDotData(
    //     show: false,
    //   ),
    //   belowBarData: BarAreaData(show: false, colors: [
    //     const Color(0x00aa4cfc),
    //   ]),
    // );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5)
      ],
      isCurved: true,
      colors: const [
        Color(0xff27b6fc),
      ],
      barWidth: 6,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      // lineChartBarData1,
      // lineChartBarData2,
      lineChartBarData3,
    ];
  }
}
