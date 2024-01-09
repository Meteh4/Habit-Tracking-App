import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ScheduledHabitTile extends StatefulWidget {
  final String habitName;
  final String habitTime;
  final String habitCTName;
  late int habitCT;
  final int index;
  final int habitCTFinal;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;
  final Function(int)? incrementHabitCT;
  final Function(int)? decrementHabitCT;
  late bool monday ;
  late bool tuesday ;
  late bool wednesday ;
  late bool thursday ;
  late bool friday ;
  late bool saturday ;
  late bool sunday ;


  ScheduledHabitTile({
    Key? key,
    required this.habitName,
    required this.habitTime,
    required this.habitCTName,
    required this.habitCT,
    required this.habitCTFinal,
    required this.settingsTapped,
    required this.deleteTapped,
    required this.incrementHabitCT,
    required this.decrementHabitCT,
    required this.index,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  }) : super(key: key);

  @override
  _ScheduledHabitTileState createState() => _ScheduledHabitTileState();
}

class _ScheduledHabitTileState extends State<ScheduledHabitTile> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.settingsTapped,
              backgroundColor: Color(0xFF395886),
              icon: Icons.edit,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12),),
            ),
            SlidableAction(
              onPressed: widget.deleteTapped,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12), ),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white54,
            boxShadow: [
              BoxShadow(
                color: Color(0xFF395886).withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Container(
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.habitName,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('"' '${widget.habitTime}' '"' ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (widget.habitCTFinal > 1) ...[
                        Text('${widget.habitCTName}'":"'${widget.habitCT}'" of "'${widget.habitCTFinal}'),
                      ]
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (widget.monday == true) ...[
                            Text('mon '),
                          ],
                          if (widget.tuesday == true) ...[
                            Text('tue '),
                          ],
                          if (widget.wednesday == true) ...[
                            Text('wed '),
                          ],
                          if (widget.thursday == true) ...[
                            Text('thur '),
                          ],
                          if (widget.friday == true) ...[
                            Text('fri '),
                          ],
                          if (widget.saturday == true) ...[
                            Text('sat '),
                          ],
                          if (widget.sunday == true) ...[
                            Text('sun'),
                          ]
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.chevron_left_rounded,
                color:Colors.grey[600],
              ),
            ],
          ),
        ),
      ),
    );
  }
}