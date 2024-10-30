import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/state_manager.dart';
import 'package:provider/provider.dart';
import 'package:schoolworkspro_app/Screens/admin/navigation/navigation_admin.dart';
import 'package:schoolworkspro_app/Screens/dashboard/pager_view.dart';
import 'package:schoolworkspro_app/Screens/lecturer/lecturer_common_view_model.dart';
import 'package:schoolworkspro_app/Screens/lecturer/navigation/navigation_lecturer.dart';
import 'package:schoolworkspro_app/Screens/lecturer/navigation/offline_test.dart';

import 'package:schoolworkspro_app/Screens/lecturer/navigation/pagerview_lecturer.dart';
import 'package:schoolworkspro_app/Screens/login/login.dart';
import 'package:schoolworkspro_app/Screens/prinicpal/dashboard/prinicipal_dashboard.dart';
import 'package:schoolworkspro_app/Screens/prinicpal/navigation/navigation.dart';

import 'package:schoolworkspro_app/Screens/widgets/snack_bar.dart';
import 'package:schoolworkspro_app/auth_view_model.dart';
import 'package:schoolworkspro_app/common_view_model.dart';
import 'package:schoolworkspro_app/components/internetcheck.dart';
import 'package:schoolworkspro_app/config/preference_utils.dart';

import 'package:schoolworkspro_app/constants.dart';
import 'package:schoolworkspro_app/request/login_request.dart';
import 'package:schoolworkspro_app/services/login_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/local_notification_service.dart';
import '../../response/login_response.dart';
import '../navigation/navigation.dart';

class Splashscreen extends StatefulWidget {
  static const String routeName = "/";
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  // bool connected = false;
  late User _user;
  late LecturerCommonViewModel lecturerCommonViewModel;
  late CommonViewModel commonViewModel;

  final SharedPreferences localStorage = PreferenceUtils.instance;
  @override
  void initState() {
    super.initState();

    getData();
    _checkLogin();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      lecturerCommonViewModel =
          Provider.of<LecturerCommonViewModel>(context, listen: false);
      commonViewModel = Provider.of<CommonViewModel>(context, listen: false);
    });
  }

  getData() {
    if (localStorage.getString('token') != null) {
      try {
        _user = User.fromJson(jsonDecode(localStorage.getString("_auth_")!));
      } catch (e) {}
    }
  }

  Future<void> _checkLogin() async {
    print("LOGIN CHECK:::");
    Timer(const Duration(seconds: 2), () async {
      if (localStorage.getString('token') != null &&
          localStorage.getBool('privateFlag') != null &&
          localStorage.getBool('privateFlag') == false) {
        await internetCheck().then((value) async {
          if (value) {
            String? username = localStorage.getString('username');
            String? password = localStorage.getString('password');
            final request = LoginRequest(
                username: username.toString(), password: password.toString());

            try {
              final result = await LoginService()
                  .login(request, username.toString(), password.toString());
              if (result.success == true) {
                print("PRINTING DROLE::${result.user!.droleName!}");
                if (result.user!.droleName! == "STUDENT") {
                  Navigator.pop(context);
                  commonViewModel.setNavigationIndex(0);
                  print("logged in using internet");
                  // Navigator.of(context).pushNamed('/Pagerview');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Navigation(currentIndex: 0),
                      ));
                } else if (result.user!.droleName! == "PARENT") {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/childrenscreen');
                } else if (result.user!.type == "Driver") {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/navigation-driver');
                } else if (result.user!.institution == "digitech") {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavigationAdmin(),
                      ));
                } else if (localStorage.getBool("changedToAdmin") != null) {
                  print("indise:::");
                  if (localStorage.getBool("changedToAdmin") == true) {
                    if (result.user!.domains != null &&
                        result.user!.domains!.contains("Admin")) {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavigationPrincipal(),
                          ));
                    } else {
                      localStorage.clear();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const LoginScreen()));
                    }
                  }
                  else if (localStorage.getBool("changedToAdmin") == false) {
                    if (result.user!.type! == "Lecturer" ||
                        result.user!.type! == "Head Lecturer") {
                      lecturerCommonViewModel.setNavigationIndex(0);
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavigationLecturer(),
                          ));
                    } else {
                      localStorage.clear();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const LoginScreen()));
                    }
                  }
                  else {
                    localStorage.clear();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const LoginScreen()));
                  }
                } else {
                  localStorage.clear();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const LoginScreen()));
                }
              } else {
                localStorage.clear();
                snackThis(
                  context: context,
                  content: const Text("please check credentials and try again"),
                  color: Colors.red.shade700,
                );
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const LoginScreen()));
              }
            } catch (e) {
              localStorage.clear();
              print("CATCH " + e.toString());
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const LoginScreen()));
              snackThis(
                context: context,
                content: Text(e.toString()),
                color: Colors.red.shade700,
              );
            }
          } else {
            print('THIS IS ELESE NO INTERNET" ${value}:::::');
            try {
              if (_user.droleName! == "STUDENT") {
                Navigator.pop(context);
                print("logged in no internet token");
                // Navigator.of(context).pushNamed('/Pagerview');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Navigation(currentIndex: 0),
                    ));
              } else if (_user.droleName! == "PARENT") {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/childrenscreen');
              } else if (_user.droleName == "DRIVER") {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/navigation-driver');
              } else if (localStorage.getBool("changedToAdmin") == true) {
                if (_user.domains != null && _user.domains!.contains("Admin")) {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavigationPrincipal(),
                      ));
                } else {
                  localStorage.clear();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const LoginScreen()));
                }
              } else if (localStorage.getBool("changedToAdmin") == false) {
                if (_user.type! == "Lecturer" ||
                    _user.type! == "Head Lecturer") {
                  lecturerCommonViewModel.setNavigationIndex(0);
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NavigationLecturer(),
                      ));
                } else {
                  localStorage.clear();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const LoginScreen()));
                }
              } else if (_user.institution == "digitech") {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavigationAdmin(),
                    ));
              } else {
                localStorage.clear();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const LoginScreen()));
              }
            } catch (e) {
              localStorage.clear();
              print("CATCH " + e.toString());
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const LoginScreen()));
              snackThis(
                context: context,
                content: Text(e.toString()),
                color: Colors.red.shade700,
              );
            }
          }
        });
      } else {
        localStorage.clear();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/schoolworkslite_full.png",
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: SpinKitDualRing(
                    color: kPrimaryColor,
                    size: 18,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                          child: const Text(
                        'powered by',
                        style: TextStyle(color: Colors.grey),
                      )),
                      Container(
                        height: 38,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image:
                                    AssetImage("assets/icons/digi-tech.png"))),
                      ),
                    ],
                  )),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.only(bottom: 60.0),
            //     child: RichText(
            //       textAlign: TextAlign.center,
            //       text: const TextSpan(
            //         text: 'from \n',
            //         style: TextStyle(
            //           color: Colors.black26,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 15,
            //         ),
            //         children: [
            //
            //           TextSpan(
            //             text: 'DIGI TECHNOLOGY',
            //             style: TextStyle(
            //               decorationStyle: TextDecorationStyle.solid,
            //               color: Colors.black26,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 15,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

// void timer(context) {
//   Timer(
//       const Duration(milliseconds: 2000),
//       () => token != null
//           ? Navigator.of(context).pushReplacement(MaterialPageRoute(
//               builder: (BuildContext context) => const Pagerview(
//                     initialpage: 1,
//                   )))
//           : Navigator.of(context).pushReplacement(MaterialPageRoute(
//               builder: (BuildContext context) => const LoginScreen())));
// }
}
