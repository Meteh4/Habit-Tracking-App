import 'package:flutter/material.dart';
import 'package:weekday_selector/weekday_selector.dart';

class MyAlertBox extends StatefulWidget {
  final TextEditingController habitNameController;
  final TextEditingController habitTimeController;
  final TextEditingController habitCTNameController;
  final TextEditingController habitCTFController;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String namehText;
  final String hTimehText;
  final String ctNameText;
  final String habitCTFText;
  late bool monday;
  late bool tuesday;
  late bool wednesday;
  late bool thursday;
  late bool friday;
  late bool saturday;
  late bool sunday;
  final Function monTapped;
  final Function tueTapped;
  final Function wedTapped;
  final Function thurTapped;
  final Function friTapped;
  final Function satTapped;
  final Function sunTapped;


  MyAlertBox({
    Key? key,
    required this.onSave,
    required this.onCancel,
    required this.habitNameController,
    required this.habitTimeController,
    required this.habitCTNameController,
    required this.habitCTFController,
    required this.namehText,
    required this.hTimehText,
    required this.ctNameText,
    required this.habitCTFText,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
    required this.wedTapped,
    required this.monTapped,
    required this.tueTapped,
    required this.thurTapped,
    required this.friTapped,
    required this.satTapped,
    required this.sunTapped,
  }) : super(key: key);

  @override
  _MyAlertBoxState createState() => _MyAlertBoxState();
}

class _MyAlertBoxState extends State<MyAlertBox> {
  bool isCheckboxChecked = false;
  late Widget _weekdaySelector;


  @override
  void initState() {
    super.initState();
    widget.habitCTFController.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: widget.habitNameController,
              decoration: InputDecoration(
                hintText: widget.namehText,
                enabledBorder:
                const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                focusedBorder:
                const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (selectedTime != null) {
                  String formattedTime = selectedTime.format(context);
                  widget.habitTimeController.text = formattedTime;
                } else {
                  widget.habitTimeController.text = '00:00';
                }
              },
              child: AbsorbPointer(
                absorbing: true,
                child: TextField(
                  controller: widget.habitTimeController,
                  decoration: InputDecoration(
                    hintText: widget.hTimehText,
                    enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            WeekdaySelector(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              selectedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              selectedColor: const Color(0XFFEBEFF5),
              selectedFillColor: const Color(0xFF395886),
              selectedFocusColor: const Color(0xFF395886),
              color: const Color(0XFFEBEFF5),
              onChanged: (int? day) {
                if (day != null) {
                  setState(() {
                    switch (day % 7) {
                      case 0:
                        widget.sunTapped();
                        widget.sunday = !widget.sunday;
                        break;
                      case 1:
                        widget.monTapped();
                        widget.monday = !widget.monday;
                        break;
                      case 2:
                        widget.tueTapped();
                        widget.tuesday = !widget.tuesday;
                        break;
                      case 3:
                        widget.wedTapped();
                        widget.wednesday = !widget.wednesday;
                        break;
                      case 4:
                        widget.thurTapped();
                        widget.thursday = !widget.thursday;
                        break;
                      case 5:
                        widget.friTapped();
                        widget.friday = !widget.friday;
                        break;
                      case 6:
                        widget.satTapped();
                        widget.saturday = !widget.saturday;
                        break;
                    }
                  });
                }
              },
              values: [
                widget.sunday,
                widget.monday,
                widget.tuesday,
                widget.wednesday,
                widget.thursday,
                widget.friday,
                widget.saturday,

              ],
            ),
            if (isCheckboxChecked)
              Column(
                children: [
                  TextField(
                    controller: widget.habitCTNameController,
                    decoration: InputDecoration(
                      hintText: widget.ctNameText,
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: widget.habitCTFController,
                    decoration: InputDecoration(
                      hintText: widget.habitCTFText,
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: isCheckboxChecked,
                  onChanged: (value) {
                    setState(() {
                      isCheckboxChecked = value!;
                      // Set the default value of habitCTFController to '0' when the checkbox is checked
                      if (isCheckboxChecked) {
                        widget.habitCTFController.text = '1';
                      }
                    });
                  },
                ),
                const Text('Make your activity countable',
                textScaleFactor: 0.9,),
              ],
            ),
          ],
        ),
      ),
      actions: [
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onPressed: () {
            if (widget.habitNameController.text.isEmpty) {
              widget.habitNameController.text = '0';
            }
            if (widget.habitTimeController.text.isEmpty) {
              widget.habitTimeController.text = '00:00';
            }
            widget.onSave();
          },
          color: Colors.green,
          child: const Text("Save"),
        ),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onPressed: widget.onCancel,
          color: Colors.red,
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
