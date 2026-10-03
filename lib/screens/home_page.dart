import 'package:flutter/material.dart';
import 'package:flutter_doctor/components/appointment_card.dart';
import 'package:flutter_doctor/components/doctor_card.dart';
import 'package:flutter_doctor/models/auth_model.dart';
import 'package:flutter_doctor/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> user = {};
  Map<String, dynamic> doctor = {};
  List<dynamic> favList = [];
  List<Map<String, dynamic>> medCat = [
    {"icon": FontAwesomeIcons.userDoctor, "category": "General"},
    {"icon": FontAwesomeIcons.heartPulse, "category": "Cardiology"},
    {"icon": FontAwesomeIcons.lungs, "category": "Respirations"},
    {"icon": FontAwesomeIcons.hand, "category": "Dermatology"},
    {"icon": FontAwesomeIcons.personPregnant, "category": "Gynecology"},
    {"icon": FontAwesomeIcons.teeth, "category": "Dental"},
  ];

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AuthModel>(context, listen: false).getUser;
    doctor = Provider.of<AuthModel>(context, listen: false).appointment;
    favList = Provider.of<AuthModel>(context, listen: false).getFav;

    print(user);
    print(favList);

    return Scaffold(
      body: user.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            user['name'] ?? 'User',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('assets/profile1.png'),
                            ),
                          ),
                        ],
                      ),
                      context.spaceMedium,
                      Text(
                        'Category',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      context.spaceSmall,
                      SizedBox(
                        height: context.height * 0.05,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List<Widget>.generate(medCat.length, (index) {
                            return Card(
                              margin: EdgeInsets.only(right: 20),
                              color: Config.primaryColor,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    FaIcon(medCat[index]['icon'], color: Colors.white),
                                    SizedBox(width: 20),
                                    Text(
                                      medCat[index]['category'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      context.spaceSmall,
                      Text(
                        'Appointment Today',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      context.spaceSmall,
                      doctor.isNotEmpty
                          ? AppointmentCard(doctor: doctor)
                          : Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    'No Appointment Today',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      context.spaceSmall,
                      Text(
                        'Top Doctors',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      context.spaceSmall,
                      Column(
                        children: List.generate(user['doctor'].length, (index) {
                          return DoctorCard(
                            route: 'doc_details',
                            doctor: user['doctor'][index],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
