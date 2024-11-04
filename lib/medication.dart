import 'package:flutter/material.dart';


class MedicationReminder extends StatefulWidget {
   final Function(int) onScreenChange;

  const MedicationReminder({super.key,required this.onScreenChange});

  @override
  State<MedicationReminder> createState() => _MedicationReminderState();
}

class _MedicationReminderState extends State<MedicationReminder> {
  int selectedIndex = DateTime.now().weekday+2; // Default selected index for today
  // Function to get the current week's dates starting from Sunday
  List<DateTime> getWeekDates() {
    DateTime today = DateTime.now();
    return List.generate(7, (index) {
      int offset = index - 3; // Center around today
      return today.add(Duration(days: offset));
    });
  }

    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _dosageController = TextEditingController();
    final TextEditingController _timeController = TextEditingController();

  
  late final List<GlobalKey> _cardKeys ;
int _medccount = 0;
  late List<Map<String, dynamic>> _storemeds;
  void addMedication(){
    setState(() {
      _storemeds.add({
        'name': _nameController.text,
        'dosage': int.tryParse(_dosageController.text) ?? 0,
        'time': _timeController.text,
      });
      _medccount++;

      _cardKeys.add(GlobalKey());
      _nameController.clear();
      _dosageController.clear();
      _timeController.clear();
    });
  }
  @override
  void dispose(){
    _nameController.dispose();
    _dosageController.dispose();
    _timeController.dispose();
    super.dispose();
  }

 

   @override
  void initState() {
    super.initState();
    _initializeCardKeys();
  }

  void _initializeCardKeys() {
    _cardKeys = List.generate(_medccount, (index) => GlobalKey());
    _storemeds = List.generate(_medccount, (index) => {});
  }
  void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 400),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add Medication',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Medication Name',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.medication, color: Colors.purple),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _dosageController,
                  decoration: InputDecoration(
                    labelText: 'Dosage',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.scale, color: Colors.purple),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      _timeController.text = pickedTime.format(context);
                    }
                  },
                  child:const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time, color: Colors.purple),
                      SizedBox(width: 8),
                      Text(
                        'Select Time',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          addMedication();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    List<DateTime> weekDates = getWeekDates();
    List<String> daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"];

    return Scaffold(
      body:SafeArea(
        child: SingleChildScrollView(
              child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(weekDates.length, (index) {
                      bool isSelected = index == selectedIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              daysOfWeek[index],
                              style: const TextStyle(
                                color: Colors.purple,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.brown : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                weekDates[index].day.toString(),
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                const Divider(color: Colors.white,thickness: 4,),
                const SizedBox(height: 20,),
                const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Text('Time',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                  SizedBox(width: 50,),
                  Text('Medication',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                  SizedBox(width: 50,),
                  ],
                ),
                const SizedBox(height: 20,),
                Column(
                  children: [
                    ...List.generate(_medccount, (index) => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(_storemeds[index]['time'],style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                            )
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const VerticalDivider(
                          width: 5,
                          color: Colors.pink,
                          ),
                        ),
                        Card(
                          key: _cardKeys[index],
                          color: Colors.white,
                          elevation: 10,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: IconButton(
                                      onPressed: () {
                                          final RenderBox renderBox = _cardKeys[index].currentContext!.findRenderObject() as RenderBox;
                                          final Offset offset = renderBox.localToGlobal(Offset.zero);
                                          const double buttonWidth = 48.0; // Approximate width of the IconButton
                                          final RelativeRect position = RelativeRect.fromLTRB(
                                            offset.dx + renderBox.size.width - buttonWidth, // Align to the right edge of the card
                                            offset.dy,
                                            offset.dx + renderBox.size.width,
                                            offset.dy + renderBox.size.height,
                                          );
                                        showMenu(
                                          context: context,
                                          position: position,
                                          items: [
                                            PopupMenuItem(
                                              value: 'edit',
                                              child: const Text('Edit'),
                                              onTap: () {},
                                            ),
                                            PopupMenuItem(
                                              value: 'delete',
                                              child: const Text('Delete'),
                                              onTap: () {},
                                            ),
                                          ],
                                        );
                                      },
                                      icon: const Icon(Icons.more_vert, color: Colors.black,),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        Text(_storemeds[index]['name']  ,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                        Text('Dosage : ${_storemeds[index]['dosage']} mg',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                        const Text('Frequency : 2 times a day',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                      ]
                                    ),
                                  )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                  ]
                )
              ],
            ),
          ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){showCustomDialog(context);},child: const Icon(Icons.add),),
    );
  }
}

