import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatefulWidget {
  final String habitName;
  final String habitTime;
  final String habitCTName;
  late int habitCT;
  final int index;
  final int habitCTFinal;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;
  final Function(int)? incrementHabitCT;
  final Function(int)? decrementHabitCT;

  HabitTile({
    Key? key,
    required this.habitName,
    required this.habitTime,
    required this.habitCTName,
    required this.habitCT,
    required this.habitCTFinal,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingsTapped,
    required this.deleteTapped,
    required this.incrementHabitCT,
    required this.decrementHabitCT,
    required this.index,
  }) : super(key: key);

  @override
  _HabitTileState createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {


  Color calculateColor() {
    double percentage = widget.habitCT / widget.habitCTFinal;
    return Color.lerp(Colors.grey[200]!, const Color(0xFF628ECB), percentage) ?? Colors.grey[200]!;
  }

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
            color: calculateColor(),
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
              Container(
                width: 20,
                height: 70,
                child: Checkbox(
                  activeColor: Color(0XFFD5DEEF),
                  checkColor: Color(0xFF395886),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(color: Color(0xFF395886),),
                  ),
                  value: widget.habitCompleted,
                  onChanged: widget.onChanged,
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
                          decoration: widget.habitCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
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
                        IconButton(
                          icon: const Icon(Icons.arrow_upward),
                          onPressed: () {
                            setState(() {
                              widget.incrementHabitCT!(widget.index);

                              if (widget.habitCT == widget.habitCTFinal - 1) {
                                widget.onChanged!(true);
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_downward),
                          onPressed: () {
                            setState(() {
                              widget.decrementHabitCT!(widget.index);
                              if (widget.habitCT == widget.habitCTFinal) {
                                widget.onChanged!(false);
                              }
                            });
                          },
                        ),
                      ]
                    ],
                  )
                ],
              ),
              Icon(
                Icons.chevron_left_rounded,
                color: widget.habitCompleted
                    ? const Color(0XFFE9F5DB)
                    : Colors.grey[600],
              ),
            ],
          ),
        ),
      ),
    );
  }
}