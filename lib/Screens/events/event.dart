import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/utils.dart';
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';
import 'package:schoolworkspro_app/common_view_model.dart';
import 'package:schoolworkspro_app/components/internetcheck.dart';
import 'package:schoolworkspro_app/components/nointernet_widget.dart';
import 'package:schoolworkspro_app/constants.dart';
import 'package:schoolworkspro_app/response/event_response.dart';
import 'package:schoolworkspro_app/services/event_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

import '../../config/api_response_config.dart';
import '../../helper/app_version.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}

//
class Event {
  Event(
      {this.eventName,
      this.from,
      this.to,
      this.background,
      this.details,
      this.isAllDay = false});

  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;
  String? details;
}

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ScheduleExample();
}

class ScheduleExample extends State<EventScreen>
    with AutomaticKeepAliveClientMixin {
  List<Event> _appointmentDetails = <Event>[];

  // late Future<Eventresponse> event_response;
  bool connected = true;

  DateTime showDate = DateTime.now();
  List<Event> collection = [];
  late CommonViewModel _provider;

  @override
  void initState() {
    // TODO: implement initState
    checkInternet();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _provider = Provider.of<CommonViewModel>(context, listen: false);
      _provider.fetchEvents();
    });
    Future.delayed(Duration.zero, () {
      VersionChecker.checkVersion(context);
    });
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  checkInternet() async {
    internetCheck().then((value) {
      if (value) {
        setState(() {
          connected = true;
        });
      } else {
        setState(() {
          connected = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return connected == false
        ? const NoInternetWidget()
        : Consumer<CommonViewModel>(builder: (context, common, child) {
            if (isLoading(common.eventApiResponse)) {
              return const CupertinoActivityIndicator();
            } else if (isError(common.eventApiResponse) ||
                common.eventApiResponse.data == null ||
                common.eventApiResponse.data!.isEmpty) {
              return Container();
            } else {
              print("RESPONSE OF EVENT DATA HAHA::${common.events}");
              try {
                var showData = common.events;
                collection.clear();

                for (int i = 0; i < showData.length; i++) {
                  DateTime start =
                      DateTime.parse(showData[i].startDate.toString());

                  start = start.add(const Duration(hours: 5, minutes: 45));

                  var formattedTime = DateFormat('MM/DD/YY').format(start);
                  collection.add(Event(
                      eventName: showData[i].eventTitle,
                      isAllDay: false,
                      from: DateTime.parse(showData[i].startDate.toString())
                          .add(const Duration(hours: 5, minutes: 45)),
                      to: DateTime.parse(showData[i].endDate.toString())
                          .add(const Duration(hours: 5, minutes: 45)),
                      background: Colors.green,
                      details: showData[i].detail.toString()));

                }
              } catch (e) {}
              return Scaffold(
                body: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: SfCalendar(
                          todayHighlightColor: kPrimaryColor,
                          selectionDecoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.red, width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            shape: BoxShape.rectangle,
                          ),
                          showNavigationArrow: true,
                          view: CalendarView.month,
                          dataSource: MeetingDataSource(collection),
                          onTap: calendarTapped,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(DateFormat.yMMMEd().format(showDate)),
                      ),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                color: Colors.white,
                                child: ListView.separated(
                                  // shrinkWrap: true,
                                  // physics: ScrollPhysics(),
                                  padding: const EdgeInsets.all(2),
                                  itemCount: _appointmentDetails.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  title: Text(
                                                    _appointmentDetails[index]
                                                        .eventName
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  content: Text(
                                                      _appointmentDetails[index]
                                                          .details
                                                          .toString()));
                                            });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Colors.green,
                                        ),
                                        child: Text(
                                          _appointmentDetails[index]
                                              .eventName
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(
                                    height: 5,
                                  ),
                                )),
                          ))
                    ],
                  ),
                ),
              );
            }
          });
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      print("CalendarElement.calendarCell::::${calendarTapDetails.date}");

      setState(() {
        showDate = calendarTapDetails.date!;
        _appointmentDetails = calendarTapDetails.appointments!.cast<Event>();
      });
    }
  }
}
