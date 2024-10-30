// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:schoolworkspro_app/Screens/lecturer/lecturer_common_view_model.dart';
import 'package:schoolworkspro_app/Screens/widgets/snack_bar.dart';
import 'package:schoolworkspro_app/common_view_model.dart';
import 'package:schoolworkspro_app/request/lecturer/addassessment_request.dart';
import 'package:schoolworkspro_app/services/lecturer/addassessment_service.dart';

import '../../../api/repositories/lecturer/homework_repository.dart';
import '../../../config/api_response_config.dart';
import '../../../constants/colors.dart';
import '../../../response/file_upload_response.dart';

class EditActivityScreen extends StatefulWidget {
  final data;

  const EditActivityScreen({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  _EditActivityScreenState createState() => _EditActivityScreenState();
}

class _EditActivityScreenState extends State<EditActivityScreen> {
  final HtmlEditorController controller = HtmlEditorController();

  List<String> selected_batch = <String>[];
  bool visibility = false;
  final TextEditingController datecontroller = new TextEditingController();
  // late CommonViewModel _provider;
  DateTime? duedate;
  bool isloading = false;
  DateTime startDate = DateTime.now();
  late CommonViewModel _provider4;

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _provider4 = Provider.of<CommonViewModel>(context, listen: false);

      _provider4.setSlug(widget.data["moduleSlug"]);
      _provider4.fetchBatches();
    });

    print("BATCH::::${widget.data['batches']}");

    selected_batch = List<String>.from(widget.data['batches'] as List<dynamic>);

