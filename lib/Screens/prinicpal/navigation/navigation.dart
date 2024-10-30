import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';
import 'package:schoolworkspro_app/Screens/prinicpal/dashboard/prinicipal_dashboard.dart';
import 'package:schoolworkspro_app/Screens/prinicpal/navigation/drawer.dart';
import 'package:schoolworkspro_app/Screens/widgets/snack_bar.dart';
import 'package:schoolworkspro_app/request/fcm_request.dart';
import 'package:schoolworkspro_app/services/lecturer/punch_service.dart';
import 'package:schoolworkspro_app/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../response/login_response.dart';
import '../../../services/notification_navigate_service.dart';
import '../principal_common_view_model.dart';

class NavigationPrincipal extends StatefulWidget {
  NavigationPrincipal({
    Key? key,
  }) : super(key: key);

  @override
  _NavigationPrincipalState createState() => _NavigationPrincipalState();
}

class _NavigationPrincipalState extends State<NavigationPrincipal> {
  String _title = 'Home';

  String _scanBarcode = 'Unknown';
  PageController _pageController = PageController();
  // List<Widget> _screens = [StudentDashboard(), Result(), Attendance()];
  int _selectedIndex = 0;
  bool connected = false;
  User? user;
  late PrinicpalCommonViewModel _provider;

  @override
  void initState() {
    // TODO: implement initState

    // getCompletedLesson();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      NotificationRoute.NavigationNavigateService(context);

      _provider = Provider.of<PrinicpalCommonViewModel>(context, listen: false);

      _provider.fetchMyPermissions();
    });

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

    sharedPreferences.setBool("changedToAdmin", true);

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
    try {
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
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPrinicpal(),
      body: const PrincipalDashboardScreen(),
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
        // snackThis(
        //     content: Text(res.message.toString()),
        //     color: Colors.green,
        //     behavior: SnackBarBehavior.fixed,
        //     duration: 2,
        //     context: context);

        Fluttertoast.showToast(
            msg: res.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.green,
            textColor: Colors.white);
      } else {
        // snackThis(
        //     content: Text(res.message.toString()),
        //     color: Colors.red,
        //     behavior: SnackBarBehavior.fixed,
        //     duration: 2,
        //     context: context);

        Fluttertoast.showToast(
            msg: res.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.green,
            textColor: Colors.white);
      }
    } catch (e) {
      // snackThis(
      //     content: Text(e.toString()),
      //     color: Colors.red,
      //     behavior: SnackBarBehavior.fixed,
      //     duration: 2,
      //     context: context);
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white);
    }
  }
}
