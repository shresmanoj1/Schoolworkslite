import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_version/new_version.dart';
import 'package:schoolworkspro_app/Screens/admin/dashboard/dashboardadminscreen.dart';
import 'package:schoolworkspro_app/Screens/admin/navigation/drawer.dart';
import 'package:schoolworkspro_app/Screens/admin/notice/notice_admin.dart';
import 'package:schoolworkspro_app/Screens/lecturer/Morelecturer/QrView.dart';
import 'package:schoolworkspro_app/Screens/widgets/snack_bar.dart';
import 'package:schoolworkspro_app/constants.dart';
import 'package:schoolworkspro_app/services/lecturer/punch_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../request/fcm_request.dart';
import '../../../response/login_response.dart';
import '../../../services/login_service.dart';

class NavigationAdmin extends StatefulWidget {
  NavigationAdmin({
    Key? key,
  }) : super(key: key);

  @override
  _NavigationAdminState createState() => _NavigationAdminState();
}

class _NavigationAdminState extends State<NavigationAdmin> {
  String _title = 'Home';

  String _scanBarcode = 'Unknown';
  PageController _pageController = PageController();
  // List<Widget> _screens = [StudentDashboard(), Result(), Attendance()];
  int _selectedIndex = 0;
  bool connected = false;
  User? user;

  @override
  void initState() {
    // TODO: implement initState

    // getCompletedLesson();

    checkversion();
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userData = sharedPreferences.getString('_auth_');
    Map<String, dynamic> userMap = json.decode(userData!);
    User userD = User.fromJson(userMap);
    setState(() {
      user = userD;
    });

    try {
      FirebaseMessaging.instance.getToken().then((value) async {
        String? token = value;
        print("fcm: " + token.toString());
        final data = FcmTokenRequest(
            username: user?.username.toString(),
            batch: user?.batch.toString(),
            type: user?.type.toString(),
            institution: user?.institution.toString(),
            token: token.toString());
        final res = await LoginService().postFCM(data);
        if (res.success == true) {
          print("FCM token registered");
        } else {
          print("Error registering FCM token");
        }
      });
    } on Exception catch (e) {
      snackThis(
          content: Text(e.toString()),
          color: Colors.red,
          behavior: SnackBarBehavior.fixed,
          duration: 2,
          context: context);
      // TODO
    }
  }

  checkversion() async {
    final new_version = NewVersion(
      androidId: "np.edu.digitech.schoolworksprolite",
      iOSId: "np.edu.digitech.schoolworksprolite",
    );

    final status = await new_version.getVersionStatus();
    if (Platform.isAndroid) {
      if (status!.localVersion != status.storeVersion) {
        new_version.showUpdateDialog(
            dialogText: "You need to update this application",
            context: context,
            versionStatus: status);
      }
    } else if (Platform.isIOS) {
      if (status!.canUpdate) {
        new_version.showUpdateDialog(
            dialogText: "You need to update this application",
            context: context,
            versionStatus: status);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NoticeAdminScreen(),
                  ));
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          ),
          IconButton(
              onPressed: () => scanQR(),
              icon: const Icon(
                Icons.qr_code_scanner,
                color: Colors.black,
              )),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      drawer: const Drawersection(),
      body: const DashboardAdminscreen(),
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    DateTime now = DateTime.now();

    var formattedtime = DateFormat('yyyyMMddmm').format(now);
    // await Future.delayed(Duration(seconds: 5));
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (barcodeScanRes.toString() ==
          "https://api.schoolworkspro.com/staffAttendance/institution=${user?.institution.toString()}?${formattedtime}") {
        hitAttendance();
      } else if (barcodeScanRes.toString() !=
          "https://api.schoolworkspro.com/staffAttendance/institution=${user?.institution.toString()}?${formattedtime}") {
        Fluttertoast.showToast(msg: "Invalid QR");
      }
      // if (barcodeScanRes ==
      //     "https://api.schoolworkspro.com/staffAttendance/add") {
      //   hitAttendance();
      // }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  hitAttendance() async {
    try {
      final res = await PunchService().punchInOut();
      if (res.success == true) {
        Fluttertoast.showToast(
            msg: res.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.green,
            textColor: Colors.white);
        // snackThis(
        //     content: Text(res.message.toString()),
        //     color: Colors.green,
        //     behavior: SnackBarBehavior.fixed,
        //     duration: 2,
        //     context: context);
      } else {
        Fluttertoast.showToast(
            msg: res.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.green,
            textColor: Colors.white);
        // snackThis(
        //     content: Text(res.message.toString()),
        //     color: Colors.red,
        //     behavior: SnackBarBehavior.fixed,
        //     duration: 2,
        //     context: context);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white);
      // snackThis(
      //     content: Text(e.toString()),
      //     color: Colors.red,
      //     behavior: SnackBarBehavior.fixed,
      //     duration: 2,
      //     context: context);
    }
  }
}