    datecontroller.text = parseDate(widget.data['dueDate']);
    DateTime dd = DateTime.parse(widget.data['dueDate'].toString());
    setState(() {
      duedate = dd;
    });
    super.initState();
  }

  Future uploadFile(PlatformFile file) async {
    if (file != null) {

      FileUploadResponse res = await HomeworkRepository().addHomeWorkFile(file.path.toString(), file.name);

      try{
        setState(() {
          isloading = true;
        });
        if (res.success == true) {
          controller.insertLink(file.name, res.link.toString(), true);
          setState(() {
            isloading = false;
          });
        }
        else{
          setState(() {
            isloading = false;
          });
        }
      }on Exception catch (e) {
        setState(() {
          isloading = true;
        });
        print("EXCEPTION:::${e.toString()}");
        Navigator.of(context).pop();
        setState(() {
          isloading = false;
        });
      }
    }
    else {
      // no file pick

    }
  }

  String parseDate(data) {
    DateTime now = DateTime.parse(data.toString());

    now = now.add(const Duration(hours: 5, minutes: 45));

    var formattedTime = DateFormat('yyyy-MM-dd – hh:mm a').format(now);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        // iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: const Text(
          "Edit Task",
          style: TextStyle(color: white),
        ),
      ),
      body: Consumer2<CommonViewModel, LecturerCommonViewModel>(
          builder: (context, data, lecturer, child) {
        return isLoading(data.atchesApiResponse) ? Center(child: CupertinoActivityIndicator()) :
        ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            const Text(
              "Due Date",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            DateTimePicker(
              type: DateTimePickerType.dateTimeSeparate,
              dateMask: 'd MMM, yyyy hh:mm a',
              // controller: datecontroller,
              initialValue: DateTime.parse(widget.data['dueDate']).add(Duration(hours: 5, minutes: 45)).toString(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: const Icon(Icons.event),
              dateLabelText: 'Date',
              timeLabelText: "Hour",
              timePickerEntryModeInput: true,

              // selectableDayPredicate: (date) {
              //   if (date.weekday == 6 || date.weekday == 7) {
              //     return false;
              //   }
              //
              //   return true;
              // },
              onChanged: (val) {
                setState(() {
                  duedate = DateTime.parse(val);
                  print("THIS IS DATEE:::::${duedate.toString()}");
                });
              },
              validator: (val) {
                print(val);
                return null;
              },
              // onSaved: (val) {
              //   setState(() {
              //     duedate = DateTime.parse(val);
              //   });
              //
              // },
            ),
            // InkWell(
            //   onTap: () {
            //     setState(() {
            //       visibility = !visibility;
            //     });
            //   },
            //   child: ExpansionTile(
            //     title: TextFormField(
            //       enabled: false,
            //       controller: datecontroller,
            //       decoration: const InputDecoration(
            //         hintText: 'Select Due Date',
            //         prefixIcon: Icon(Icons.lock_clock),
            //         filled: true,
            //         enabledBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.grey)),
            //         focusedBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.green)),
            //       ),
            //     ),
            //     children: [
            //       Container(
            //         height: 200,
            //         child: CupertinoDatePicker(
            //           minimumDate: DateTime.now(),
            //           mode: CupertinoDatePickerMode.dateAndTime,
            //           initialDateTime: DateTime.now(),
            //           onDateTimeChanged: (DateTime newDateTime) {
            //             //Do Some thing
            //
            //             var formattedTime = DateFormat('yyyy-MM-dd – hh:mm a')
            //                 .format(newDateTime);
            //             setState(() {
            //               duedate = newDateTime
            //                   .subtract(Duration(hours: 5, minutes: 45));
            //               datecontroller.text = formattedTime.toString();
            //             });
            //           },
            //           use24hFormat: false,
            //           minuteInterval: 1,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Select Batches/Sections",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            MultiSelectDialogField(
              // validator: ,
              items: data.batchArr.map((e) => MultiSelectItem(e, e)).toList(),
              listType: MultiSelectListType.CHIP,
              initialValue: selected_batch,
              autovalidateMode: AutovalidateMode.always,
              onConfirm: (List<String> values) {
                setState(() {
                  selected_batch = values;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Content",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            HtmlEditor(
              controller: controller,
              htmlEditorOptions: HtmlEditorOptions(
                // filePath: ,
                //open link
                shouldEnsureVisible: true,

                hint: "Your text here...",
                initialText: widget.data['contents'],
              ),

              htmlToolbarOptions: HtmlToolbarOptions(
                defaultToolbarButtons: [
                  const StyleButtons(),
                  const FontSettingButtons(),
                  const ListButtons(),
                  const ParagraphButtons(),
                  const InsertButtons(otherFile: true, video: false, audio: false),
                  const OtherButtons(
                    copy: false,
                    paste: false,
                  ),
                ],
                onOtherFileUpload: (file) async {
                  var response = await uploadFile(file);
                  return response;
                },
                toolbarPosition: ToolbarPosition.aboveEditor,
                toolbarType: ToolbarType.nativeExpandable,

                mediaLinkInsertInterceptor: (String url, InsertFileType type) {
                  return true;
                },
                mediaUploadInterceptor: (PlatformFile file, InsertFileType type) async {
                  return true;
                },
              ),
              otherOptions: OtherOptions(height: 500, decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4.0)),),
            ),

            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () async {
                  try {
                    data.setLoading(true);
                    var content = await controller.getText();

                    final request = AddAssessmentRequest(
                        batches: selected_batch,
                        contents: content,
                        dueDate: duedate?.toUtc(),
                        lessonSlug: widget.data["lessonSlug"]);
                    final res = await Addactivityservice()
                        .updateAssessment(request, widget.data['_id']);
                    if (res.success == true) {
                      Navigator.of(context).pop();
                      lecturer.fetchinsideactivity(widget.data["lessonSlug"]);
                      snackThis(
                          context: context,
                          color: Colors.green,
                          duration: 2,
                          content: Text(res.message.toString()));
                    } else {
                      snackThis(
                          context: context,
                          color: Colors.red,
                          duration: 2,
                          content: Text(res.message.toString()));
                    }
                    data.setLoading(false);
                  } on Exception catch (e) {
                    data.setLoading(true);
                    snackThis(
                        context: context,
                        color: Colors.red,
                        duration: 2,
                        content: Text(e.toString()));
                    data.setLoading(false);
                  }
                },
                child: const Text("Update")),
            SizedBox(
              height: 100,
            ),
          ],
        );
      }),
    );
  }
}
