import 'package:app/CountriesList.dart';
import 'package:app/Model/worldStatesmodel.dart';
import 'package:app/Servicrs/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class Worldstates extends StatefulWidget {
  const Worldstates({super.key});

  @override
  State<Worldstates> createState() => _WorldstatesState();
}

class _WorldstatesState extends State<Worldstates>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: 20),

                // ---------------- FUTURE BUILDER -----------------
                FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(),
                  builder: (context,
                      AsyncSnapshot<worldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SpinKitCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                        ),
                      );
                    }

                    return Column(
                      children: [
                        // ----------- ONLY ONE PIE CHART ------------
                        Center(
                          child: SizedBox(
                            height: 250,
                            width: 250,
                            child: PieChart(
                              dataMap: {
                                "Total": double.parse(
                                    snapshot.data!.cases.toString()),
                                "Recovered": double.parse(
                                    snapshot.data!.recovered.toString()),
                                "Deaths": double.parse(
                                    snapshot.data!.deaths.toString()),
                                    
                              },
                              animationDuration:
                                  Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true),
                              colorList: colorList,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // ----------- DETAILS CARD ------------
                        Card(
                          child: Column(
                            children: [
                              ReusableRow(
                                title: 'Total Cases',
                                value: snapshot.data!.cases.toString(),
                              ),
                              ReusableRow(
                                title: 'Recovered',
                                value: snapshot.data!.recovered.toString(),
                              ),
                              ReusableRow(
                                title: 'Deaths',
                                value: snapshot.data!.deaths.toString(),
                              ),
                              ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                               ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString(),),
                                ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                 ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        ),

                        SizedBox(height: 30),

                        // ----------- BUTTON ------------
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context) {
                              return Countrieslist();
                            },));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(171, 76, 175, 79),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Track Countries",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}
