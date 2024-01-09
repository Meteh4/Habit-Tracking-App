import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitinn/components/habit_tile.dart';
import 'package:habitinn/components/month_summary.dart';
import 'package:habitinn/components/my_alert_dialog.dart';
import 'package:habitinn/components/my_floating_action_button.dart';
import 'package:habitinn/data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");
  final HabitDatabase habitDatabase = HabitDatabase();
  late ConfettiController _confettiController;

  Future<void> downloadDataFromFirestore() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Use the current user's UID
        DocumentSnapshot<Map<String, dynamic>> userData =
        await firestore.collection('users').doc(user.uid).get();

        // Rest of your code remains unchanged
        List<dynamic> habitsFromFirestore = userData['habits'];

        // Append habitsFromFirestore to db.todaysHabitList
        db.todaysHabitList.addAll(habitsFromFirestore.map((habit) {
          return [
            habit['name'],
            habit['completed'],
            habit['time'],
            habit['counterName'],
            habit['counter'],
            habit['counterGoal'],
            habit['monday'],
            habit['tuesday'],
            habit['wednesday'],
            habit['thursday'],
            habit['friday'],
            habit['saturday'],
            habit['sunday'],

          ];
        }));

        db.updateDatabase();
        setState(() {});
      } else {
        print('User not logged in');
      }
    } catch (e) {
      print('Firestore veri indirme hatası: $e');
    }
  }


  Future<void> saveDataToFirestore() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await firestore.collection('users').doc(user.uid).set({
          'habits': db.todaysHabitList.map((habit) => {
            'name': habit[0],
            'completed': habit[1],
            'time': habit[2],
            'counterName': habit[3],
            'counter': habit[4],
            'counterGoal': habit[5],
            'monday': habit[6],
            'tuesday': habit[7],
            'wednesday': habit[8],
            'thursday': habit[9],
            'friday': habit[10],
            'saturday': habit[11],
            'sunday': habit[12],
          }).toList(),
        });
      } else {
        print('User not logged in');
      }
    } catch (e) {
      print('Firestore veri kaydetme hatası: $e');
    }
  }

  @override
  void dispose() {
    _confettiController.dispose(); // Confetti Controller'ı temizle
    super.dispose();
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      addSelectedHabitsForTodayAndRemoveFromAll();
      removeAddedHabitsFromToday();
      print("Functions executed at: ${DateTime.now()}");
      print(db.allHabitsList);
      print(db.todaysHabitList);
      db.updateDatabase();
    });
    monday = true;
    tuesday = true;
    wednesday = true;
    thursday = true;
    friday = true;
    saturday = true;
    sunday = true;
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
      downloadDataFromFirestore().then((_) {
        saveDataToFirestore();
      });
    } else {
      db.loadData();
    }

    db.updateDatabase();

    super.initState();
  }

  bool areAllHabitsCompleted() {
    return db.todaysHabitList.every((habit) => habit[1] == true);
  }

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      if (value != null) {
        db.todaysHabitList[index][1] = value;

        int habitCT = db.todaysHabitList[index][4];
        int habitCTFinal = db.todaysHabitList[index][5];

        if (db.todaysHabitList[index][1]) {
          db.todaysHabitList[index][4] = db.todaysHabitList[index][5];
        } else {
          db.todaysHabitList[index][4] = db.todaysHabitList[index][5] - 1;
        }
      }

      // Check if all habits are completed
      if (areAllHabitsCompleted()) {
        // Trigger confetti explosion
        _confettiController.play();
      }

      db.updateDatabase();
      saveDataToFirestore();
    });
  }

  void mondayTapped(){
    setState(() {
      monday = !monday;
    });
  }

  void tuesdayTapped(){
    setState(() {
      tuesday = !tuesday;
    });
  }

  void wednesdayTapped(){
    setState(() {
      wednesday = !wednesday;
    });
  }

  void thursdayTapped(){
    setState(() {
      thursday = !thursday;
    });
  }

  void fridayTapped(){
    setState(() {
      friday = !friday;
    });
  }

  void saturdayTapped(){
    setState(() {
      saturday = !saturday;
    });
  }

  void sundayTapped(){
    setState(() {
      sunday = !sunday;
    });
  }
  void addSelectedHabitsForTodayAndRemoveFromAll() {
    DateTime today = DateTime.now();
    int currentDay = today.weekday;
    List<List<dynamic>> habitsToRemove = [];

    for (int i = 0; i < db.allHabitsList.length; i++) {
      if (db.allHabitsList[i][currentDay + 5]) {
        db.todaysHabitList.add(db.allHabitsList[i]);
        habitsToRemove.add(db.allHabitsList[i]);
      }
    }

    for (var habit in habitsToRemove) {
      db.allHabitsList.remove(habit);
    }
  }

  void removeAddedHabitsFromToday() {
    DateTime today = DateTime.now();
    int currentDay = today.weekday;
    List<List<dynamic>> habitsToRemove = [];

    for (int i = 0; i < db.todaysHabitList.length; i++) {
      if (!db.todaysHabitList[i][currentDay + 5]) {
        db.allHabitsList.add(db.todaysHabitList[i]);
        habitsToRemove.add(db.todaysHabitList[i]);
      }
    }

    // HabitsToRemove listesindeki habitleri db.todaysHabitList'ten çıkar
    for (var habit in habitsToRemove) {
      db.todaysHabitList.remove(habit);
    }
  }


  void incrementHabitCT(int index) {
    setState(() {
      int habitCT = db.todaysHabitList[index][4];
      int habitCTFinal = db.todaysHabitList[index][5];

      if (habitCT < habitCTFinal) {
        db.todaysHabitList[index][4]++;
        db.updateDatabase();
        saveDataToFirestore();
      }
    });
  }

  void decrementHabitCT(int index) {
    setState(() {
      int habitCT = db.todaysHabitList[index][4];

      if (habitCT > 0) {
        db.todaysHabitList[index][4]--;
        db.updateDatabase();
        saveDataToFirestore();
      }
    });
  }


  final _newHabitNameController = TextEditingController();
  final _habitTimeController = TextEditingController();
  final _habitCTNameController = TextEditingController();
  final _habitCTFController = TextEditingController();
  late bool sunday;
  late bool monday;
  late bool tuesday;
  late bool wednesday;
  late bool thursday;
  late bool friday;
  late bool saturday;


  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context){
          return MyAlertBox(
            habitNameController: _newHabitNameController,
            habitTimeController: _habitTimeController,
            habitCTNameController: _habitCTNameController,
            habitCTFController: _habitCTFController,
            onSave: saveNewHabit,
            onCancel: cancelDialogBox,
            namehText: 'Enter Habit Name',
            hTimehText: 'Enter Your Habit Time',
            ctNameText: 'Enter Your Counter Name If You Have',
            habitCTFText: 'Enter Your Counter Goal If You Have',
            monday: monday,
            tuesday: tuesday,
            wednesday: wednesday,
            thursday: thursday,
            friday: friday,
            saturday: saturday,
            sunday: sunday,
            monTapped: mondayTapped,
            tueTapped: tuesdayTapped,
            wedTapped: wednesdayTapped,
            thurTapped:thursdayTapped,
            friTapped: fridayTapped,
            satTapped: saturdayTapped,
            sunTapped: sundayTapped,
          );
        });
  }

  void saveNewHabit(){
    setState(() {
      String habitCTimeText = _habitCTFController.text;
      if (_habitCTFController.text.isEmpty ) {
        _habitCTFController.text = '0';
      }
      int habitCTF = int.tryParse(habitCTimeText) ?? 0;
      print("habitCTimeText: $habitCTimeText");
      db.allHabitsList.add(
          [_newHabitNameController.text, false, _habitTimeController.text, _habitCTNameController.text, 0, habitCTF,monday,tuesday,wednesday,thursday,friday,saturday,sunday]);
      db.updateDatabase();
      print(db.allHabitsList);
      print(db.todaysHabitList);
      addSelectedHabitsForTodayAndRemoveFromAll();
      removeAddedHabitsFromToday();
    });

    print("sunday: $sunday");

    _newHabitNameController.clear();
    _habitTimeController.clear();
    _habitCTNameController.clear();
    _habitCTFController.clear();
    monday = true;
    tuesday = true;
    wednesday = true;
    thursday = true;
    friday = true;
    saturday = true;
    sunday = true;
    db.updateDatabase();
    saveDataToFirestore();
    print(db.allHabitsList);
    print(db.todaysHabitList);
    Navigator.of(context).pop();
  }


  void cancelDialogBox(){
    monday = true;
    tuesday = true;
    wednesday = true;
    thursday = true;
    friday = true;
    saturday = true;
    sunday = true;
    _newHabitNameController.clear();
    _habitTimeController.clear();
    _habitCTNameController.clear();
    _habitCTFController.clear();
    db.updateDatabase();
    Navigator.of(context).pop();
  }

  void openHabitSettings(int index) {

    showDialog(context: context, builder: (context){
      return MyAlertBox(
        onSave: () => saveExistingHabit(index),
        onCancel: cancelDialogBox,
        habitNameController: _newHabitNameController,
        habitTimeController: _habitTimeController,
        habitCTNameController: _habitCTNameController,
        habitCTFController: _habitCTFController,
        namehText: db.todaysHabitList[index][0],
        hTimehText: db.todaysHabitList[index][2],
        ctNameText: db.todaysHabitList[index][3],
        habitCTFText: db.todaysHabitList[index][5].toString(),
        monday: db.todaysHabitList[index][6],
        tuesday: db.todaysHabitList[index][7],
        wednesday: db.todaysHabitList[index][8],
        thursday: db.todaysHabitList[index][9],
        friday: db.todaysHabitList[index][10],
        saturday: db.todaysHabitList[index][11],
        sunday: db.todaysHabitList[index][12],
        monTapped: mondayTapped,
        tueTapped: tuesdayTapped,
        wedTapped: wednesdayTapped,
        thurTapped: thursdayTapped,
        friTapped: fridayTapped,
        satTapped: saturdayTapped,
        sunTapped: sundayTapped,


      );
    }
    );
  }

  void saveExistingHabit(int index){
    setState(() {
      String habitCTimeText = _habitCTFController.text;
      int habitCTF = int.tryParse(habitCTimeText) ?? 0;
      db.todaysHabitList[index][0] = _newHabitNameController.text;
      db.todaysHabitList[index][2] = _habitTimeController.text;
      db.todaysHabitList[index][3] = _habitCTNameController.text;
      db.todaysHabitList[index][5] = habitCTF;
      db.todaysHabitList[index][6] = monday;
      db.todaysHabitList[index][7] = tuesday;
      db.todaysHabitList[index][8] = wednesday;
      db.todaysHabitList[index][9] = thursday;
      db.todaysHabitList[index][10] = friday;
      db.todaysHabitList[index][11] = saturday;
      db.todaysHabitList[index][12] = sunday;
      db.updateDatabase();
      addSelectedHabitsForTodayAndRemoveFromAll();
      removeAddedHabitsFromToday();
      saveDataToFirestore();
      Navigator.of(context).pop();
    });
  }

  void deleteHabit(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Delete Habit'),
          content: Text('Do you want to delete this habit from your backups?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Perform deletion without saving to Firestore
                setState(() {
                  db.todaysHabitList.removeAt(index);
                  db.updateDatabase();
                });
              },
              child: Text('No, just delete'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                // Perform deletion and save changes to Firestore
                setState(() {
                  db.todaysHabitList.removeAt(index);
                  db.updateDatabase();
                  saveDataToFirestore();
                });
              },
              child: Text('Yes, delete from backups too'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Center(
      child: ConfettiWidget(
        confettiController: _confettiController,
        blastDirection: -pi / 300, // Adjust as needed
        particleDrag: 0.05, // Adjust as needed
        emissionFrequency: 0.05, // Adjust as needed
        numberOfParticles: 20, // Adjust as needed
        gravity: 1, // Adjust as needed
        shouldLoop: false, // Set to true if you want continuous confetti
        colors: const [Color(0xFF000080),], // Adjust as needed
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0XFFD5DEEF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            title: const Text(
              'HabitiN',
              textAlign: TextAlign.center,
            ),
          ),
          resizeToAvoidBottomInset: false,
          floatingActionButton: MyFloatingActionButton(
            onPressed: () => createNewHabit(),
          ),
          backgroundColor: Color(0XFFEBEFF5),
          body: ListView(
            children: [
              MonthlySummary(
                datasets: db.heatMapDataSet,
                startDate: _myBox.get("START_DATE"),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0XFFD5DEEF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24), ),
                ),
                child: Column(
                  children:[
                     Padding(
                      padding: EdgeInsets.fromLTRB(20, 12, 0, 0),
                      child: Row(children: [
                        Text("Today's Habits : "),
                        Text(
                          '${db.todaysHabitList.where((habit) => habit[1] == true).length}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('/'),
                        Text('${db.todaysHabitList.length}'),
                      ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(6),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: db.todaysHabitList.length,
                            itemBuilder: (context, index) {
                              return HabitTile(
                                habitName: db.todaysHabitList[index][0],
                                habitCompleted: db.todaysHabitList[index][1],
                                onChanged: (value) => checkBoxTapped(value, index),
                                habitTime: db.todaysHabitList[index][2],
                                habitCTName: db.todaysHabitList[index][3],
                                habitCT: db.todaysHabitList[index][4],
                                habitCTFinal: db.todaysHabitList[index][5],
                                settingsTapped: (context) => openHabitSettings(index),
                                deleteTapped: (context) => deleteHabit(index),
                                incrementHabitCT: incrementHabitCT,
                                decrementHabitCT: decrementHabitCT,
                                index: index,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}