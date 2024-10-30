import 'package:flutter/material.dart';import 'package:flutter_spinkit/flutter_spinkit.dart';import 'package:schoolworkspro_app/services/event_service.dart';import 'package:intl/intl.dart';import '../../../constants.dart';class EventApplicantScreen extends StatefulWidget {  final String? eventId;  const EventApplicantScreen({Key? key, required this.eventId})      : super(key: key);  @override  _EventApplicantScreenState createState() =>      _EventApplicantScreenState();}class _EventApplicantScreenState extends State<EventApplicantScreen> {  Icon cusIcon = const Icon(Icons.search);  bool connected = false;  final TextEditingController _searchController =      TextEditingController();  List<dynamic> _listForDisplay = <dynamic>[];  List<dynamic> _list = <dynamic>[];  Widget cusSearchBar = const Text(    'Applicants Stats',    style: TextStyle(color: Colors.black),  );  @override  void initState() {    getData();    super.initState();  }  bool isLoading = false;  getData() async {    setState(() {      isLoading = true;    });    final data = await EventService()        .getEventApplicants(widget.eventId.toString());    for (int i = 0; i < data.guests!.length; i++) {      setState(() {        _list.add(data.guests?[i]);        _listForDisplay = _list;      });    }    setState(() {      isLoading = false;    });  }  @override  Widget build(BuildContext context) {    return Scaffold(      appBar: AppBar(          iconTheme: const IconThemeData(            color: Colors.black,          ),          actions: [            IconButton(                onPressed: () {                  setState(() {                    if (this.cusIcon.icon == Icons.search) {                      this.cusIcon = Icon(                        Icons.cancel,                        color: Colors.grey,                      );                      this.cusSearchBar = TextField(                        autofocus: true,                        textInputAction: TextInputAction.go,                        controller: _searchController,                        decoration: const InputDecoration(                            hintText: 'Search student name...',                            border: InputBorder.none),                        onChanged: (text) {                          setState(() {                            _listForDisplay = _list.where((list) {                              var itemName = list["user"]['firstname']                                      .toLowerCase() +                                  " " +                                  list["user"]['lastname']                                      .toLowerCase();                              return itemName.contains(text);                            }).toList();                          });                        },                      );                    } else {                      this.cusIcon = const Icon(Icons.search);                      _listForDisplay = _list;                      _searchController.clear();                      this.cusSearchBar = const Text(                        'Applicants Stats',                        style: TextStyle(color: Colors.black),                      );                    }                  });                },                icon: cusIcon)          ],          elevation: 0.0,          title: cusSearchBar,          backgroundColor: Colors.white),      body: isLoading          ? const SpinKitDualRing(color: kPrimaryColor)          : _listForDisplay.isEmpty              ? const Center(                  child: Text('No data available.'),                )              : getListView(),    );  }  List<dynamic> getListElements() {    var items = List<dynamic>.generate(_listForDisplay.length,        (counter) => _listForDisplay[counter]);    return items;  }  Widget getListView() {    var listItems = getListElements();    var listview = ListView.builder(        shrinkWrap: true,        itemCount: listItems.length,        physics: const ScrollPhysics(),        itemBuilder: (context, index) {          return InkWell(            onTap: () {},            child: Card(              child: Column(                mainAxisAlignment: MainAxisAlignment.start,                crossAxisAlignment: CrossAxisAlignment.start,                children: [                  ListTile(                    title: Row(                      mainAxisAlignment:                          MainAxisAlignment.spaceBetween,                      crossAxisAlignment: CrossAxisAlignment.start,                      children: [                        Expanded(                            child: Text(listItems[index]["user"]                                    ['firstname'] +                                " " +                                listItems[index]["user"]                                    ['lastname'])),                        listItems[index]['isPresent'] == false                            ? const Icon(                                Icons.cancel,                                color: Colors.red,                              )                            : const Icon(                                Icons.check_circle,                                color: Colors.green,                              ),                      ],                    ),                    subtitle: Column(                      mainAxisAlignment: MainAxisAlignment.start,                      crossAxisAlignment: CrossAxisAlignment.start,                      children: [                        RichText(                          text: TextSpan(                            text: 'Contact: ',                            style: const TextStyle(                                color: Colors.black,                                fontWeight: FontWeight.bold),                            children: <TextSpan>[                              TextSpan(                                text: listItems[index]["user"]                                    ['contact'],                                style: const TextStyle(                                    color: Colors.black,                                    fontWeight: FontWeight.normal),                              ),                            ],                          ),                        ),                        RichText(                          text: TextSpan(                            text: 'Batch: ',                            style: const TextStyle(                                color: Colors.black,                                fontWeight: FontWeight.bold),                            children: <TextSpan>[                              TextSpan(                                text: listItems[index]["user"]                                    ['batch'],                                style: const TextStyle(                                    color: Colors.black,                                    fontWeight: FontWeight.normal),                              ),                            ],                          ),                        ),                        RichText(                          text: TextSpan(                            text: 'Institution: ',                            style: const TextStyle(                                color: Colors.black,                                fontWeight: FontWeight.bold),                            children: <TextSpan>[                              TextSpan(                                text: listItems[index]["user"]                                    ['institution'],                                style: const TextStyle(                                    color: Colors.black,                                    fontWeight: FontWeight.normal),                              ),                            ],                          ),                        ),                        Row(                          children: [                            Text(                              "Registered :",                              style: const TextStyle(                                  color: Colors.black,                                  fontWeight: FontWeight.bold),                            ),                            Container(                              child: listItems[index]                                          ['isRegistered'] ==                                      false                                  ? Icon(                                      Icons.cancel,                                      color: Colors.red,                                    )                                  : const Icon(                                      Icons.check_circle,                                      color: Colors.green,                                    ),                            )                          ],                        ),                        RichText(                          text: TextSpan(                            text: 'Present Time: ',                            style: const TextStyle(                                color: Colors.black,                                fontWeight: FontWeight.bold),                            children: <TextSpan>[                              TextSpan(                                text: listItems[index]['entryTime'] ==                                        null                                    ? ""                                    : DateFormat('MMM dd, yyyy hh:mm')                                        .format(DateTime.parse(                                            listItems[index]                                                ['entryTime']))                                        .toString(),                                style: const TextStyle(                                    color: Colors.black,                                    fontWeight: FontWeight.normal),                              ),                            ],                          ),                        ),                      ],                    ),                  ),                ],              ),            ),          );        });    return listview;  }}