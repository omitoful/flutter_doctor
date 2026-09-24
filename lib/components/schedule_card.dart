import 'package:flutter/material.dart';
import 'package:flutter_doctor/utils/config.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.isHome});
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isHome ? Colors.grey : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.calendar_today,
            color: isHome ? Colors.white : Config.primaryColor,
            size: 15,
          ),
          SizedBox(width: 5),
          Text(
            'Monday, 11/28/2022',
            style: TextStyle(color: isHome ? Colors.white : Config.primaryColor),
          ),
          SizedBox(width: 20),
          Icon(
            Icons.access_alarm,
            color: isHome ? Colors.white : Config.primaryColor,
            size: 17,
          ),
          SizedBox(width: 5),
          Flexible(
            child: Text(
              '2:00 PM',
              style: TextStyle(color: isHome ? Colors.white : Config.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
