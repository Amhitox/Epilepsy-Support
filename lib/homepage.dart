import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
 final Function(int) onScreenChange;

  const HomePage({super.key,required this.onScreenChange});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  final SearchController controller = SearchController();

  List <bool> toggls = <bool>[
    false,true,false
  ];

  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // Repeat the animation back and forth
  }
   @override
  void dispose() {
    _controller.dispose(); // Dispose controller when not in use
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Align(alignment: Alignment(-1, -0.7),child: Padding(padding: EdgeInsets.all(10),child: Text('Welcome back, User!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
              const SizedBox(height: 15),
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, left: 25.0, right: 25.0, bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        offset: const Offset(12, 26),
                        blurRadius: 50,
                        spreadRadius: 0,
                        color: Colors.grey.withOpacity(.1)),
                  ]),
                  child: TextField(
                    onChanged: (value) {
                      
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Card(
                color: Colors.deepPurple,
                elevation: 5,
                child: SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(padding: const EdgeInsets.all(3),margin: const EdgeInsets.fromLTRB(25, 5, 15, 0),decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.white)),child: Image.asset('assets/images/brain_icon.png',width: MediaQuery.of(context).size.width * 0.15,)),
                          //const SizedBox(width: 10,),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Total Seizures',style: TextStyle(fontSize: 24,color: Colors.white),),
                              SizedBox(height: 5),
                              Text('States about seizures',style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w100),),
                            ],
                          )
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width*0.6,child: const Divider(thickness: 0.7,)),
                      //const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(padding: const EdgeInsets.all(3),margin: const EdgeInsets.fromLTRB(15, 5, 15, 0),child: const Text('30',style: TextStyle(fontSize: 23,color: Colors.white))),
                          SizedBox(width: MediaQuery.of(context).size.width*0.5),
                          IconButton(onPressed: () {
                            //navigate to Seizures page
                          },icon: const Icon(Icons.arrow_forward),color: Colors.white,),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.white,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Column(
                    children: [
                      Container(margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),child: const Align(alignment: Alignment.centerLeft,child: Text('Seizure Activity',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),))),
                      const SizedBox(height: 5),
                      ToggleButtons(
                        isSelected: toggls,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Week'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Month'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('All Time'),
                          ),
                        ],
                        onPressed: (int index) {
                          setState(() {
                            // The button that is tapped is set to true, and the others to false.
                            for (int i = 0; i < toggls.length; i++) {
                              toggls[i] = i == index;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16), // Add padding for some spacing
                          child: LineChart(
                            LineChartData(
                              borderData: FlBorderData(show: false), // Hide borders
                              gridData: const FlGridData(show: false), // Hide grid lines
                              titlesData: FlTitlesData(
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false), // Hide top titles
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false), // Hide right titles
                                ),
                                leftTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false), // Hide left titles
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    interval: 1,
                                    showTitles: true, // Show bottom titles (days of the week)
                                    getTitlesWidget: (value, meta) {
                                      const style = TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      );
                                      
                                      Widget text;
                                      switch (value.toInt()) {
                                        case 0:
                                          text = const Text('Mon', style: style);
                                          break;
                                        case 1:
                                          text = const Text('Tue', style: style);
                                          break;
                                        case 2:
                                          text = const Text('Wed', style: style);
                                          break;
                                        case 3:
                                          text = const Text('Thu', style: style);
                                          break;
                                        case 4:
                                          text = const Text('Fri', style: style);
                                          break;
                                        case 5:
                                          text = const Text('Sat', style: style);
                                          break;
                                        case 6:
                                          text = const Text('Sun', style: style);
                                          break;
                                        default:
                                          text = const Text('');
                                          break;
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 2.0,left: 4,right: 4), // Space above labels
                                        child: Align(
                                          alignment: Alignment.center, // Center the label
                                          child: text,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  isCurved: true,
                                  dotData: const FlDotData(show: true), // Show dots
                                  spots: const [
                                    FlSpot(0, 2),
                                    FlSpot(1, 2.5),
                                    FlSpot(2, 3),
                                    FlSpot(3, 2.8),
                                    FlSpot(4, 3.2),
                                    FlSpot(5, 2.9),
                                    FlSpot(6, 3.5),
                                  ],
                                  barWidth: 3,
                                  isStrokeCapRound: true,
                                  color: Colors.purple, // Purple line color
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Column(
                    children: [
                      Text('Swipe left to ',style: TextStyle(fontSize: 18,color: Colors.black)),
                      Text('join our comunity ...',style: TextStyle(fontSize: 18,color: Colors.black)),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.15),
                  AnimatedBuilder(animation: _controller, builder: (context,child){
                    return Transform.translate(offset: Offset(20 * _controller.value,0),child: child);
                  },
                  child: const Icon(Icons.arrow_forward,color: Colors.deepPurple,size: 50,)
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
