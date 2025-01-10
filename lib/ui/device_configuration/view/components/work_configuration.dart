import 'package:flutter/material.dart';

class WorkConfiguration extends StatefulWidget {
  const WorkConfiguration({super.key, this.onChanged});
  final void Function(int hour, int minute)? onChanged;
  @override
  State<WorkConfiguration> createState() => _WorkConfigurationState();
}

class _WorkConfigurationState extends State<WorkConfiguration> {
  int hour = 0;
  int minute = 0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Column(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: constraints.maxWidth * .01,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              hour++;
                              widget.onChanged?.call(hour, minute);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromRGBO(16, 38, 148, 1)),
                            child: Center(
                              child: Icon(
                                color: Colors.white,
                                Icons.add,
                                size: constraints.maxHeight * .2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                              child: Text(
                            hour.toString(),
                            style:
                                TextStyle(fontSize: constraints.maxHeight * .2),
                          )),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (hour <= 0) {
                                hour = hour;
                              } else {
                                hour--;
                              }
                              widget.onChanged?.call(hour, minute);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromRGBO(16, 38, 148, 1)),
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: constraints.maxHeight * .2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (minute >= 59) {
                                minute = 0;
                              } else {
                                minute++;
                              }
                              widget.onChanged?.call(hour, minute);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromRGBO(16, 38, 148, 1)),
                            child: Center(
                              child: Icon(
                                color: Colors.white,
                                Icons.add,
                                size: constraints.maxHeight * .2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                              child: Text(
                            minute.toString(),
                            style:
                                TextStyle(fontSize: constraints.maxHeight * .2),
                          )),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (minute <= 0) {
                                minute = 59;
                              } else {
                                minute--;
                              }
                              widget.onChanged?.call(hour, minute);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromRGBO(16, 38, 148, 1)),
                            child: Center(
                              child: Icon(
                                color: Colors.white,
                                Icons.remove,
                                size: constraints.maxHeight * .2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                "Çalışma Süresi: $hour saat $minute dakika",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )))
        ],
      ),
    );
  }
}
