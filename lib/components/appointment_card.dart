import 'package:flutter/material.dart';
import 'package:flutter_doctor/components/schedule_card.dart';
import 'package:flutter_doctor/main.dart';
import 'package:flutter_doctor/providers/dio_provider.dart';
import 'package:flutter_doctor/utils/config.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key, required this.doctor});
  final Map<String, dynamic> doctor;

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Config.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.doctor['doctor_profile'] ?? ''),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctor['doctor_name'] ?? 'Doctor',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 2),
                      Text(
                        widget.doctor['category'] ?? '',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              context.spaceSmall,
              ScheduleCard(
                isHome: true,
                date: widget.doctor['appointments']['date'] ?? '',
                day: widget.doctor['appointments']['day'] ?? '',
                time: widget.doctor['appointments']['time'] ?? '',
              ),
              context.spaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {},
                      child: Text('Cancel', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return RatingDialog(
                              initialRating: 1.0,
                              title: Text(
                                'Rate the Doctor',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              message: Text(
                                'Please help us to rate our Doctor',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                              ),
                              image: FlutterLogo(size: 100),
                              submitButtonText: 'Submit',
                              commentHint: 'Your Reviews',
                              onSubmitted: (response) async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                final token = prefs.getString('token') ?? '';
                                final result = await DioProvider().storeReviews(
                                  response.comment,
                                  response.rating,
                                  widget.doctor['appointments']['id'],
                                  widget.doctor['doc_id'],
                                  token,
                                );

                                if (result == 200) {
                                  MyApp.navigatorKey.currentState!
                                      .pushNamedAndRemoveUntil('main', (route) => false);
                                }
                              },
                            );
                          },
                        );
                      },
                      child: Text('Complete', style: TextStyle(color: Colors.white)),
                    ),
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
