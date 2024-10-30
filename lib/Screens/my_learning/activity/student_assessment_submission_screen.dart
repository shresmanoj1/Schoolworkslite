import 'dart:convert';import 'package:file_picker/file_picker.dart';import 'package:flutter/material.dart';import 'package:html_editor_enhanced/html_editor.dart';import 'package:html_editor_enhanced/utils/options.dart';import 'package:loader_overlay/loader_overlay.dart';import 'package:shared_preferences/shared_preferences.dart';import '../../../api/repositories/lecturer/homework_repository.dart';import '../../../api/repositories/student_assessement_repo.dart';import '../../../response/file_upload_response.dart';import '../../../response/login_response.dart';import '../../widgets/snack_bar.dart';class StudentAssessmentSubmissionScreen extends StatefulWidget {  final dynamic taskValue;  const StudentAssessmentSubmissionScreen({Key? key, required this.taskValue})      : super(key: key);  @override  State<StudentAssessmentSubmissionScreen> createState() =>      _StudentAssessmentSubmissionScreenState();}class _StudentAssessmentSubmissionScreenState    extends State<StudentAssessmentSubmissionScreen> {  final HtmlEditorController controller = HtmlEditorController();  bool isloading = false;  late User user;  Future uploadFile(PlatformFile file) async {    setState(() {      isloading = true;    });    if (file != null) {      FileUploadResponse res = await HomeworkRepository()          .addHomeWorkFile(file.path.toString(), file.name);      setState(() {        isloading = true;      });      try {        if (res.success == true) {          controller.insertLink(file.name, res.link.toString(), true);          setState(() {            isloading = false;          });        } else {          setState(() {            isloading = false;          });        }      } on Exception catch (e) {        setState(() {          isloading = true;        });        print("EXCEPTION:::${e.toString()}");        Navigator.of(context).pop();        setState(() {          isloading = false;        });      }    } else {      setState(() {        isloading = false;      }); // no file pick    }  }  initState() {    super.initState();    getUser();  }  getUser() async {    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();    String? userData = sharedPreferences.getString('_auth_');    Map<String, dynamic> userMap = json.decode(userData!);    User userD = User.fromJson(userMap);    setState(() {      user = userD;    });  }  @override  Widget build(BuildContext context) {    if (isloading == true) {      context.loaderOverlay.show();    } else {      context.loaderOverlay.hide();    }    return Scaffold(        appBar: AppBar(            title: const Text(              "Submit Task",              style: TextStyle(color: Colors.black),            ),            elevation: 0.0,            iconTheme: const IconThemeData(              color: Colors.black,            ),            backgroundColor: Colors.white),        body: ListView(          shrinkWrap: true,          physics: const BouncingScrollPhysics(),          children: [            HtmlEditor(              controller: controller,              htmlEditorOptions: HtmlEditorOptions(                initialText: widget.taskValue["isUpdate"] == true                    ? widget.taskValue["content"]                    : "",                shouldEnsureVisible: true,                hint: "Place Your Content Here!",              ),              htmlToolbarOptions: HtmlToolbarOptions(                defaultToolbarButtons: [                  const StyleButtons(),                  const FontSettingButtons(),                  const ListButtons(),                  const ParagraphButtons(),                  const InsertButtons(                      otherFile: true, video: false, audio: false),                  const OtherButtons(                    copy: false,                    paste: false,                  ),                ],                onOtherFileUpload: (file) async {                  print(file);                  var response = await uploadFile(file);                  print(response);                  return response;                },                toolbarPosition: ToolbarPosition.aboveEditor,                toolbarType: ToolbarType.nativeExpandable,                mediaLinkInsertInterceptor: (String url, InsertFileType type) {                  print(url);                  return true;                },                mediaUploadInterceptor:                    (PlatformFile file, InsertFileType type) async {                  return true;                },              ),              otherOptions: OtherOptions(height: 500, decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4.0)),),            ),            const SizedBox(              height: 10,            ),            Row(              mainAxisAlignment: MainAxisAlignment.center,              children: [                ElevatedButton(                    onPressed: () async {                      setState(() {                        isloading = true;                      });                      try {                        var content = await controller.getText();                        String datas = jsonEncode({                          "assessmentId": widget.taskValue['assessmentId'],                          "contents": content,                          "lessonSlug": widget.taskValue["lessonSlug"],                          "submittedBy": user.username                        });                        final res = await StudentAssessmentRepository()                            .addAssessment(datas, widget.taskValue['isUpdate']);                        if (res.success == true) {                          setState(() {                            isloading = false;                          });                          Navigator.of(context).pop();                          snackThis(                              context: context,                              color: Colors.green,                              duration: 2,                              content: Text(res.message.toString()));                        } else {                          setState(() {                            isloading = false;                          });                          snackThis(                              context: context,                              color: Colors.red,                              duration: 2,                              content: Text(res.message.toString()));                        }                      } on Exception catch (e) {                        setState(() {                          isloading = false;                        });                        snackThis(                            context: context,                            color: Colors.red,                            duration: 2,                            content: Text(e.toString()));                      }                    },                    child: const Text('Submit')),              ],            )          ],        ));  }}