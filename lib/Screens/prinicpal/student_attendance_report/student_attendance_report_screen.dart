import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolworkspro_app/Screens/prinicpal/student_attendance/student_attendance.dart';
import 'package:schoolworkspro_app/Screens/prinicpal/student_attendance_report/student_batch_attendance.dart';

import '../principal_common_view_model.dart';

class StudentAttendanceReportScreen extends StatefulWidget {
  const StudentAttendanceReportScreen({Key? key}) : super(key: key);

  @override
  State<StudentAttendanceReportScreen> createState() =>
      _StudentAttendanceReportScreenState();
}

class _StudentAttendanceReportScreenState
    extends State<StudentAttendanceReportScreen> {

  late PrinicpalCommonViewModel _provider;

   List<dynamic> tabsList = [
    {
      "name": "Module Attendance",
      "identifier": ["student_module_attendance_report"],
      "color":const Color(0xff28a745),
      "navigate":PrincipalStudentAttendance(),
    },
    {
      "name": "Batch Attendance",
      "identifier": ["student_batch_attendance_report"],
      "color":const Color(0xff17a2b8),
      "navigate":StudentBatchAttendanceScreen()
    }
  ];
  int currentIndex = 0;
  List<dynamic> filteredCardsList = [];

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      _provider = Provider.of<PrinicpalCommonViewModel>(context, listen: false);

     await fetchData();
    });
    super.initState();
  }

  Future<void> fetchData() async {
    _provider = Provider.of<PrinicpalCommonViewModel>(context, listen: false);
    filteredCardsList = tabsList
        .where((item) => _provider.hasPermission(item['identifier']))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: filteredCardsList.length,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text(
            "Student Attendance",
            style: TextStyle(color: Colors.black),
          ),
          leading: const BackButton(color: Colors.black),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            unselectedLabelStyle: const TextStyle(color: Colors.black),
            labelPadding: EdgeInsets.zero,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            indicatorColor: Colors.white,
            onTap: (int value) {
              setState(() {
                currentIndex = value;
              });
            },
            labelStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            tabs: [
              ...List.generate(
                  filteredCardsList.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: filteredCardsList[index]["color"],
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Text(
                              filteredCardsList[index]["name"],
                              style: TextStyle(
                                  color: filteredCardsList[index]["color"],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                  ))
            ],
          ),
        ),
        body: TabBarView(
          children: filteredCardsList.map<Widget>((item) => item["navigate"] as Widget).toList(),
        ),
      ),
    );
  }
}
