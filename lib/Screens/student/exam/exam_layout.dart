import 'dart:convert';import 'package:flutter/material.dart';import 'package:flutter_spinkit/flutter_spinkit.dart';import 'package:loader_overlay/loader_overlay.dart';import 'package:provider/provider.dart';import 'package:schoolworkspro_app/Screens/student/exam/exam_view_model.dart';import 'package:schoolworkspro_app/Screens/student/exam/question_answer_screen.dart';import 'package:intl/intl.dart';import 'package:schoolworkspro_app/Screens/testtab.dart';import '../../../api/repositories/exam_repo.dart';import '../../../config/api_response_config.dart';import '../../../constants.dart';import '../../../response/common_response.dart';import '../../widgets/snack_bar.dart';class ExamLayoutsScreen extends StatefulWidget {  String? moduleSlug;  ExamLayoutsScreen({Key? key, required this.moduleSlug}) : super(key: key);  @override  State<ExamLayoutsScreen> createState() => _ExamLayoutsScreenState();}class _ExamLayoutsScreenState extends State<ExamLayoutsScreen> {  late ExamViewModel _provider;  bool isloading = false;  TextEditingController examCodeController = TextEditingController();  @override  void initState() {    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {      _provider = Provider.of<ExamViewModel>(context, listen: false);      _provider          .fetchAExamQuestionAnswer(widget.moduleSlug.toString())          .then((_) {        _provider.fetchServerTime();      });    });    super.initState();  }  startExamFuc(exam) async {    if (exam.serverTime["raw"] != null) {      DateTime convertStartToNepaliTime = exam.questionAnswer.exam!.startDate!          .add(const Duration(hours: 5, minutes: 45));      DateTime convertRawToNepaliTime = DateTime.parse(exam.serverTime["raw"])          .add(const Duration(hours: 5, minutes: 45));      if (convertStartToNepaliTime.difference(convertRawToNepaliTime) <          Duration.zero) {        try {          setState(() {            isloading = true;          });          Commonresponse res = await ExamRepository()              .examAttempt(exam.questionAnswer.exam!.id.toString());          if (res.success == true) {            setState(() {              isloading = true;            });            // snackThis(            //     context: context,            //     content: Text(            //         "Answer Submitted Sucessfully"),            //     color: Colors.green,            //     duration: 1,            //     behavior:            //     SnackBarBehavior            //         .floating);            setState(() {              isloading = false;            });          } else {            setState(() {              isloading = true;            });            // snackThis(            //     context: context,            //     content: Text(            //         "Failed to Submit Answer"),            //     color: Colors.red,            //     duration: 1,            //     behavior:            //     SnackBarBehavior            //         .floating);            setState(() {              isloading = false;            });          }          setState(() {            isloading = false;          });        } catch (e) {          setState(() {            isloading = true;          });          // snackThis(          //     context: context,          //     content: Text(          //         "Failed to Submit Answer"),          //     color: Colors.red,          //     duration: 1,          //     behavior: SnackBarBehavior          //         .floating);          setState(() {            isloading = false;          });        }        Navigator.push(            context,            MaterialPageRoute(                builder: (context) => QuestionAnswerScreen(                      exam: exam.questionAnswer.exam!,                      moduleSlug: widget.moduleSlug.toString(),                    )));      } else {        snackThis(            context: context,            content: Text("Please wait! The exam has not started yet!"),            color: Colors.red,            duration: 1,            behavior: SnackBarBehavior.floating);      }    }  }  @override  Widget build(BuildContext context) {    if (isloading == true) {      context.loaderOverlay.show();    } else {      context.loaderOverlay.hide();    }    return Scaffold(      body: Consumer<ExamViewModel>(builder: (context, exam, child) {        return isLoading(exam.examQuestionAnswerApiResponse) ||                isLoading(exam.serverTimeApiResponse)            ? const Center(                child: SpinKitDualRing(                  color: kPrimaryColor,                ),              )            : exam.questionAnswer.exam == null ||                    (exam.questionAnswer.completed != null &&                        exam.questionAnswer.completed == true)                ? Column(                    mainAxisAlignment: MainAxisAlignment.center,                    crossAxisAlignment: CrossAxisAlignment.center,                    children: [                      Center(                          child: Container(                        child: Text(                          exam.questionAnswer.message.toString(),                          style: TextStyle(fontSize: 18),                        ),                      )),                    ],                  )                : Container(                    padding: const EdgeInsets.symmetric(                        horizontal: 20, vertical: 10),                    child: SingleChildScrollView(                      child: Column(                        children: [                          Center(                            child: Text(                              exam.questionAnswer.exam!.moduleTitle.toString(),                              style: TextStyle(                                  fontSize: 20, fontWeight: FontWeight.bold),                            ),                          ),                          const SizedBox(                            height: 10,                          ),                          Center(                            child: Text(                              DateFormat.yMMMEd()                                  .format(exam.questionAnswer.exam!.startDate!),                              style: TextStyle(                                fontSize: 18,                              ),                            ),                          ),                          const SizedBox(                            height: 20,                          ),                          Row(                            mainAxisAlignment: MainAxisAlignment.spaceBetween,                            children: [                              Text(                                "Full Marks: ${exam.questionAnswer.exam!.fullMarks.toString()}",                                style: TextStyle(                                  fontSize: 18,                                ),                              ),                              Text(                                "Pass Marks: ${exam.questionAnswer.exam!.passMarks.toString()}",                                style: TextStyle(                                  fontSize: 18,                                ),                              )                            ],                          ),                          const SizedBox(                            height: 20,                          ),                          Center(                            child: Text(                              exam.questionAnswer.exam!.duration.toString(),                              style: TextStyle(                                fontSize: 18,                              ),                            ),                          ),                          const SizedBox(                            height: 20,                          ),                          Container(                            padding: const EdgeInsets.symmetric(vertical: 5),                            decoration: BoxDecoration(                              borderRadius: BorderRadius.circular(6),                              color: const Color(0xffeffdff),                            ),                            child: const Text(                              "When you begin the exam, you will be automatically logged out from all devices. It's important to note that you won't be able to log back in until you finish the exam. Please contact the concerned authority for further assistance.",                              textAlign: TextAlign.center,                              style: TextStyle(                                  fontSize: 18, color: Color(0xff08a7c1)),                            ),                          ),                          const Center(                            child: Text(                              "All the Best!",                              style: TextStyle(                                fontSize: 18,                              ),                            ),                          ),                          const SizedBox(                            height: 20,                          ),                          ElevatedButton(                              onPressed:                                  exam.questionAnswer.exam?.examCodeEnabled ==                                          false                                      ? () async {                                          startExamFuc(exam);                                        }                                      : () {                                          showDialog(                                            context: context,                                            builder: (BuildContext context) {                                              return StatefulBuilder(                                                  builder: (context, setState) {                                                return AlertDialog(                                                  title:                                                      const Text("Start Exam"),                                                  content: SizedBox(                                                    height: 340,                                                    child: Column(                                                      mainAxisAlignment:                                                          MainAxisAlignment                                                              .start,                                                      crossAxisAlignment:                                                          CrossAxisAlignment                                                              .start,                                                      children: [                                                        const Text(                                                            "Enter the exam code to start the exam. Once you start the exam you won't be able to login from other device."),                                                        Padding(                                                          padding:                                                              const EdgeInsets                                                                      .symmetric(                                                                  vertical: 6),                                                          child: const Divider(                                                            thickness: 2,                                                            color: Colors                                                                .blueAccent,                                                          ),                                                        ),                                                        Text("Exam Code"),                                                        SizedBox(                                                          height: 5,                                                        ),                                                        TextFormField(                                                          controller:                                                              examCodeController,                                                          keyboardType:                                                              TextInputType                                                                  .text,                                                          decoration:                                                              const InputDecoration(                                                            filled: true,                                                            enabledBorder:                                                                OutlineInputBorder(                                                                    borderSide:                                                                        BorderSide(                                                                            color:                                                                                kPrimaryColor)),                                                            focusedBorder: OutlineInputBorder(                                                                borderSide: BorderSide(                                                                    color: Colors                                                                        .green)),                                                          ),                                                        ),                                                        SizedBox(                                                          height: 5,                                                        ),                                                        Row(                                                          mainAxisAlignment:                                                              MainAxisAlignment                                                                  .center,                                                          crossAxisAlignment:                                                              CrossAxisAlignment                                                                  .center,                                                          children: <Widget>[                                                            Padding(                                                              padding:                                                                  const EdgeInsets                                                                          .only(                                                                      left:                                                                          15.0,                                                                      top:                                                                          15.0),                                                              child: SizedBox(                                                                child:                                                                    ElevatedButton(                                                                  style: ButtonStyle(                                                                      backgroundColor: MaterialStateProperty.all(Colors.white),                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(                                                                        borderRadius:                                                                            BorderRadius.circular(4.0),                                                                      ))),                                                                  onPressed:                                                                      () {                                                                    Navigator.pop(                                                                        context);                                                                  },                                                                  child: const Text(                                                                      "Cancel",                                                                      style: TextStyle(                                                                          fontSize:                                                                              14,                                                                          color:                                                                              Colors.black)),                                                                ),                                                              ),                                                            ),                                                            Padding(                                                              padding:                                                                  const EdgeInsets                                                                          .only(                                                                      left:                                                                          15.0,                                                                      top:                                                                          15.0),                                                              child: SizedBox(                                                                child:                                                                    ElevatedButton(                                                                  onPressed:                                                                      () async {                                                                    try {                                                                      final request =                                                                          jsonEncode({                                                                        "examCode":                                                                            examCodeController.text                                                                      });                                                                      setState(                                                                          () {                                                                        isloading =                                                                            true;                                                                      });                                                                      Commonresponse res = await ExamRepository().checkExamCode(                                                                          request,                                                                          exam                                                                              .questionAnswer                                                                              .exam!                                                                              .id                                                                              .toString());                                                                      if (res.success ==                                                                          true) {                                                                        setState(                                                                            () {                                                                          isloading =                                                                              true;                                                                        });                                                                        Navigator.pop(                                                                            context);                                                                        startExamFuc(                                                                            exam);                                                                        examCodeController                                                                            .clear();                                                                        // snackThis(                                                                        //     context: context,                                                                        //     content: Text(                                                                        //         res.message.toString()),                                                                        //     color: Colors.green,                                                                        //     duration: 1,                                                                        //     behavior:                                                                        //     SnackBarBehavior                                                                        //         .floating);                                                                        setState(                                                                            () {                                                                          isloading =                                                                              false;                                                                        });                                                                      } else {                                                                        setState(                                                                            () {                                                                          isloading =                                                                              true;                                                                        });                                                                        snackThis(                                                                            context:                                                                                context,                                                                            content: Text(res.message                                                                                .toString()),                                                                            color: Colors                                                                                .red,                                                                            duration:                                                                                1,                                                                            behavior:                                                                                SnackBarBehavior.floating);                                                                        setState(                                                                            () {                                                                          isloading =                                                                              false;                                                                        });                                                                        Navigator.pop(                                                                            context);                                                                      }                                                                      setState(                                                                          () {                                                                        isloading =                                                                            false;                                                                      });                                                                    } catch (e) {                                                                      setState(                                                                          () {                                                                        isloading =                                                                            true;                                                                      });                                                                      snackThis(                                                                          context:                                                                              context,                                                                          content: Text(                                                                              "Failed"),                                                                          color: Colors                                                                              .red,                                                                          duration:                                                                              1,                                                                          behavior:                                                                              SnackBarBehavior.floating);                                                                      setState(                                                                          () {                                                                        isloading =                                                                            false;                                                                      });                                                                      Navigator.pop(                                                                          context);                                                                    }                                                                  },                                                                  style: ButtonStyle(                                                                      backgroundColor: MaterialStateProperty.all(Colors.blueAccent),                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(                                                                        borderRadius:                                                                            BorderRadius.circular(4.0),                                                                      ))),                                                                  child:                                                                      const Text(                                                                    "start Exam",                                                                    style: TextStyle(                                                                        fontSize:                                                                            14,                                                                        color: Colors                                                                            .white),                                                                  ),                                                                ),                                                              ),                                                            )                                                          ],                                                        ),                                                      ],                                                    ),                                                  ),                                                );                                              });                                            },                                          );                                        },                              child: const Text("Start Now")),                        ],                      ),                    ),                  );      }),    );  }}