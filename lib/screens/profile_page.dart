import 'package:flutter/material.dart';
import 'package:flutter_doctor/main.dart';
import 'package:flutter_doctor/providers/dio_provider.dart';
import 'package:flutter_doctor/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: context.height,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                color: Config.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 65.0,
                      backgroundImage: AssetImage('assets/profile1.png'),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Amanda Tan',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '23 Years Old | Female',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.grey[200],
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Card(
                      child: Container(
                        width: 300,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Profile',
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                            ),
                            Divider(color: Colors.grey[300]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.blueAccent[400],
                                  size: 35,
                                ),
                                SizedBox(width: 20),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Profile",
                                    style: TextStyle(
                                      color: Config.primaryColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            context.spaceSmall,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.history,
                                  color: Colors.yellowAccent[400],
                                  size: 35,
                                ),
                                SizedBox(width: 20),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "History",
                                    style: TextStyle(
                                      color: Config.primaryColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            context.spaceSmall,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.login_outlined,
                                  color: Colors.lightGreen[400],
                                  size: 35,
                                ),
                                SizedBox(width: 20),
                                TextButton(
                                  onPressed: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    final token = prefs.getString('token') ?? '';
                                    if (token.isNotEmpty && token != '') {
                                      final response = await DioProvider().logout(token);
                                      if (response == 200) {
                                        await prefs.remove('token');
                                        setState(() {
                                          MyApp.navigatorKey.currentState!
                                              .pushReplacementNamed('/');
                                        });
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Logout",
                                    style: TextStyle(
                                      color: Config.primaryColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
