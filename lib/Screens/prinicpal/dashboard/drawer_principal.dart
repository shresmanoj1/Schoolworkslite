import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';
import 'package:schoolworkspro_app/Screens/admin/dashboard/dashboardadminscreen.dart';
import 'package:schoolworkspro_app/Screens/admin/overtime_admin/overtime_adminscreen.dart';
import 'package:schoolworkspro_app/Screens/admin/settings/adminchangepassword_screen.dart';
import 'package:schoolworkspro_app/Screens/admin/support/supportadmin_screen.dart';
import 'package:schoolworkspro_app/Screens/examination/examination.dart';
import 'package:schoolworkspro_app/Screens/lecturer/Dashboardlecturer/examination_lecturer.dart';
import 'package:schoolworkspro_app/Screens/lecturer/Morelecturer/leave/bookleave_admin.dart';
import 'package:schoolworkspro_app/Screens/login/login.dart';
import 'package:schoolworkspro_app/Screens/splash/splashscreen.dart';
import 'package:schoolworkspro_app/Screens/widgets/snack_bar.dart';
import 'package:schoolworkspro_app/api/api.dart';
import 'package:schoolworkspro_app/constants.dart';
import 'package:schoolworkspro_app/services/authenticateduser_service.dart';
import 'package:schoolworkspro_app/services/lecturer/punch_service.dart';
import 'package:schoolworkspro_app/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../response/login_response.dart';
import '../../lecturer/Morelecturer/leave/book_leave.dart';
import '../../lecturer/Morelecturer/overtime/overtimescreen.dart';
import '../admin_edit/admin_editscreen.dart';

class DrawerPrincipal extends StatefulWidget {
  const DrawerPrincipal({Key? key}) : super(key: key);

  @override
  _DrawerPrincipalState createState() => _DrawerPrincipalState();
}

class _DrawerPrincipalState extends State<DrawerPrincipal> {
  User? user;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userData = sharedPreferences.getString('_auth_');
    Map<String, dynamic> userMap = json.decode(userData!);
    User userD = User.fromJson(userMap);
    setState(() {
      user = userD;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          ChangeNotifierProvider<Authenticateduserservice>(
              create: (context) => Authenticateduserservice(),
              child: Consumer<Authenticateduserservice>(
                  builder: (context, provider, child) {
                provider.getAuthentication(context);
                if (provider.data?.user == null) {
                  provider.getAuthentication(context);
                  return const Center(
                      child: SpinKitDualRing(
                    color: kPrimaryColor,
                  ));
                }

                return UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xff000099),
                  ),
                  accountName: Text("${user?.firstname.toString()}" +
                      " " +
                      "${user?.lastname.toString()}"),
                  accountEmail: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${user?.email.toString()}"),
                      Text("${user?.type.toString()}"),
                    ],
                  ),
                  currentAccountPicture: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                        radius: 18,
                        backgroundColor: provider.data!.user!.userImage == null
                            ? Colors.grey
                            : Colors.white,
                        child: provider.data!.user!.userImage == null
                            ? Text(
                                provider.data!.user!.firstname![0]
                                        .toUpperCase() +
                                    "" +
                                    provider.data!.user!.lastname![0]
                                        .toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            : ClipOval(
                                child: Image.network(
                                  api_url2 +
                                      '/uploads/users/' +
                                      provider.data!.user!.userImage!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              )),
                  ),
                );
              })),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ChangeNotifierProvider<PunchService>(
                create: (context) => PunchService(),
                child:
                    Consumer<PunchService>(builder: (context, provider, child) {
                  provider.checkPunchStatus(context);
                  return provider.data2?.status == "Out"
                      ? RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.circle,
                                    color: Colors.red, size: 14),
                              ),
                              TextSpan(
                                  text: " Offline ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      : provider.data2?.status?['status'] == "Out"
                          ? RichText(
                              text: const TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.circle,
                                        color: Colors.red, size: 14),
                                  ),
                                  TextSpan(
                                      text: " Offline ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )
                          : RichText(
                              text: const TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.circle,
                                        color: Colors.green, size: 14),
                                  ),
                                  TextSpan(
                                      text: " Online ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            );
                })),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: Icon(Icons.assessment),
            title: Text("Examination"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExaminationLecturer(),
                  ));
            },
          ),
          user?.type.toString() == "Admin" ||
                  user?.type.toString() == "Management"
              ? ListTile(
                  leading: Icon(Icons.support_agent),
                  title: Text("Support"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminSupportDetailScreen(
                                title: "Support",
                              )),
                    );
                  },
                )
              : SizedBox(),
          // ListTile(
          //   leading: Icon(Icons.person_remove),
          //   title: Text("Leave"),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => BookLeave()),
          //     );
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.add_box),
          //   title: Text("Overtime"),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const OvertimeScreen()),
          //     );
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Edit Profile"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      child: const AdminEditScreen(),
                      type: PageTransitionType.rightToLeft));
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () async {
              final res = await LoginService().logout();
              if (res.success == true) {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                await sharedPreferences.clear();

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              } else {
                snackThis(
                    context: context,
                    content: Text(res.success.toString()),
                    color: Colors.red,
                    duration: 1,
                    behavior: SnackBarBehavior.floating);
              }
            },
          ),

          user != null &&
                  (user!.type == "Lecturer" || user!.type == "Head Lecturer")
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        kPrimaryColor,
                      ),
                    ),
                    onPressed: () async {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setBool("changedToAdmin", false);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Splashscreen(),
                          ));
                    },
                    child: const Text('Lecturer View'),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
