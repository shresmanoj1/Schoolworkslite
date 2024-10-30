import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_version/new_version.dart';
import 'package:open_url/open_url.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:schoolworkspro_app/api/api.dart';
import 'package:schoolworkspro_app/common_view_model.dart';
import 'package:schoolworkspro_app/components/internetcheck.dart';
import 'package:schoolworkspro_app/components/nointernet_widget.dart';
import 'package:schoolworkspro_app/constants.dart';
import 'package:intl/intl.dart';
import 'package:schoolworkspro_app/response/notice_response.dart';
import 'package:schoolworkspro_app/services/notice_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/api_response_config.dart';
import '../../constants/colors.dart';
import '../../constants/text_style.dart';

class Notice extends StatefulWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  // late Stream<Noticeresponse> notice_Model;
  // late Future<Noticeresponse> noticel;
  // int notificationCount = 0;
  bool connected = true;
  final int maxCharacters = 100;

  late ScrollController _scrollController;
  bool _showBackToTopButton = false;
  late CommonViewModel _commonViewModel;
  ScrollPhysics _physics = ClampingScrollPhysics();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _commonViewModel = Provider.of<CommonViewModel>(context, listen: false);
    });

    checkversion();
    checkInternet();

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          loadMore();
        }
        setState(() {
          if (_scrollController.offset >= 300) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
          if (_scrollController.position.pixels <= 60) {
            _physics = const BouncingScrollPhysics();
          } else {
            _physics = const ClampingScrollPhysics();
          }
        });
      });
    super.initState();
  }

  Future<void> loadMore() async {
    await _commonViewModel.loadMore();
  }

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
        // snackThis(context: context,content: const Text("No Internet Connection"),duration: 10,color: Colors.red.shade500);
        // Fluttertoast.showToast(msg: "No Internet connection");
      }
    });
  }

  handleRefresh(CommonViewModel common) {
    common.fetchNotice();
  }

  checkversion() async {
    try {
      final new_version = NewVersion(
        androidId: "np.edu.digitech.schoolworksprolite",
        iOSId: "np.edu.digitech.schoolworksprolite",
      );

      final status = await new_version.getVersionStatus();
      print('heello world:::' + status!.storeVersion);
      print('heello world:::' + status.localVersion);

      if (Platform.isAndroid) {
        if (status.localVersion != status.storeVersion) {
          new_version.showUpdateDialog(
              dialogText: "You need to update this application",
              context: context,
              versionStatus: status);
        }
      } else if (Platform.isIOS) {
        if (status.canUpdate) {
          new_version.showUpdateDialog(
              dialogText: "You need to update this application",
              context: context,
              versionStatus: status);
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<CommonViewModel>(
      builder: (context, value, child) {
        return connected == false
            ? const NoInternetWidget()
            : RefreshIndicator(
                onRefresh: () async {
                  await handleRefresh(value);
                },
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  controller: _scrollController,
                  physics: _physics,
                  children: [
                    isLoading(value.noticeApiResponse)
                        ? const Center(child: CupertinoActivityIndicator())
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: value.notice.length,
                            itemBuilder: (context, index) {
                              var notice = value.notice[index];

                              DateTime now =
                                  DateTime.parse(notice.createdAt.toString());

                              now = now
                                  .add(const Duration(hours: 5, minutes: 45));

                              var formattedTime =
                                  DateFormat('dd MMM yyyy - hh:mm a')
                                      .format(now);

                              var publishedBy =
                                  "${notice.postedBy?.firstname} ${notice.postedBy?.lastname}";
                              var nameInital =
                                  "${notice.postedBy!.firstname![0].toUpperCase()}${notice.postedBy!.lastname![0].toUpperCase()}";

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Card(
                                  elevation: 3.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: notice.postedBy!.userImage !=
                                                null
                                            ? CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    '$api_url2/uploads/users/${notice.postedBy!.userImage!}'))
                                            : CircleAvatar(
                                                backgroundColor: Colors.grey,
                                                child: Text(
                                                  nameInital,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                        title: Text(
                                            notice.noticeTitle.toString(),
                                            style: p16.copyWith(
                                                fontWeight: FontWeight.w800)),
                                        subtitle: Text(publishedBy,
                                            style: p14.copyWith(
                                                color: Colors.black
                                                    .withOpacity(0.6))),
                                      ),
                                      NoticeContent(
                                        noticeContent:
                                            notice.noticeContent.toString(),
                                      ),

                                      //         Padding(
                                      //           padding: const EdgeInsets.all(16.0),
                                      //           child: ReadMoreText(
                                      //             removeLinks(
                                      //                 notice.noticeContent.toString()),
                                      //             style: TextStyle(
                                      //               color: Colors.black.withOpacity(0.6),
                                      //             ),
                                      //             trimLines: 3,
                                      //             // colorClickableText: Colors.blueAccent,
                                      //             trimMode: TrimMode.Line,
                                      //             trimCollapsedText: ' Read more',
                                      //             trimExpandedText: ' Less',
                                      //           ),
                                      //         ),
                                      //         ...getLinks(
                                      //           notice.noticeContent.toString(),
                                      //         ).map((link) => Padding(
                                      //           padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                      //           child: InkWell(
                                      //               onTap:(){
                                      //                 _launchinLineUrl(link.toString())            ;
                                      // },
                                      //               child: Text(link.toString(),style: TextStyle(color: Colors.blue),)),
                                      //         )),

                                      // RichText(
                                      //   text: TextSpan(
                                      //     children: getNotificationTextSpans(
                                      //         notice.noticeContent.toString()),
                                      //   ),
                                      // ),

                                      notice.filename == null
                                          ? const SizedBox.shrink()
                                          : TextButton(
                                              child: Text(
                                                  notice.filename.toString(),
                                                  style: p14.copyWith(
                                                      color: Colors.blue)),
                                              onPressed: () {
                                                _launchURL(
                                                  notice.filename
                                                      .toString()
                                                      .replaceAll(" ", "%20"),
                                                );
                                                // html.window
                                                //     .open('www.facebook.com', "filename");
                                              },
                                            ),
                                      ButtonBar(
                                        alignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            formattedTime,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                    isLoadingOnly(value.loadMoreApiResponse)
                        ? Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const SizedBox(
                                height: 100,
                                child: Center(
                                    child: CircularProgressIndicator(
                                        color: black))))
                        : const SizedBox(),
                  ],
                ),
              );
      },
    ));
  }
}

_launchURL(String abc) async {
  String url = api_url2 + '/uploads/files/' + abc;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchinLineUrl(String abc) async {
  String url = abc;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class NoticeContent extends StatefulWidget {
  final String? noticeContent;

  const NoticeContent({Key? key, this.noticeContent}) : super(key: key);

  @override
  State<NoticeContent> createState() => _NoticeContentState();
}

class _NoticeContentState extends State<NoticeContent> {
  final int maxCharacters = 200;

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return buildNoticeContent(widget.noticeContent.toString());
  }

  Widget buildNoticeContent(String noticeContent) {
    if (noticeContent.length > maxCharacters) {
      final String truncatedText =
          '${noticeContent.substring(0, maxCharacters)}...';
      final List<InlineSpan> inlineSpans = [];
      final RegExp exp = RegExp(
        r'(http[s]?:\/\/[^\s]+)',
        caseSensitive: false,
      );



      int start = 0;

      exp.allMatches(noticeContent).toList().forEach((match) {
        final String? link = match.group(0);

        inlineSpans.add(TextSpan(
          text: noticeContent.substring(start, match.start),
          style: p14.copyWith(color: black),
        ));

        inlineSpans.add(
          WidgetSpan(
            child: InkWell(
              onTap: () {
                _launchinLineUrl(link.toString());
              },
              child: Text(
                link.toString(),
                style: p14.copyWith(color: Colors.blue),
              ),
            ),
          ),
        );

        start = match.end;
      });

      if (start < noticeContent.length) {
        inlineSpans.add(TextSpan(
          text: noticeContent.substring(start),
          style: p14.copyWith(color: black),
        ));
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  if (isExpanded)
                    ...inlineSpans
                  else
                    TextSpan(
                      text: truncatedText,
                      style: p14.copyWith(color: black),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            isExpanded = true;
                          });
                        },
                    ),
                  if (!isExpanded)
                    TextSpan(
                      text: ' Read More',
                      style: p14.copyWith(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            isExpanded = true;
                          });
                        },
                    ),
                ],
              ),
            ),
            if (isExpanded) const SizedBox(height: 8.0),
            if (isExpanded)
              InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = false;
                  });
                },
                child: Text(
                  'Read Less',
                  style: p14.copyWith(color: Colors.blue),
                ),
              ),
          ],
        ),
      );
    } else {
      final String truncatedText =
          '${noticeContent.substring(0, noticeContent.length)}...';
      final List<InlineSpan> inlineSpans = [];
      final RegExp exp = RegExp(
        r'(http[s]?:\/\/[^\s]+)',
        caseSensitive: false,
      );

      int start = 0;

      exp.allMatches(noticeContent).toList().forEach((match) {
        final String? link = match.group(0);

        inlineSpans.add(TextSpan(
          text: noticeContent.substring(start, match.start),
          style: p14.copyWith(color: black),
        ));

        inlineSpans.add(
          WidgetSpan(
            child: InkWell(
              onTap: () {
                _launchinLineUrl(link.toString());
              },
              child: Text(
                link.toString(),
                style: p14.copyWith(color: Colors.blue),
              ),
            ),
          ),
        );

        start = match.end;
      });

      if (start < noticeContent.length) {
        inlineSpans.add(TextSpan(
          text: noticeContent.substring(start),
          style: p14.copyWith(color: black),
        ));
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: inlineSpans,
              ),
            ),
          ],
        ),
      );

      // return Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
      //   child: Text(
      //     noticeContent,
      //     style: p14.copyWith(color: black),
      //   ),
      // );
    }
  }
}
