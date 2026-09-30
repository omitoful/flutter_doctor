import 'package:flutter/material.dart';
import 'package:flutter_doctor/components/about_doctor.dart';
import 'package:flutter_doctor/components/button.dart';
import 'package:flutter_doctor/components/custom_appbar.dart';
import 'package:flutter_doctor/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    final doctor = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: CustomAppbar(
        appTitle: 'Doctor Details',
        icon: FaIcon(FontAwesomeIcons.chevronLeft),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
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
