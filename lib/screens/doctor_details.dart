import 'package:flutter/material.dart';
import 'package:flutter_doctor/components/about_doctor.dart';
import 'package:flutter_doctor/components/button.dart';
import 'package:flutter_doctor/components/custom_appbar.dart';
import 'package:flutter_doctor/providers/dio_provider.dart';
import 'package:flutter_doctor/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_model.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key, required this.doctor, required this.isFav});
  final Map<String, dynamic> doctor;
  final bool isFav;

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  Map<String, dynamic> doctor = {};
  bool isFav = false;

  @override
  void initState() {
    doctor = widget.doctor;
    isFav = widget.isFav;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        appTitle: 'Doctor Details',
        icon: FaIcon(FontAwesomeIcons.chevronLeft),
        actions: [
          IconButton(
            onPressed: () async {
              final list = Provider.of<AuthModel>(context, listen: false).getFav;
              if (list.contains(doctor['doc_id'])) {
                list.removeWhere((id) => id == doctor['doc_id']);
              } else {
                list.add(doctor['doc_id']);
              }
              Provider.of<AuthModel>(context, listen: false).setFavList(list);

              final SharedPreferences prefs = await SharedPreferences.getInstance();
              final token = prefs.getString('token') ?? '';
              if (token.isNotEmpty && token != '') {
                final response = await DioProvider().storeFavDoc(list, token);
                if (response == 200) {
                  setState(() {
                    isFav = !isFav;
                  });
                }
              }
            },
            icon: FaIcon(
              isFav ? Icons.favorite_rounded : Icons.favorite_outline,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AboutDoctor(doctor: doctor),
              DetailBody(),
              context.spaceMedium,
              Padding(
                padding: EdgeInsets.all(20),
                child: Button(
                  width: double.infinity,
                  title: 'Book Appointment',
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      "booking_page",
                      arguments: {"doctor_id": doctor['doc_id']},
                    );
                  },
                  disable: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
