import 'package:flutter/material.dart';
import 'package:schoolworkspro_app/api/api_response.dart';
import 'package:schoolworkspro_app/api/repositories/lecturer/notice_repository.dart';
import 'package:schoolworkspro_app/api/repositories/principal/notice_repo.dart';
import 'package:schoolworkspro_app/response/principal/mynoticeprincipal_response.dart';
import 'package:schoolworkspro_app/response/principal/newsannouncement_response.dart';

class AnnouncementViewModel with ChangeNotifier {
  ApiResponse _announcementApiResponse = ApiResponse.initial('Empty data');
  ApiResponse _loadMoreApiResponse = ApiResponse.initial('Empty data');

  ApiResponse get announcementApiResponse => _announcementApiResponse;
  ApiResponse get loadMoreApiResponse => _loadMoreApiResponse;

  int _page = 1;
  int _totalData = 0;
  bool _hasMore = true;
  int get page => _page;
  int _size = 10;
  int get size => _size;
  int get totalData => _totalData;
  bool get hasMore => _hasMore;

  setPage(int pagess) {
    _page = pagess;
    notifyListeners();
  }

  List<Notice> _notices = <Notice>[];
  List<Notice> get notices => _notices;

  Future<void> loadMore() async {
    _page = _page + 1;
    _loadMoreApiResponse = ApiResponse.loading('Fetching device data');
    notifyListeners();
    try {
      NewsAnnouncementResponse data =
          await NoticePrincipalRepository().getnewsandannouncment([
        {"page": _page.toString()},
      ]);
      _notices.addAll(data.notices!);

      _loadMoreApiResponse = ApiResponse.completed(data);
      notifyListeners();
    } catch (e) {
      _loadMoreApiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> fetchannouncement() async {
    _announcementApiResponse = ApiResponse.loading('Fetching device data');
    notifyListeners();
    try {
      NewsAnnouncementResponse data =
          await NoticePrincipalRepository().getnewsandannouncment([
        {"page": "1"},
      ]);

      _notices = data.notices!;

      _announcementApiResponse = ApiResponse.completed(data);
      _loadMoreApiResponse = ApiResponse.completed(data);
      // _loadMoreApiResponse = ApiResponse.completed(data);
      notifyListeners();
    } catch (e) {
      _announcementApiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _page = 1;
    _size = 10;
    _totalData = 0;
    _hasMore = true;

    super.dispose();
  }

  ApiResponse _mynoticeApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get mynoticeApiResponse => _mynoticeApiResponse;
  List<dynamic> _mynotice = <dynamic>[];
  List<dynamic> get mynotice => _mynotice;

  Future<void> fetchmynotices() async {
    _mynoticeApiResponse = ApiResponse.initial("Loading");
    notifyListeners();
    try {
      Mynoticeesponse res = await NoticePrincipalRepository().getmynotices();
      if (res.success == true) {
        _mynotice = res.notices!;

        _mynoticeApiResponse = ApiResponse.completed(res.success.toString());
        notifyListeners();
      } else {
        _mynoticeApiResponse = ApiResponse.error(res.success.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _mynoticeApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:gyapu_seller/api/api_response.dart';
// import 'package:gyapu_seller/api/repositories/activeorder_repository.dart';
// import 'package:gyapu_seller/api/repositories/payment_respository.dart';
// import 'package:gyapu_seller/api/responses/activeorder_respone.dart';
// import 'package:gyapu_seller/api/responses/paymentinfo_response.dart';
// import 'package:gyapu_seller/api/utils/loading.dart';
//
// final List<String> _typeList = [
//   "order",
//   "processing",
//   "package_by_seller,package_received_by_admin",
//   "delivered",
//   "ancelled,returned"
// ];
//
// int _total = _typeList.length;
// String _search = "";
// String get search => _search;
//
// String search_type = "";
// String get type => search_type;
//
// class ActiveorderViewModel with ChangeNotifier {
//   void removeActive(String id) {
//     try {
//       _ordersellerDataList[0].removeWhere((element) => element.id == id);
//     } catch (e) {}
//   }
//
//   int get total => _total;
//
//   // YUP list
//   final List<ApiResponse> _ordersellerApiResponse = List.generate(
//       _total, (index) => ApiResponse.initial('Fetching device data'));
//   final List<ApiResponse> _loadMoreApiResponse = List.generate(
//       _total, (index) => ApiResponse.initial('Fetching device data'));
//   List<int> _page = List.generate(_total, (index) => 1);
//   List<int> _size = List.generate(_total, (index) => 10);
//   List<int> _totalData = List.generate(_total, (index) => 0);
//   List<bool> _hasMore = List.generate(_total, (index) => true);
//   List<bool> _first = List.generate(_total, (index) => true);
//
//   List<ApiResponse> get ordersellerApiResponse => _ordersellerApiResponse;
//   List<ApiResponse> get loadMoreApiResponse => _loadMoreApiResponse;
//
//   List<List<dynamic>> _ordersellerDataList =
//       List.generate(_total, (index) => []);
//   List<List<dynamic>> get ordersellerDataList => _ordersellerDataList;
//
//   List<int> get page => _page;
//   List<int> get size => _size;
//   List<int> get totalData => _totalData;
//   List<bool> get hasMore => _hasMore;
//
//   List<String> get typeList => _typeList;
//   String find_status = "payment_due";
//
//   Future<void> changeType(int index) async {
//     // if(_type !=_typeList[index] ){
//     find_status = _typeList[index];
//     _page[index] = 1;
//     _size[index] = 10;
//     _totalData[index] = 0;
//     await getactiveorder(
//       index,
//       true,
//       "",
//       "",
//     );
//     // }
//   }
//
//   setSearch(int index, String search, String type) {
//     _search = search;
//     _page[index] = 1;
//     getactiveorder(index, true, "", "", type: type);
//   }
//
//   setType(String type) {
//     search_type = type;
//   }
//
//   Future<void> getactiveorder(
//       int index, bool revert, String _startDate, String _endDate,
//       {String? type}) async {
//     print("GETTING ORDER ");
//     if (revert) {
//       _first[index] = true;
//       _hasMore[index] = true;
//     }
//     if (_first[index] == true) {
//       _ordersellerApiResponse[index] =
//           ApiResponse.loading('Fetching device data');
//       notifyListeners();
//
//       try {
//         Activeorderresponse data = await Activeorderrepository().activeorder([
//           {"find_is_order": "true"},
//           {'$type': _search.toString()},
//           {"size": (_size[index] * _page[index]).toString()},
//           {"page": "1"},
//           {"find_status": find_status.toString()},
//           {"find_start_date": _startDate},
//           {"find_end_date": _endDate},
//         ]);
//         _totalData[index] = data.totaldata!;
//         _hasMore[index] = _totalData[index] > _page[index] * _size[index];
//         _ordersellerDataList[index] = data.data!;
//         _ordersellerApiResponse[index] = ApiResponse.completed(data);
//         notifyListeners();
//       } catch (e) {
//         print("ERR BOTTOM :: " + e.toString());
//         _ordersellerApiResponse[index] = ApiResponse.error(e.toString());
//         notifyListeners();
//       }
//       notifyListeners();
//       _first[index] = false;
//     }
//   }
//
//   Future<void> loadMore(
//     int index,
//     String _startDate,
//     String _endDate,
//       {String? type}
//   ) async {
//     if (hasMore[index] && !isLoadingOnly(_loadMoreApiResponse[index])) {
//       _page[index] += 1;
//       _loadMoreApiResponse[index] = ApiResponse.loading('Fetching device data');
//       notifyListeners();
//       try {
//         PaymentInforesponse data = await PaymentRepository().paymentinfo([
//           {"find_is_order": "true"},
//           {"size": (_size[index] * 1).toString()},
//           {"page": _page[index].toString()},
//           {"find_status": find_status.toString()},
//           {'$type': _search.toString()},
//           {"find_start_date": _startDate},
//           {"find_end_date": _endDate},
//         ]);
//         _ordersellerDataList[index].addAll(data.data!.toList());
//         _hasMore[index] = _totalData[index] > _page[index] * _size[index];
//         // print("MORE ::" + _hasMore.toString());
//         _loadMoreApiResponse[index] = ApiResponse.completed(data);
//         notifyListeners();
//       } catch (e) {
//         _loadMoreApiResponse[index] = ApiResponse.error(e.toString());
//         notifyListeners();
//       }
//       await Future.delayed(const Duration(milliseconds: 20));
//       _loadMoreApiResponse[index] = ApiResponse.initial("Empty data");
//       notifyListeners();
//     }
//   }
//
//   @override
//   void dispose() {
//     _page = [];
//     _size = [];
//     _totalData = [];
//     _hasMore = [];
//     find_status = "order";
//     super.dispose();
//   }
// }
