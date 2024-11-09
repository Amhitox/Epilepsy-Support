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
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Profile
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello,',
                              style: TextStyle(
                                fontSize: 16,
                                color: theme.colorScheme.onPrimary.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              'Sir Amhita',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: theme.colorScheme.onPrimary.withOpacity(0.2),
                          child: Icon(Icons.person, color: theme.colorScheme.onPrimary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Quick Actions
              Container(
                height: 120,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildQuickActionCard(
                      context,
                      icon: Icons.add_circle_outline,
                      title: 'Record\nSeizure',
                      onTap: () => widget.onScreenChange(2),
                    ),
                    _buildQuickActionCard(
                      context,
                      icon: Icons.medication_outlined,
                      title: 'Add\nMedication',
                      onTap: () => widget.onScreenChange(1),
                    ),
                    _buildQuickActionCard(
                      context,
                      icon: Icons.contact_phone_outlined,
                      title: 'Emergency\nContacts',
                      onTap: () => widget.onScreenChange(3),
                    ),
                    _buildQuickActionCard(
                      context,
                      icon: Icons.note_add_outlined,
                      title: 'Add\nNotes',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              // Stats Overview
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        'Today\'s\nSeizures',
                        '2',
                        Icons.warning_amber_rounded,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        'Medications\nTaken',
                        '3/4',
                        Icons.medication,
                      ),
                    ),
                  ],
                ),
              ),

              // Activity Chart
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weekly Activity',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 200,
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
                      ],
                    ),
                  ),
                ),
              ),

              // Upcoming Medications
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upcoming Medications',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildMedicationItem(context, 'Medication A', '9:00 AM'),
                    _buildMedicationItem(context, 'Medication B', '2:00 PM'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 100,
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 15),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicationItem(
    BuildContext context,
    String name,
    String time,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
          child: Icon(Icons.medication, color: Theme.of(context).colorScheme.onBackground),
        ),
        title: Text(name),
        subtitle: Text(time),
        trailing: IconButton(
          icon: const Icon(Icons.check_circle_outline),
          onPressed: () {},
        ),
      ),
    );
  }
}
