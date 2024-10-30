// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:gyapu_seller/api/api.dart';
// import 'package:gyapu_seller/api/utils/loading.dart';
// import 'package:gyapu_seller/constants/colors.dart';
// import 'package:gyapu_seller/screens/product/view_model/productdetail_viewmodel.dart';
// import 'package:gyapu_seller/screens/widgets/custom_shimmer.dart';
// import 'package:matrix2d/matrix2d.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:collection/collection.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gyapu_seller/api/models/category.dart' hide Image;
// import 'package:gyapu_seller/api/models/product_type.dart';
// import 'package:gyapu_seller/api/repositories/product_repository.dart';
// import 'package:gyapu_seller/api/request/addproduct_request.dart';
// import 'package:gyapu_seller/api/responses/addproduct_response.dart'
//     hide Volume;
// import 'package:gyapu_seller/api/responses/brand_response.dart';
// import 'package:gyapu_seller/api/responses/manufacturer_response.dart';
// import 'package:gyapu_seller/api/responses/stockstatus_response.dart';
// import 'package:gyapu_seller/constants/alert_style.dart';
// import 'package:gyapu_seller/screens/product/add_product/components/gridimage_picker.dart';
// import 'package:gyapu_seller/screens/product/view_model/product_view_model.dart';
// import 'package:gyapu_seller/widget/input_container.dart';
// import 'package:number_inc_dec/number_inc_dec.dart';
// import 'package:provider/provider.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:shimmer/shimmer.dart';
//
// class DetailEditscreenBody extends StatefulWidget {
//   final prd;
//
//   const DetailEditscreenBody({Key? key, this.prd}) : super(key: key);
//
//   @override
//   _DetailEditscreenBodyState createState() => _DetailEditscreenBodyState();
// }
//
// class _DetailEditscreenBodyState extends State<DetailEditscreenBody> {
//   String? replacedurl;
//   TextEditingController productnamecontroller = TextEditingController();
//   TextEditingController urlkeycontroller = TextEditingController();
//   TextEditingController skusystemcontroller = TextEditingController();
//   TextEditingController skusellercontroller = TextEditingController();
//   TextEditingController skusellercontrollerinventory = TextEditingController();
//   TextEditingController tagscontroller = TextEditingController();
//   TextEditingController descriptioncontroller = TextEditingController();
//   TextEditingController heightcontroller = TextEditingController();
//   TextEditingController widthcontroller = TextEditingController();
//   TextEditingController lengthcontroller = TextEditingController();
//   TextEditingController weightcontroller = TextEditingController();
//   TextEditingController minimumordercontroller = TextEditingController();
//   TextEditingController maximumordercontroller = TextEditingController();
//   TextEditingController skusellerpricecontroller = TextEditingController();
//   TextEditingController pricecontroller = TextEditingController();
//   TextEditingController salespricecontroller = TextEditingController();
//   TextEditingController customtitle = TextEditingController();
//   TextEditingController customvalue = TextEditingController();
//   TextEditingController type1controller = TextEditingController();
//   TextEditingController type2controller = TextEditingController();
//   TextEditingController option1controller = TextEditingController();
//   TextEditingController option2controller = TextEditingController();
//   TextEditingController inventorycountcontroller = TextEditingController();
//   TextEditingController minimumstockwarningtrackabletruecontroller =
//       TextEditingController();
//   List<String>? selecteditemse = [];
//   List<TextEditingController> _controllers = [];
//   List<TextEditingController> _pricecontrollers = [];
//   List<TextEditingController> _salespricecontrollers = [];
//   List<TextEditingController> _inventorymultivarianttrue = [];
//   List<TextEditingController> _minstockwarningmultiple = [];
//   List<TextEditingController> _skumultivarianttrue = [];
//   List<TextField> _fields = [];
//   onSelectedRow(bool selected, dynamic items) async {
//     setState(() {
//       if (selected) {
//         selecteditemse!.add(items);
//       } else {
//         selecteditemse!.remove(items);
//       }
//     });
//   }
//
//   List option1 = [];
//   List option2 = [];
//
//   List output1 = [];
//   bool generalvisible = true;
//   bool attributesvisible = false;
//   bool inventoryvisible = false;
//   bool pricesvisible = false;
//   bool imagesvisible = false;
//   bool statusvisible = false;
//   bool trackable = false;
//   bool multivariationvisibility = false;
//
//   bool isSwitched1 = false;
//   bool check_availability = false;
//   bool active_status = false;
//   bool isSwitched2 = false;
//   bool istrackable = false;
//   bool ismultiplevariation = false;
//   bool trackableandmultiplevariation = false;
//   List<String>? _selectedstatusmultiple = [];
//
//   // List stock_status = ["In Stock", "Out of Stock"];
//   String? _myState;
//   double val = 0.0;
//
//   String? selected_status;
//   // List<dynamic>? varient_list = [];`
//   String? project_type;
//
//   List<String> imageList = [];
//   // List<InventoryTypeElement> inventory_type = [];
//   updateImage(images) {
//     setState(() {
//       imageList = images;
//       print(imageList);
//     });
//   }
//
//   final _formKey = GlobalKey<FormState>();
//
//   List<CategoryDropdown> category_dropdown = <CategoryDropdown>[];
//   List<ProductTypedropdowm> producttype_dropdown = <ProductTypedropdowm>[];
//   List<Branddropdowm> brand_dropdown = <Branddropdowm>[];
//   List<Manufacturerdropdowm> manufacturer_dropdown = <Manufacturerdropdowm>[];
//   List<Stockstatusdropdown> stockstatus_dropdown = <Stockstatusdropdown>[];
//   String? selected_stockstatus;
//   List<String> dropdownstatus = <String>[];
//   List<String> tags_list = <String>[];
//   List<CustomAttribute> custom_attribute = [];
//   // List<Document> document_list = [];
//
//   String? selected_category;
//   String? selected_productype;
//   String? selected_brand;
//   String? selected_manufacturer;
//   List<dynamic> varient_typetest = [];
//   List<Variant> varient_test = [];
//   List fst = [];
//   List<InventoryTypeElement> inventory_type = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       ProductDetailViewModel _provider =
//           Provider.of<ProductDetailViewModel>(context, listen: false);
//       _provider.getProductDetail(widget.prd).then((value) {
//         for (int s = 0; s < _provider.productdetailData['image'].length; s++) {
//           setState(() {
//             imageList.add(IMAGE_DOMAIN +
//                 "/" +
//                 _provider.productdetailData['image'][s]['document']['path']);
//           });
//           // updateImage(images)
//           print(imageList);
//         }
//       });
//     });
//     getdropdown();
//     super.initState();
//   }
//
//   showAlertDialog(BuildContext context) {
//     // set up the button
//     Widget okButton = TextButton(
//       child: const Text("Yes"),
//       onPressed: () {},
//     );
//     Widget cancelButton = TextButton(
//       child: const Text("No"),
//       onPressed: () {},
//     );
//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       content: const Text(
//           "Changing inventory type will clear variants are you sure ?"),
//       actions: [
//         okButton,
//       ],
//     );
//   }
//
//   getdropdown() async {
//     final mr = await ProductViewModel().getnewmanufacturer();
//     final br = await ProductViewModel().getnewbrand();
//     final ptr = await ProductViewModel().getnewproducttype();
//     final cr = await ProductViewModel().getnewcategory();
//     final ss = await ProductViewModel().getstockstatus();
//
//     for (int index = 0; index < mr.data!.length; index++) {
//       setState(() {
//         manufacturer_dropdown.add(mr.data![index]);
//       });
//     }
//
//     for (int index2 = 0; index2 < br.data!.length; index2++) {
//       setState(() {
//         brand_dropdown.add(br.data![index2]);
//       });
//     }
//
//     for (int j = 0; j < ptr.data!.length; j++) {
//       setState(() {
//         producttype_dropdown.add(ptr.data![j]);
//       });
//     }
//
//     // for (int o = 0; o < cr.data!.length; o++) {
//     //   setState(() {
//     //     category_dropdown.add(cr.data![o]);
//     //   });
//     // }
//
//     for (int m = 0; m < ss.data!.length; m++) {
//       setState(() {
//         stockstatus_dropdown.add(ss.data![m]);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             // color: Colors.grey.shade200,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text('Completion'),
//                       Text(generalvisible == true
//                           ? '1/5'
//                           : attributesvisible == true
//                               ? '2/5'
//                               : inventoryvisible == true
//                                   ? '3/5'
//                                   : pricesvisible == true
//                                       ? '4/5'
//                                       : imagesvisible == true
//                                           ? '5/5'
//                                           : ' 5/5')
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: LinearProgressIndicator(
//                     value: val,
//                     backgroundColor: Colors.grey.shade300,
//                     color: Colors.green,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SafeArea(
//               child: SingleChildScrollView(
//                 child: Consumer<ProductDetailViewModel>(
//                     builder: (context, data, child) {
//                   isLoading(data.productDetailApiResponse)
//                       ? CustomShimmer(
//                           height: 200,
//                           size: 2,
//                           spacing: 2,
//                         )
//                       : productnamecontroller.text =
//                           data.productdetailData['name'].toString();
//                   isLoading(data.productDetailApiResponse)
//                       ? CustomShimmer(
//                           height: 200,
//                           size: 2,
//                           spacing: 2,
//                         )
//                       : urlkeycontroller.text =
//                           data.productdetailData['url_key'].toString();
//                   isLoading(data.productDetailApiResponse)
//                       ? CustomShimmer(
//                           height: 200,
//                           size: 2,
//                           spacing: 2,
//                         )
//                       : skusellercontroller.text =
//                           data.productdetailData['sku_of_seller'].toString();
//                   isLoading(data.productDetailApiResponse)
//                       ? CustomShimmer(
//                           height: 200,
//                           size: 2,
//                           spacing: 2,
//                         )
//                       : descriptioncontroller.text =
//                           data.productdetailData['description'].toString();
//                   for (int i = 0;
//                       i < data.productdetailData['tags'].length;
//                       i++) {
//                     tags_list.add(data.productdetailData['tags'][i]);
//                   }
//                   isLoading(data.productDetailApiResponse)
//                       ? CustomShimmer(
//                           height: 200,
//                           size: 2,
//                           spacing: 2,
//                         )
//                       : weightcontroller.text =
//                           data.productdetailData['weight'].toString() ?? "";
//                   isLoading(data.productDetailApiResponse)
//                       ? CustomShimmer(
//                           height: 200,
//                           size: 2,
//                           spacing: 2,
//                         )
//                       : heightcontroller.text =
//                           data.productdetailData['volume']['height'].toString();
//                   isLoading(data.productDetailApiResponse)
//                       ? CustomShimmer(
//                           height: 200,
//                           size: 2,
//                           spacing: 2,
//                         )
//                       : widthcontroller.text = data.productdetailData['volume']
//                                   ['width']
//                               .toString() ??
//                           "";
//                   this.active_status = data.productdetailData['is_active'];
//                   isLoading(data.productDetailApiResponse)
//                       ? CustomShimmer(
//                           height: 200,
//                           size: 2,
//                           spacing: 2,
//                         )
//                       : lengthcontroller.text =
//                           data.productdetailData['volume']['length'].toString();
//
//                   if (data.productdetailData['is_multiple_variation'] ==
//                       false) {
//                     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//                       ismultiplevariation = false;
//                     });
//                   } else if (data.productdetailData['is_multiple_variation'] ==
//                       true) {
//                     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//                       ismultiplevariation = true;
//                     });
//                   }
//
//                   if (data.productdetailData['is_trackable_inventory'] ==
//                       false) {
//                     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//                       istrackable = false;
//                     });
//                   } else if (data.productdetailData['is_trackable_inventory'] ==
//                       true) {
//                     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//                       istrackable = true;
//                     });
//                   }
//
//                   return Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         Visibility(
//                           visible: generalvisible,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // InputContainer(
//                                   //   abc: TextInputType.name,
//                                   //   controller: productnamecontroller,
//                                   //   isPasswordTextField: false,
//                                   //   labelText: "Name",
//                                   //   compulsory: "*",
//                                   // ),
//                                   Row(
//                                     children: [
//                                       const Text(
//                                         "General",
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       IconButton(
//                                           onPressed: () {
//                                             Fluttertoast.showToast(
//                                                 gravity: ToastGravity.TOP,
//                                                 msg:
//                                                     'General information of product customer will see');
//                                           },
//                                           icon: const Icon(
//                                             Icons.help_outline_outlined,
//                                             color: Colors.grey,
//                                             size: 20,
//                                           ))
//                                     ],
//                                   ),
//
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   TextFormField(
//                                     controller: urlkeycontroller,
//                                     decoration: InputDecoration(
//                                         labelStyle:
//                                             TextStyle(color: Colors.black),
//                                         filled: true,
//                                         enabledBorder: const OutlineInputBorder(
//                                             borderSide:
//                                                 BorderSide(color: Colors.grey)),
//                                         focusedBorder: const OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Colors.green)),
//                                         // border:
//                                         //     OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
//                                         floatingLabelBehavior:
//                                             FloatingLabelBehavior.always,
//                                         label: Row(
//                                           children: const [
//                                             Text('product name'),
//                                             Text(
//                                               '*',
//                                               style: TextStyle(
//                                                   color: Colors.red,
//                                                   fontSize: 25),
//                                             ),
//                                           ],
//                                         )),
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   TextFormField(
//                                     controller: urlkeycontroller,
//                                     decoration: InputDecoration(
//                                         labelStyle: const TextStyle(
//                                             color: Colors.black),
//                                         filled: true,
//                                         enabledBorder: const OutlineInputBorder(
//                                             borderSide:
//                                                 BorderSide(color: Colors.grey)),
//                                         focusedBorder: const OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Colors.green)),
//                                         // border:
//                                         //     OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
//                                         floatingLabelBehavior:
//                                             FloatingLabelBehavior.always,
//                                         label: Row(
//                                           children: const [
//                                             Text('url key'),
//                                             Text(
//                                               '*',
//                                               style: TextStyle(
//                                                   color: Colors.red,
//                                                   fontSize: 25),
//                                             ),
//                                           ],
//                                         )),
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Flexible(
//                                         child: InputContainer(
//                                           enabled: false,
//                                           abc: TextInputType.name,
//                                           controller: skusystemcontroller,
//                                           isPasswordTextField: false,
//                                           labelText: "SKU by System",
//                                           compulsory: "*",
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       Flexible(
//                                         child: InputContainer(
//                                           abc: TextInputType.name,
//                                           controller: skusellercontroller,
//                                           isPasswordTextField: false,
//                                           labelText: "SKU by Seller",
//                                           compulsory: "*",
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 8.0),
//                                     child: Row(
//                                       children: const [
//                                         Text(
//                                           "Category",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                           "*",
//                                           style: TextStyle(
//                                               color: Colors.red, fontSize: 18),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   DropdownButtonFormField(
//                                     onTap: () {
//                                       FocusScopeNode currentFocus =
//                                           FocusScope.of(context);
//
//                                       if (!currentFocus.hasPrimaryFocus) {
//                                         currentFocus.unfocus();
//                                       }
//                                     },
//                                     isExpanded: true,
//                                     decoration: const InputDecoration(
//                                       border: InputBorder.none,
//                                       filled: true,
//                                       hintText: 'Select Category',
//                                     ),
//                                     icon: const Icon(
//                                         Icons.arrow_drop_down_outlined),
//                                     items: category_dropdown.map((cat) {
//                                       return DropdownMenuItem(
//                                           child: Text(
//                                             cat.title!,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                           value: cat.id);
//                                     }).toList(),
//                                     onChanged: (newVal) {
//                                       setState(() {
//                                         selected_category = newVal as String?;
//                                       });
//                                     },
//                                     value: selected_category,
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 8.0),
//                                     child: Row(
//                                       children: const [
//                                         Text(
//                                           "Brand",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                           "*",
//                                           style: TextStyle(
//                                               color: Colors.red, fontSize: 18),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   DropdownButtonFormField(
//                                     onTap: () {
//                                       FocusScopeNode currentFocus =
//                                           FocusScope.of(context);
//
//                                       if (!currentFocus.hasPrimaryFocus) {
//                                         currentFocus.unfocus();
//                                       }
//                                     },
//                                     isExpanded: true,
//                                     decoration: const InputDecoration(
//                                       border: InputBorder.none,
//                                       filled: true,
//                                       hintText: 'Select Brand',
//                                     ),
//                                     icon: const Icon(
//                                         Icons.arrow_drop_down_outlined),
//                                     items: brand_dropdown.map((br) {
//                                       return DropdownMenuItem(
//                                           child: Text(
//                                             br.title!,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                           value: br.id);
//                                     }).toList(),
//                                     onChanged: (newVal) {
//                                       setState(() {
//                                         selected_brand = newVal as String?;
//                                       });
//                                     },
//                                     value: selected_brand,
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(left: 8.0),
//                                     child: Row(
//                                       children: const [
//                                         Text(
//                                           "Product Type",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                           "*",
//                                           style: TextStyle(
//                                               color: Colors.red, fontSize: 16),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   DropdownButtonFormField(
//                                     onTap: () {
//                                       FocusScopeNode currentFocus =
//                                           FocusScope.of(context);
//
//                                       if (!currentFocus.hasPrimaryFocus) {
//                                         currentFocus.unfocus();
//                                       }
//                                     },
//                                     isExpanded: true,
//                                     decoration: const InputDecoration(
//                                       border: InputBorder.none,
//                                       filled: true,
//                                       hintText: 'select product type',
//                                     ),
//                                     icon: const Icon(
//                                         Icons.arrow_drop_down_outlined),
//                                     items: producttype_dropdown.map((pr) {
//                                       return DropdownMenuItem(
//                                           child: Text(
//                                             pr.ProductTypedropdowmName!,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                           value: pr.id);
//                                     }).toList(),
//                                     onChanged: (newVal) {
//                                       setState(() {
//                                         selected_productype = newVal as String?;
//                                         print(selected_productype);
//                                       });
//                                     },
//                                     value: selected_productype,
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: const [
//                                         Text(
//                                           "Manufacturer",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                           "*",
//                                           style: TextStyle(
//                                               color: Colors.red, fontSize: 16),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   DropdownButtonFormField(
//                                     onTap: () {
//                                       FocusScopeNode currentFocus =
//                                           FocusScope.of(context);
//
//                                       if (!currentFocus.hasPrimaryFocus) {
//                                         currentFocus.unfocus();
//                                       }
//                                     },
//                                     isExpanded: true,
//                                     decoration: const InputDecoration(
//                                       border: InputBorder.none,
//                                       filled: true,
//                                       hintText: 'Select Manufacturer',
//                                     ),
//                                     icon: const Icon(
//                                         Icons.arrow_drop_down_outlined),
//                                     items: manufacturer_dropdown.map((man) {
//                                       return DropdownMenuItem(
//                                         child: Text(
//                                           man.title!,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                         value: man.id,
//                                       );
//                                     }).toList(),
//                                     onChanged: (newVal) {
//                                       setState(() {
//                                         selected_manufacturer =
//                                             newVal as String?;
//                                       });
//                                     },
//                                     value: selected_manufacturer,
//                                   ),
//                                   const SizedBox(
//                                     height: 30,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Flexible(
//                                         child: InputContainer(
//                                           abc: TextInputType.name,
//                                           controller: tagscontroller,
//                                           isPasswordTextField: false,
//                                           labelText: "Tags",
//                                           compulsory: "",
//                                         ),
//                                         flex: 2,
//                                       ),
//                                       Flexible(
//                                         child: Align(
//                                           alignment: Alignment.topCenter,
//                                           child: TextButton(
//                                             child: const Text("Add Tags"),
//                                             onPressed: () {
//                                               setState(() {
//                                                 if (tagscontroller
//                                                     .text.isEmpty) {
//                                                   Fluttertoast.showToast(
//                                                       msg:
//                                                           'Tags cant be empty');
//                                                 } else {
//                                                   tags_list
//                                                       .add(tagscontroller.text);
//                                                   tagscontroller.clear();
//                                                 }
//                                               });
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Wrap(
//                                     direction: Axis.horizontal,
//                                     children: [
//                                       for (int i = 0; i < tags_list.length; i++)
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Chip(
//                                               backgroundColor: Colors.orange,
//                                               useDeleteButtonTooltip: true,
//                                               deleteButtonTooltipMessage:
//                                                   "click to remove",
//                                               onDeleted: () {
//                                                 setState(() {
//                                                   tags_list
//                                                       .remove(tags_list[i]);
//                                                 });
//                                               },
//                                               deleteIconColor: Colors.red,
//                                               deleteIcon: const Icon(
//                                                 Icons.close,
//                                                 color: Colors.red,
//                                               ),
//                                               label: Text(
//                                                 tags_list[i],
//                                                 style: const TextStyle(
//                                                     color: Colors.white),
//                                               )),
//                                         ),
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 15,
//                                   ),
//                                   TextField(
//                                     keyboardType: TextInputType.multiline,
//                                     controller: descriptioncontroller,
//                                     minLines:
//                                         1, //Normal textInputField will be displayed
//                                     maxLines: 15, //
//                                     decoration: InputDecoration(
//                                         labelStyle: const TextStyle(
//                                             color: Colors.black),
//                                         filled: true,
//                                         enabledBorder: const OutlineInputBorder(
//                                             borderSide:
//                                                 BorderSide(color: Colors.grey)),
//                                         focusedBorder: const OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Colors.green)),
//                                         // border:
//                                         //     OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
//                                         floatingLabelBehavior:
//                                             FloatingLabelBehavior.always,
//                                         label: Row(
//                                           children: const [
//                                             Text("Description"),
//                                             Text(
//                                               "*",
//                                               style: TextStyle(
//                                                   color: Colors.red,
//                                                   fontSize: 16),
//                                             ),
//                                           ],
//                                         )), // when user presses enter it will adapt to it
//                                   ),
//
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       TextButton(
//                                           onPressed: () {
//                                             Alert(
//                                               type: AlertType.warning,
//                                               context: context,
//                                               title: "Are you sure?",
//                                               buttons: [
//                                                 DialogButton(
//                                                   child: const Text(
//                                                     "Yes",
//                                                     style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontSize: 20),
//                                                   ),
//                                                   onPressed: () {
//                                                     Navigator.pop(context);
//                                                     Navigator.pop(context);
//                                                   },
//                                                   width: 120,
//                                                 ),
//                                                 DialogButton(
//                                                   child: const Text(
//                                                     "No",
//                                                     style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontSize: 20),
//                                                   ),
//                                                   onPressed: () =>
//                                                       Navigator.pop(context),
//                                                   width: 120,
//                                                 )
//                                               ],
//                                             ).show();
//                                           },
//                                           child: const Text('Exit')),
//                                       TextButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               if (productnamecontroller
//                                                   .text.isEmpty) {
//                                                 Alert(
//                                                   context: context,
//                                                   style: commonAlertStyle,
//                                                   type: AlertType.warning,
//                                                   title:
//                                                       "Product name can't be empty",
//                                                   buttons: [
//                                                     DialogButton(
//                                                       child: const Text(
//                                                         "ok",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20),
//                                                       ),
//                                                       onPressed: () {
//                                                         Navigator.pop(context);
//                                                       },
//                                                       color: Colors
//                                                           .greenAccent.shade700,
//                                                       radius:
//                                                           BorderRadius.circular(
//                                                               10.0),
//                                                     ),
//                                                   ],
//                                                 ).show();
//                                               } else if (skusellercontroller
//                                                   .text.isEmpty) {
//                                                 Alert(
//                                                   context: context,
//                                                   style: commonAlertStyle,
//                                                   type: AlertType.warning,
//                                                   title: "SKU can't be empty",
//                                                   buttons: [
//                                                     DialogButton(
//                                                       child: const Text(
//                                                         "ok",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20),
//                                                       ),
//                                                       onPressed: () {
//                                                         Navigator.pop(context);
//                                                       },
//                                                       color: Colors
//                                                           .greenAccent.shade700,
//                                                       radius:
//                                                           BorderRadius.circular(
//                                                               10.0),
//                                                     ),
//                                                   ],
//                                                 ).show();
//                                                 // } else if (selected_category ==
//                                                 //     null) {
//                                                 //   Alert(
//                                                 //     context: context,
//                                                 //     style: commonAlertStyle,
//                                                 //     type: AlertType.warning,
//                                                 //     title: "Select category",
//                                                 //     buttons: [
//                                                 //       DialogButton(
//                                                 //         child: const Text(
//                                                 //           "ok",
//                                                 //           style: TextStyle(
//                                                 //               color: Colors.white,
//                                                 //               fontSize: 20),
//                                                 //         ),
//                                                 //         onPressed: () {
//                                                 //           Navigator.pop(context);
//                                                 //         },
//                                                 //         color: Colors
//                                                 //             .greenAccent.shade700,
//                                                 //         radius:
//                                                 //             BorderRadius.circular(
//                                                 //                 10.0),
//                                                 //       ),
//                                                 //     ],
//                                                 //   ).show();
//                                                 // } else if (selected_brand ==
//                                                 //     null) {
//                                                 //   Alert(
//                                                 //     context: context,
//                                                 //     style: commonAlertStyle,
//                                                 //     type: AlertType.warning,
//                                                 //     title: "Select Brand",
//                                                 //     buttons: [
//                                                 //       DialogButton(
//                                                 //         child: const Text(
//                                                 //           "ok",
//                                                 //           style: TextStyle(
//                                                 //               color: Colors.white,
//                                                 //               fontSize: 20),
//                                                 //         ),
//                                                 //         onPressed: () {
//                                                 //           Navigator.pop(context);
//                                                 //         },
//                                                 //         color: Colors
//                                                 //             .greenAccent.shade700,
//                                                 //         radius:
//                                                 //             BorderRadius.circular(
//                                                 //                 10.0),
//                                                 //       ),
//                                                 //     ],
//                                                 //   ).show();
//                                                 // } else if (selected_productype ==
//                                                 //     null) {
//                                                 //   Alert(
//                                                 //     context: context,
//                                                 //     style: commonAlertStyle,
//                                                 //     type: AlertType.warning,
//                                                 //     title: "Select Product type",
//                                                 //     buttons: [
//                                                 //       DialogButton(
//                                                 //         child: const Text(
//                                                 //           "ok",
//                                                 //           style: TextStyle(
//                                                 //               color: Colors.white,
//                                                 //               fontSize: 20),
//                                                 //         ),
//                                                 //         onPressed: () {
//                                                 //           Navigator.pop(context);
//                                                 //         },
//                                                 //         color: Colors
//                                                 //             .greenAccent.shade700,
//                                                 //         radius:
//                                                 //             BorderRadius.circular(
//                                                 //                 10.0),
//                                                 //       ),
//                                                 //     ],
//                                                 //   ).show();
//                                                 // } else if (selected_manufacturer ==
//                                                 //     null) {
//                                                 //   Alert(
//                                                 //     context: context,
//                                                 //     style: commonAlertStyle,
//                                                 //     type: AlertType.warning,
//                                                 //     title: "Select Manufacturer",
//                                                 //     buttons: [
//                                                 //       DialogButton(
//                                                 //         child: const Text(
//                                                 //           "ok",
//                                                 //           style: TextStyle(
//                                                 //               color: Colors.white,
//                                                 //               fontSize: 20),
//                                                 //         ),
//                                                 //         onPressed: () {
//                                                 //           Navigator.pop(context);
//                                                 //         },
//                                                 //         color: Colors
//                                                 //             .greenAccent.shade700,
//                                                 //         radius:
//                                                 //             BorderRadius.circular(
//                                                 //                 10.0),
//                                                 //       ),
//                                                 //     ],
//                                                 //   ).show();
//                                                 // } else if (tags_list.isEmpty) {
//                                                 //   Alert(
//                                                 //     context: context,
//                                                 //     style: commonAlertStyle,
//                                                 //     type: AlertType.warning,
//                                                 //     title:
//                                                 //         "Add atleast one tags for your product",
//                                                 //     buttons: [
//                                                 //       DialogButton(
//                                                 //         child: const Text(
//                                                 //           "ok",
//                                                 //           style: TextStyle(
//                                                 //               color: Colors.white,
//                                                 //               fontSize: 20),
//                                                 //         ),
//                                                 //         onPressed: () {
//                                                 //           Navigator.pop(context);
//                                                 //         },
//                                                 //         color: Colors
//                                                 //             .greenAccent.shade700,
//                                                 //         radius:
//                                                 //             BorderRadius.circular(
//                                                 //                 10.0),
//                                                 //       ),
//                                                 //     ],
//                                                 //   ).show();
//                                               } else if (descriptioncontroller
//                                                   .text.isEmpty) {
//                                                 Alert(
//                                                   context: context,
//                                                   style: commonAlertStyle,
//                                                   type: AlertType.warning,
//                                                   title:
//                                                       "Description can't be empty",
//                                                   buttons: [
//                                                     DialogButton(
//                                                       child: const Text(
//                                                         "ok",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20),
//                                                       ),
//                                                       onPressed: () {
//                                                         Navigator.pop(context);
//                                                       },
//                                                       color: Colors
//                                                           .greenAccent.shade700,
//                                                       radius:
//                                                           BorderRadius.circular(
//                                                               10.0),
//                                                     ),
//                                                   ],
//                                                 ).show();
//                                               } else {
//                                                 // _formKey.currentState!.save();
//                                                 generalvisible = false;
//                                                 attributesvisible = true;
//                                                 val = val + 0.2;
//                                               }
//                                             });
//                                           },
//                                           child: const Text('continue')),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Visibility(
//                           visible: attributesvisible,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       const Text(
//                                         "Attributes",
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       IconButton(
//                                           onPressed: () {
//                                             Fluttertoast.showToast(
//                                                 gravity: ToastGravity.TOP,
//                                                 msg:
//                                                     'Attributes like height,weight,length of product');
//                                           },
//                                           icon: const Icon(
//                                             Icons.help_outline_outlined,
//                                             color: Colors.grey,
//                                             size: 20,
//                                           ))
//                                     ],
//                                   ),
//                                   const Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 1.0),
//                                     child: Text(
//                                       "Package",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   Row(
//                                     children: const [
//                                       Text(
//                                         "Weight",
//                                         style: TextStyle(fontSize: 16),
//                                       ),
//                                       Text(
//                                         "*",
//                                         style: TextStyle(
//                                             color: Colors.red, fontSize: 18),
//                                       ),
//                                     ],
//                                   ),
//                                   TextFormField(
//                                     enableInteractiveSelection: false,
//                                     keyboardType: TextInputType.number,
//                                     inputFormatters: [
//                                       FilteringTextInputFormatter.digitsOnly
//                                     ],
//                                     controller: weightcontroller,
//                                   ),
//                                   // InputContainer(
//                                   //   abc: TextInputType.number,
//                                   //   controller: weightcontroller,
//                                   //   isPasswordTextField: false,
//                                   //   labelText: "Weight (KG)",
//                                   //   compulsory: "*",
//                                   // ),
//                                   const Padding(
//                                     padding: EdgeInsets.only(
//                                         top: 10, left: 1.0, bottom: 20),
//                                     child: Text(
//                                       "Dimension(inch)",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16),
//                                     ),
//                                   ),
//                                   // const SizedBox(
//                                   //   height: 20,
//                                   // ),
//                                   Row(
//                                     children: [
//                                       Flexible(
//                                         child: Column(
//                                           children: [
//                                             Row(
//                                               children: const [
//                                                 Text('Height'),
//                                                 Text(
//                                                   '*',
//                                                   style: TextStyle(
//                                                       color: Colors.red,
//                                                       fontSize: 16),
//                                                 ),
//                                               ],
//                                             ),
//                                             TextFormField(
//                                               enableInteractiveSelection: false,
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               inputFormatters: [
//                                                 FilteringTextInputFormatter
//                                                     .digitsOnly
//                                               ],
//                                               controller: heightcontroller,
//                                             ),
//                                             // NumberInputWithIncrementDecrement(
//                                             //   numberFieldDecoration:
//                                             //       const InputDecoration(
//                                             //     border: InputBorder.none,
//                                             //   ),
//                                             //   controller: heightcontroller,
//                                             // ),
//                                           ],
//                                         ),
//                                         // child: InputContainer(
//                                         //   abc: TextInputType.number,
//                                         //   controller: heightcontroller,
//                                         //   isPasswordTextField: false,
//                                         //   labelText: "Height",
//                                         //   compulsory: "*",
//                                         // ),
//                                       ),
//                                       const SizedBox(
//                                         width: 15,
//                                       ),
//                                       Flexible(
//                                         child: Column(
//                                           children: [
//                                             Row(
//                                               children: const [
//                                                 Text('Width'),
//                                                 Text(
//                                                   '*',
//                                                   style: TextStyle(
//                                                       color: Colors.red,
//                                                       fontSize: 16),
//                                                 ),
//                                               ],
//                                             ),
//                                             TextFormField(
//                                               enableInteractiveSelection: false,
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               inputFormatters: [
//                                                 FilteringTextInputFormatter
//                                                     .digitsOnly
//                                               ],
//                                               controller: widthcontroller,
//                                             ),
//                                             // NumberInputWithIncrementDecrement(
//                                             //   numberFieldDecoration:
//                                             //       const InputDecoration(
//                                             //     border: InputBorder.none,
//                                             //   ),
//                                             //   controller: widthcontroller,
//                                             //   min: 0,
//                                             //   max: 200,
//                                             // ),
//                                           ],
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         width: 15,
//                                       ),
//                                       Flexible(
//                                         child: Column(
//                                           children: [
//                                             Row(
//                                               children: const [
//                                                 Text('Length'),
//                                                 Text(
//                                                   '*',
//                                                   style: TextStyle(
//                                                       color: Colors.red,
//                                                       fontSize: 16),
//                                                 ),
//                                               ],
//                                             ),
//                                             TextFormField(
//                                               enableInteractiveSelection: false,
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               inputFormatters: [
//                                                 FilteringTextInputFormatter
//                                                     .digitsOnly
//                                               ],
//                                               controller: lengthcontroller,
//                                             ),
//                                             // NumberInputWithIncrementDecrement(
//                                             //   numberFieldDecoration:
//                                             //       const InputDecoration(
//                                             //     border: InputBorder.none,
//                                             //   ),
//                                             //   controller: lengthcontroller,
//                                             //   initialValue: 1,
//                                             //   min: 0,
//                                             //   max: 200,
//                                             // ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const Padding(
//                                     padding:
//                                         EdgeInsets.only(top: 20, left: 8.0),
//                                     child: Text(
//                                       "Custom For Product",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Flexible(
//                                         child: InputContainer(
//                                           abc: TextInputType.number,
//                                           controller: customtitle,
//                                           isPasswordTextField: false,
//                                           labelText: "Title (Eg. RAM)",
//                                           compulsory: "",
//                                         ),
//                                         flex: 2,
//                                       ),
//                                       const SizedBox(
//                                         width: 15,
//                                       ),
//                                       Flexible(
//                                         child: InputContainer(
//                                           abc: TextInputType.number,
//                                           controller: customvalue,
//                                           isPasswordTextField: false,
//                                           labelText: "Value(Eg. 2gb)",
//                                           compulsory: "",
//                                         ),
//                                         flex: 2,
//                                       ),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       Flexible(
//                                         child: TextButton(
//                                             onPressed: () {
//                                               setState(() {
//                                                 if (customtitle.text.isEmpty ||
//                                                     customvalue.text.isEmpty) {
//                                                   Fluttertoast.showToast(
//                                                       msg:
//                                                           "Field can't be empty");
//                                                 } else {
//                                                   custom_attribute.add(
//                                                       CustomAttribute(
//                                                     value: customvalue.text,
//                                                     key: customtitle.text,
//                                                   )
//                                                       //     {
//                                                       //   "key": customtitle.text,
//                                                       //   "value": customvalue.text,
//                                                       // }
//                                                       );
//                                                   customtitle.clear();
//                                                   customvalue.clear();
//                                                 }
//                                               });
//                                             },
//                                             child: const Text("Add")),
//                                       ),
//                                     ],
//                                   ),
//                                   // Align(
//                                   //   alignment: Alignment.center,
//                                   //   child: DataTable(
//                                   //     columns: const <DataColumn>[
//                                   //       DataColumn(
//                                   //         label: Text(
//                                   //           'Key',
//                                   //         ),
//                                   //       ),
//                                   //       DataColumn(
//                                   //         label: Text(
//                                   //           'Value',
//                                   //         ),
//                                   //       ),
//                                   //       DataColumn(
//                                   //         label: Text(
//                                   //           ' ',
//                                   //         ),
//                                   //       ),
//                                   //     ],
//                                   //     rows: custom_attribute.map((e) => DataRow(
//                                   //
//                                   //         cells: [
//                                   //           DataCell(Text(e['key'])),
//                                   //           DataCell(Text(e['value'])),
//                                   //           DataCell(IconButton(onPressed: (){
//                                   //
//                                   //           },icon: const Icon(Icons.delete_rounded),)),
//                                   //         ]
//                                   //     )).toList(),
//                                   //   ),
//                                   // ),
//                                   for (int n = 0;
//                                       n < custom_attribute.length;
//                                       n++)
//                                     Row(
//                                       children: [
//                                         Text(
//                                           custom_attribute[n].key ?? "",
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         Text(
//                                           custom_attribute[n].value ?? "",
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         const Divider(
//                                           color: Colors.grey,
//                                           height: 2,
//                                           thickness: 2,
//                                         ),
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         IconButton(
//                                             onPressed: () {
//                                               setState(() {
//                                                 custom_attribute.remove(
//                                                     custom_attribute[n]);
//                                               });
//                                             },
//                                             icon: const Icon(Icons.clear))
//                                       ],
//                                     ),
//
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       TextButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               generalvisible = true;
//                                               attributesvisible = false;
//                                               val = val - 0.2;
//                                             });
//                                           },
//                                           child: const Text('back')),
//                                       TextButton(
//                                           onPressed: () {
//                                             // for (int l = 0;
//                                             //     l <
//                                             //         data
//                                             //             .productdetailData[
//                                             //                 'variant']
//                                             //             .length;
//                                             //     l++) {
//                                             //   setState(() {
//                                             //     varient_test.add(Variant(
//                                             //         price: data.productdetailData['variant'][l]['price']
//                                             //             .toString(),
//                                             //         salesPrice: data
//                                             //             .productdetailData['variant']
//                                             //                 [l]['sales_price']
//                                             //             .toString(),
//                                             //         isAvailable: data.productdetailData['variant']
//                                             //             [l]['is_available'],
//                                             //         skuOfSeller: data.productdetailData['variant']
//                                             //             [l]['sku_of_seller'],
//                                             //         variantType: data.productdetailData['variant']
//                                             //             [l]['variant_type'],
//                                             //         stockStatus: data
//                                             //             .productdetailData['variant']
//                                             //                 [l]['stock_status']
//                                             //             .toString(),
//                                             //         inventory: data.productdetailData['variant'][l]['inventory'].toString(),
//                                             //         minOrder: data.productdetailData['variant'][l]['min_order'],
//                                             //         // isAvailable:  data.productdetailData['variant'][l]['is_available'],
//                                             //         maxOrder: data.productdetailData['variant'][l]['max_order'],
//                                             //         minStockWarning: data.productdetailData['variant'][l]['min_stock_warning'].toString()));
//                                             //
//                                             //     minimumordercontroller.text =
//                                             //         varient_test[l]
//                                             //             .minOrder
//                                             //             .toString();
//                                             //     maximumordercontroller.text =
//                                             //         varient_test[l]
//                                             //             .maxOrder
//                                             //             .toString();
//                                             //     inventorycountcontroller.text =
//                                             //         varient_test[l]
//                                             //             .inventory
//                                             //             .toString();
//                                             //     minimumstockwarningtrackabletruecontroller
//                                             //             .text =
//                                             //         varient_test[l]
//                                             //             .minStockWarning
//                                             //             .toString();
//                                             //     selected_stockstatus =
//                                             //         varient_test[l].stockStatus;
//                                             //     check_availability =
//                                             //         varient_test[l]
//                                             //             .isAvailable!;
//                                             //
//                                             //     // print(minimumstockwarningtrackabletruecontroller.text);
//                                             //     print(jsonEncode(varient_test));
//                                             //   });
//                                             // }
//                                             setState(() {
//                                               if (weightcontroller
//                                                   .text.isEmpty) {
//                                                 Alert(
//                                                   context: context,
//                                                   style: commonAlertStyle,
//                                                   type: AlertType.warning,
//                                                   title:
//                                                       "Weight can't be empty",
//                                                   buttons: [
//                                                     DialogButton(
//                                                       child: const Text(
//                                                         "ok",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20),
//                                                       ),
//                                                       onPressed: () {
//                                                         Navigator.pop(context);
//                                                       },
//                                                       color: Colors
//                                                           .greenAccent.shade700,
//                                                       radius:
//                                                           BorderRadius.circular(
//                                                               10.0),
//                                                     ),
//                                                   ],
//                                                 ).show();
//                                               } else if (heightcontroller
//                                                   .text.isEmpty) {
//                                                 Alert(
//                                                   context: context,
//                                                   style: commonAlertStyle,
//                                                   type: AlertType.warning,
//                                                   title:
//                                                       "Height can't be empty",
//                                                   buttons: [
//                                                     DialogButton(
//                                                       child: const Text(
//                                                         "ok",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20),
//                                                       ),
//                                                       onPressed: () {
//                                                         Navigator.pop(context);
//                                                       },
//                                                       color: Colors
//                                                           .greenAccent.shade700,
//                                                       radius:
//                                                           BorderRadius.circular(
//                                                               10.0),
//                                                     ),
//                                                   ],
//                                                 ).show();
//                                               } else if (widthcontroller
//                                                   .text.isEmpty) {
//                                                 Alert(
//                                                   context: context,
//                                                   style: commonAlertStyle,
//                                                   type: AlertType.warning,
//                                                   title: "Width can't be empty",
//                                                   buttons: [
//                                                     DialogButton(
//                                                       child: const Text(
//                                                         "ok",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20),
//                                                       ),
//                                                       onPressed: () {
//                                                         Navigator.pop(context);
//                                                       },
//                                                       color: Colors
//                                                           .greenAccent.shade700,
//                                                       radius:
//                                                           BorderRadius.circular(
//                                                               10.0),
//                                                     ),
//                                                   ],
//                                                 ).show();
//                                               } else if (lengthcontroller
//                                                   .text.isEmpty) {
//                                                 Alert(
//                                                   context: context,
//                                                   style: commonAlertStyle,
//                                                   type: AlertType.warning,
//                                                   title:
//                                                       "length can't be empty",
//                                                   buttons: [
//                                                     DialogButton(
//                                                       child: const Text(
//                                                         "ok",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20),
//                                                       ),
//                                                       onPressed: () {
//                                                         Navigator.pop(context);
//                                                       },
//                                                       color: Colors
//                                                           .greenAccent.shade700,
//                                                       radius:
//                                                           BorderRadius.circular(
//                                                               10.0),
//                                                     ),
//                                                   ],
//                                                 ).show();
//                                               } else {
//                                                 for (int p = 0;
//                                                     p <
//                                                         data
//                                                             .productdetailData[
//                                                                 'inventory_type']
//                                                             .length;
//                                                     p++) {
//                                                   setState(() {
//                                                     inventory_type.add(
//                                                         InventoryTypeElement(
//                                                       option:
//                                                           data.productdetailData[
//                                                                   'inventory_type']
//                                                               [p]['option'],
//                                                       inventoryType: data
//                                                                   .productdetailData[
//                                                               'inventory_type']
//                                                           [p]['inventory_type'],
//                                                     ));
//                                                   });
//                                                   print("check::: " +
//                                                       jsonEncode(
//                                                           inventory_type));
//
//                                                   if (inventory_type.length ==
//                                                       1) {
//                                                     setState(() {
//                                                       type1controller
//                                                           .text = inventory_type[
//                                                                   0]
//                                                               .inventoryType ??
//                                                           "";
//
//                                                       for (int op = 0;
//                                                           op <
//                                                               inventory_type[0]
//                                                                   .option!
//                                                                   .length;
//                                                           op++) {
//                                                         setState(() {
//                                                           option1.add(
//                                                               inventory_type[0]
//                                                                   .option?[op]);
//                                                         });
//                                                       }
//                                                     });
//                                                   } else if (inventory_type
//                                                           .length ==
//                                                       2) {
//                                                     setState(() {
//                                                       type1controller
//                                                           .text = inventory_type[
//                                                                   0]
//                                                               .inventoryType ??
//                                                           "";
//                                                       type2controller
//                                                           .text = inventory_type[
//                                                                   1]
//                                                               .inventoryType ??
//                                                           "";
//                                                     });
//                                                   }
//
//                                                   // print(inventory_type[1].inventoryType!.toString());
//
//                                                   // option2.add(inventory_type[2].option);
//                                                 }
//
//                                                 // setState(() {
//                                                 //   type1controller.text =
//                                                 //       inventory_type[0]
//                                                 //               .inventoryType ??
//                                                 //           "";
//                                                 //   type2controller.text =
//                                                 //       inventory_type[1]
//                                                 //               .inventoryType ??
//                                                 //           "";
//                                                 // });
//
//                                                 // for (int q = 0;
//                                                 //     q <
//                                                 //         inventory_type[0]
//                                                 //             .option!
//                                                 //             .length;
//                                                 //     q++) {
//                                                 //   option1.add(inventory_type[0]
//                                                 //       .option![q]);
//                                                 // }
//                                                 //
//                                                 // for (int r = 0;
//                                                 //     r <
//                                                 //         inventory_type[1]
//                                                 //             .option!
//                                                 //             .length;
//                                                 //     r++) {
//                                                 //   option2.add(inventory_type[1]
//                                                 //       .option![r]);
//                                                 // }
//
//                                                 val = val + 0.2;
//                                                 attributesvisible = false;
//                                                 inventoryvisible = true;
//                                               }
//                                             });
//                                           },
//                                           child: const Text('continue')),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Visibility(
//                           visible: inventoryvisible,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       const Text(
//                                         "Inventory",
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       IconButton(
//                                           onPressed: () {
//                                             Fluttertoast.showToast(
//                                                 gravity: ToastGravity.TOP,
//                                                 msg:
//                                                     'Inventory information like stock status, min order, max order');
//                                           },
//                                           icon: const Icon(
//                                             Icons.help_outline_outlined,
//                                             color: Colors.grey,
//                                             size: 20,
//                                           ))
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Switch(
//                                         value: istrackable,
//                                         onChanged: (value) {
//                                           Alert(
//                                                   type: AlertType.warning,
//                                                   context: context,
//                                                   title: "Warning",
//                                                   buttons: [
//                                                     DialogButton(
//                                                       child: const Text(
//                                                         "Yes",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20),
//                                                       ),
//                                                       onPressed: () {
//                                                         setState(() {
//                                                           istrackable = value;
//                                                           trackable =
//                                                               !trackable;
//                                                           print(istrackable);
//                                                         });
//                                                         Navigator.pop(context);
//                                                       },
//                                                       width: 120,
//                                                     ),
//                                                     DialogButton(
//                                                       child: const Text(
//                                                         "No",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20),
//                                                       ),
//                                                       onPressed: () =>
//                                                           Navigator.pop(
//                                                               context),
//                                                       width: 120,
//                                                     )
//                                                   ],
//                                                   desc:
//                                                       "Changing inventory type will clear variants are you sure ?")
//                                               .show();
//                                           //
//                                         },
//                                         activeTrackColor: Colors.yellow,
//                                         activeColor: Colors.orangeAccent,
//                                       ),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       const Text("Is Trackable Inventory"),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Switch(
//                                         value: ismultiplevariation,
//                                         onChanged: (value) {
//                                           Alert(
//                                                   type: AlertType.warning,
//                                                   context: context,
//                                                   title: "Warning",
//                                                   buttons: [
//                                                     DialogButton(
//                                                       child: const Text(
//                                                         "Yes",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20),
//                                                       ),
//                                                       onPressed: () {
//                                                         setState(() {
//                                                           ismultiplevariation =
//                                                               value;
//                                                           multivariationvisibility =
//                                                               !multivariationvisibility;
//                                                         });
//
//                                                         Navigator.pop(context);
//                                                       },
//                                                       width: 120,
//                                                     ),
//                                                     DialogButton(
//                                                       child: const Text(
//                                                         "No",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20),
//                                                       ),
//                                                       onPressed: () =>
//                                                           Navigator.pop(
//                                                               context),
//                                                       width: 120,
//                                                     )
//                                                   ],
//                                                   desc:
//                                                       "Changing inventory type will clear variants are you sure ?")
//                                               .show();
//                                         },
//                                         activeTrackColor: Colors.yellow,
//                                         activeColor: Colors.orangeAccent,
//                                       ),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       const Text("Is Multiple Variation"),
//                                     ],
//                                   ),
//                                   Visibility(
//                                     visible: ismultiplevariation == true
//                                         ? false
//                                         : true,
//                                     child: Column(
//                                       children: [
//                                         InputContainer(
//                                           abc: TextInputType.name,
//                                           controller: skusellercontroller,
//                                           isPasswordTextField: false,
//                                           labelText: "SKU",
//                                           enabled: false,
//                                           compulsory: "",
//                                         ),
//                                         Row(
//                                           children: [
//                                             Flexible(
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   const Text('Minimum order'),
//                                                   TextFormField(
//                                                     enableInteractiveSelection:
//                                                         false,
//                                                     keyboardType:
//                                                         TextInputType.number,
//                                                     inputFormatters: [
//                                                       FilteringTextInputFormatter
//                                                           .digitsOnly
//                                                     ],
//                                                     controller:
//                                                         minimumordercontroller,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               width: 15,
//                                             ),
//                                             Flexible(
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text("Maximum order"),
//                                                   TextFormField(
//                                                     enableInteractiveSelection:
//                                                         false,
//                                                     keyboardType:
//                                                         TextInputType.number,
//                                                     inputFormatters: [
//                                                       FilteringTextInputFormatter
//                                                           .digitsOnly
//                                                     ],
//                                                     controller:
//                                                         maximumordercontroller,
//                                                   ),
//                                                   // NumberInputWithIncrementDecrement(
//                                                   //   numberFieldDecoration:
//                                                   //       const InputDecoration(
//                                                   //     border: InputBorder.none,
//                                                   //   ),
//                                                   //   controller:
//                                                   //       maximumordercontroller,
//                                                   // ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 20,
//                                         ),
//                                         Visibility(
//                                           visible:
//                                               trackable == true ? false : true,
//                                           child: Row(
//                                             children: [
//                                               Flexible(
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     const Text('Inventory'),
//                                                     TextFormField(
//                                                       enableInteractiveSelection:
//                                                           false,
//                                                       keyboardType:
//                                                           TextInputType.number,
//                                                       inputFormatters: [
//                                                         FilteringTextInputFormatter
//                                                             .digitsOnly
//                                                       ],
//                                                       controller:
//                                                           inventorycountcontroller,
//                                                     ),
//                                                     // NumberInputWithIncrementDecrement(
//                                                     //   numberFieldDecoration:
//                                                     //       const InputDecoration(
//                                                     //     border:
//                                                     //         InputBorder.none,
//                                                     //   ),
//                                                     //   controller:
//                                                     //       inventorycountcontroller,
//                                                     // ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 width: 5,
//                                               ),
//                                               Flexible(
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     const Text(
//                                                         'Minimum Stock Warning'),
//                                                     TextFormField(
//                                                       enableInteractiveSelection:
//                                                           false,
//                                                       keyboardType:
//                                                           TextInputType.number,
//                                                       inputFormatters: [
//                                                         FilteringTextInputFormatter
//                                                             .digitsOnly
//                                                       ],
//                                                       controller:
//                                                           minimumstockwarningtrackabletruecontroller,
//                                                     ),
//                                                     // NumberInputWithIncrementDecrement(
//                                                     //   // numberFieldDecoration:
//                                                     //   //     const InputDecoration(
//                                                     //   //   border:
//                                                     //   //       InputBorder.none,
//                                                     //   // ),
//                                                     //   controller:
//                                                     //       minimumstockwarningtrackabletruecontroller,
//                                                     // ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 width: 15,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 15,
//                                         ),
//                                         Visibility(
//                                           visible: !trackable,
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 8.0),
//                                                 child: Row(
//                                                   children: const [
//                                                     SizedBox(
//                                                       height: 15,
//                                                     ),
//                                                     Text(
//                                                       "Stock Status",
//                                                       style: TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                     Text(
//                                                       " *",
//                                                       style: TextStyle(
//                                                           color: Colors.red),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 height: 10,
//                                               ),
//                                               DropdownButtonFormField(
//
//                                                 onTap: () {
//                                                   FocusScopeNode currentFocus =
//                                                       FocusScope.of(context);
//
//                                                   if (!currentFocus
//                                                       .hasPrimaryFocus) {
//                                                     currentFocus.unfocus();
//                                                   }
//                                                 },
//                                                 hint: const Text(
//                                                     'Select stock status'),
//                                                 value: selected_stockstatus,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   border: InputBorder.none,
//                                                   filled: true,
//                                                 ),
//                                                 icon: const Icon(Icons
//                                                     .arrow_drop_down_outlined),
//                                                 items: stockstatus_dropdown
//                                                     .map((ss) {
//                                                   return DropdownMenuItem(
//                                                     value: ss.id,
//                                                     child: Text(
//                                                         ss.stockStatusName!),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (newVal) {
//                                                   selected_stockstatus =
//                                                       newVal as String?;
//                                                 },
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 10,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Checkbox(
//                                               value: this.check_availability,
//                                               onChanged: (bool? value) {
//                                                 setState(() {
//                                                   this.check_availability =
//                                                       value!;
//                                                 });
//                                               },
//                                             ),
//                                             const SizedBox(
//                                               width: 5,
//                                             ),
//                                             const Text(
//                                               "AVAILABLE",
//                                               style: TextStyle(
//                                                   fontWeight:
//                                                       FontWeight.normal),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Visibility(
//                                     visible: ismultiplevariation == true
//                                         ? true
//                                         : false,
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const SizedBox(
//                                           height: 15,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Flexible(
//                                               flex: 2,
//                                               child: TextFormField(
//                                                 enabled: false,
//                                                 controller: type1controller,
//                                                 decoration: InputDecoration(
//                                                     labelStyle: const TextStyle(
//                                                         color: Colors.black),
//                                                     filled: true,
//                                                     enabledBorder:
//                                                         const OutlineInputBorder(
//                                                             borderSide:
//                                                                 BorderSide(
//                                                                     color: Colors
//                                                                         .grey)),
//                                                     focusedBorder:
//                                                         const OutlineInputBorder(
//                                                             borderSide:
//                                                                 BorderSide(
//                                                                     color: Colors
//                                                                         .green)),
//                                                     // border:
//                                                     //     OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
//                                                     floatingLabelBehavior:
//                                                         FloatingLabelBehavior
//                                                             .always,
//                                                     label: Row(
//                                                       children: const [
//                                                         Text("Type"),
//                                                         Text(
//                                                           "*",
//                                                           style: TextStyle(
//                                                               color: Colors.red,
//                                                               fontSize: 25),
//                                                         ),
//                                                       ],
//                                                     )),
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//                                             Flexible(
//                                               flex: 2,
//                                               child: InputContainer(
//                                                 abc: TextInputType.name,
//                                                 controller: option1controller,
//                                                 isPasswordTextField: false,
//                                                 labelText: "Options",
//                                                 compulsory: "",
//                                               ),
//                                             ),
//                                             Flexible(
//                                                 child: TextButton(
//                                                     onPressed: () {
//                                                       setState(() {
//                                                         if (option1controller
//                                                             .text.isEmpty) {
//                                                           Fluttertoast.showToast(
//                                                               msg:
//                                                                   'options cant be empty');
//                                                         } else {
//                                                           option1.add(
//                                                               option1controller
//                                                                   .text);
//                                                           option1controller
//                                                               .clear();
//                                                         }
//                                                       });
//                                                     },
//                                                     child: const Text('Add'))),
//                                           ],
//                                         ),
//
//                                         Wrap(
//                                           direction: Axis.horizontal,
//                                           children: [
//                                             for (int i = 0;
//                                                 i < option1.length;
//                                                 i++)
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Chip(
//                                                     backgroundColor:
//                                                         Colors.orange,
//                                                     useDeleteButtonTooltip:
//                                                         true,
//                                                     deleteButtonTooltipMessage:
//                                                         "click to remove",
//                                                     onDeleted: () {
//                                                       setState(() {
//                                                         option1
//                                                             .remove(option1[i]);
//                                                       });
//                                                     },
//                                                     deleteIconColor: Colors.red,
//                                                     deleteIcon: const Icon(
//                                                       Icons.close,
//                                                       color: Colors.red,
//                                                     ),
//                                                     label: Text(
//                                                       option1[i],
//                                                       style: const TextStyle(
//                                                           color: Colors.white),
//                                                     )),
//                                               ),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 10,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Flexible(
//                                                 flex: 2,
//                                                 child: TextFormField(
//                                                   enabled: false,
//                                                   controller: type2controller,
//                                                   decoration: InputDecoration(
//                                                       labelStyle:
//                                                           const TextStyle(
//                                                               color:
//                                                                   Colors.black),
//                                                       filled: true,
//                                                       enabledBorder:
//                                                           const OutlineInputBorder(
//                                                               borderSide: BorderSide(
//                                                                   color: Colors
//                                                                       .grey)),
//                                                       focusedBorder:
//                                                           const OutlineInputBorder(
//                                                               borderSide: BorderSide(
//                                                                   color: Colors
//                                                                       .green)),
//                                                       // border:
//                                                       //     OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
//                                                       floatingLabelBehavior:
//                                                           FloatingLabelBehavior
//                                                               .always,
//                                                       label: Row(
//                                                         children: const [
//                                                           Text("Type"),
//                                                           Text(
//                                                             "*",
//                                                             style: TextStyle(
//                                                                 color:
//                                                                     Colors.red,
//                                                                 fontSize: 25),
//                                                           ),
//                                                         ],
//                                                       )),
//                                                 )),
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//                                             Flexible(
//                                               flex: 2,
//                                               child: InputContainer(
//                                                 abc: TextInputType.name,
//                                                 controller: option2controller,
//                                                 isPasswordTextField: false,
//                                                 labelText: "Options",
//                                                 compulsory: "",
//                                               ),
//                                             ),
//                                             Flexible(
//                                                 child: TextButton(
//                                                     onPressed: () {
//                                                       setState(() {
//                                                         if (option2controller
//                                                             .text.isEmpty) {
//                                                           Fluttertoast.showToast(
//                                                               msg:
//                                                                   'options cant be empty');
//                                                         } else {
//                                                           option2.add(
//                                                               option2controller
//                                                                   .text);
//                                                           option2controller
//                                                               .clear();
//                                                         }
//                                                       });
//                                                     },
//                                                     child: Text('Add'))),
//                                           ],
//                                         ),
//                                         Wrap(
//                                           direction: Axis.horizontal,
//                                           children: [
//                                             for (int i = 0;
//                                                 i < option2.length;
//                                                 i++)
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Chip(
//                                                     backgroundColor:
//                                                         Colors.orange,
//                                                     useDeleteButtonTooltip:
//                                                         true,
//                                                     deleteButtonTooltipMessage:
//                                                         "click to remove",
//                                                     onDeleted: () {
//                                                       setState(() {
//                                                         option2
//                                                             .remove(option2[i]);
//                                                       });
//                                                     },
//                                                     deleteIconColor: Colors.red,
//                                                     deleteIcon: const Icon(
//                                                       Icons.close,
//                                                       color: Colors.red,
//                                                     ),
//                                                     label: Text(
//                                                       option2[i],
//                                                       style: const TextStyle(
//                                                           color: Colors.white),
//                                                     )),
//                                               ),
//                                           ],
//                                         ),
//                                         // comb([
//                                         //     option1,
//                                         //     option2
//                                         //
//                                         //   ]).map((e) => e.toList()));
//                                         // for(int v = 0 ; v < varient_list.length; v++)
//                                         //   Column(
//                                         //     children: [
//                                         //       Text(varient_list.),
//                                         //     ],
//                                         //   )
//                                       ],
//                                     ),
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       TextButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               print('clearing data');
//                                               varient_test.clear();
//                                               type1controller.clear();
//                                               type2controller.clear();
//                                               inventory_type.clear();
//                                               option1.clear();
//                                               option2.clear();
//                                               attributesvisible = true;
//                                               inventoryvisible = false;
//                                               val = val - 0.2;
//                                             });
//                                           },
//                                           child: const Text('back')),
//                                       TextButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               if (selected_stockstatus ==
//                                                       null &&
//                                                   trackable == false &&
//                                                   ismultiplevariation ==
//                                                       false) {
//                                                 Alert(
//                                                   context: context,
//                                                   style: commonAlertStyle,
//                                                   type: AlertType.warning,
//                                                   title: "Select stock status",
//                                                   buttons: [
//                                                     DialogButton(
//                                                       child: const Text(
//                                                         "ok",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20),
//                                                       ),
//                                                       onPressed: () {
//                                                         Navigator.pop(context);
//                                                       },
//                                                       color: Colors
//                                                           .greenAccent.shade700,
//                                                       radius:
//                                                           BorderRadius.circular(
//                                                               10.0),
//                                                     ),
//                                                   ],
//                                                 ).show();
//                                               } else {
//                                                 // option1 = option1.map((e) => e * option2).toList();
//                                                 // print(option1.map((e) => e * option2).toList());
//
//                                                 // output1.clear();
//
//                                                 output1.add(
//                                                     comb([option1, option2])
//                                                         .map((e) => e)
//                                                         .toList());
//
//                                                 for (int ii = 0; ii < 1; ii++) {
//                                                   setState(() {
//                                                     inventory_type.add(
//                                                         InventoryTypeElement(
//                                                             inventoryType:
//                                                                 type1controller
//                                                                     .text,
//                                                             option: option1));
//                                                     inventory_type.add(
//                                                         InventoryTypeElement(
//                                                             inventoryType:
//                                                                 type2controller
//                                                                     .text,
//                                                             option: option2));
//                                                   });
//                                                 }
//                                                 // inspect(inventory_type);
//
//                                                 // List _sample = ['a','b','c'];
//                                                 // _sample.asMap().forEach((index, value) => f);
//
//                                                 // var map =
//                                                 //     Map<String, int>.fromIterable(
//                                                 //         output1,
//                                                 //         key: (item) =>
//                                                 //             item.toString());
//
//                                                 // var newList = [option1, option2].expand((x) => x).toList();
//
//                                                 // var newList = [...option1, ...option2].toSet().toList();
//                                                 // print(newList);
//                                                 if (ismultiplevariation ==
//                                                         true &&
//                                                     istrackable == true) {
//                                                   setState(() {
//                                                     trackableandmultiplevariation =
//                                                         true;
//                                                   });
//                                                 } else {
//                                                   setState(() {
//                                                     trackableandmultiplevariation =
//                                                         false;
//                                                   });
//                                                 }
//
//                                                 pricesvisible = true;
//                                                 val = val + 0.2;
//                                                 inventoryvisible = false;
//                                               }
//                                             });
//                                           },
//                                           child: const Text('continue')),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Visibility(
//                           visible: pricesvisible,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               child: Column(
//                                 children: [
//                                   ismultiplevariation == false
//                                       ? Column(
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 const Text(
//                                                   "Price",
//                                                   style: TextStyle(
//                                                       fontSize: 18,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                                 IconButton(
//                                                     onPressed: () {
//                                                       Fluttertoast.showToast(
//                                                           gravity:
//                                                               ToastGravity.TOP,
//                                                           msg:
//                                                               'Actual price and sales price of product');
//                                                     },
//                                                     icon: const Icon(
//                                                       Icons
//                                                           .help_outline_outlined,
//                                                       color: Colors.grey,
//                                                       size: 20,
//                                                     ))
//                                               ],
//                                             ),
//                                             InputContainer(
//                                               abc: TextInputType.name,
//                                               controller: skusellercontroller,
//                                               isPasswordTextField: false,
//                                               labelText: "SKU",
//                                               compulsory: "",
//                                               enabled: false,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 const SizedBox(
//                                                   width: 5,
//                                                 ),
//                                                 Flexible(
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Row(
//                                                         children: const [
//                                                           Text('Price'),
//                                                           Text(' *',
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                       .red)),
//                                                         ],
//                                                       ),
//                                                       NumberInputWithIncrementDecrement(
//                                                         numberFieldDecoration:
//                                                             const InputDecoration(
//                                                           border:
//                                                               InputBorder.none,
//                                                         ),
//                                                         controller:
//                                                             pricecontroller,
//                                                         initialValue: 1,
//                                                         min: 1,
//                                                         max: 200,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 const SizedBox(
//                                                   width: 5,
//                                                 ),
//                                                 Flexible(
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                           Text('Sales price'),
//                                                           Text(' *',
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                       .red)),
//                                                         ],
//                                                       ),
//                                                       NumberInputWithIncrementDecrement(
//                                                         numberFieldDecoration:
//                                                             const InputDecoration(
//                                                           border:
//                                                               InputBorder.none,
//                                                         ),
//                                                         controller:
//                                                             salespricecontroller,
//                                                         initialValue: 1,
//                                                         min: 1,
//                                                         max: 200,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         )
//                                       : Column(
//                                           children: [
//                                             output1.isEmpty
//                                                 ? const SizedBox(
//                                                     height: 1,
//                                                   )
//                                                 : Column(
//                                                     children: [
//                                                       ListView.builder(
//                                                         shrinkWrap: true,
//                                                         physics:
//                                                             const ClampingScrollPhysics(),
//                                                         itemCount:
//                                                             output1[0].length,
//                                                         itemBuilder:
//                                                             (context, i) {
//                                                           print(
//                                                               _selectedstatusmultiple);
//                                                           _controllers.add(
//                                                               TextEditingController());
//                                                           _pricecontrollers.add(
//                                                               TextEditingController());
//                                                           _salespricecontrollers
//                                                               .add(
//                                                                   TextEditingController());
//                                                           _inventorymultivarianttrue
//                                                               .add(
//                                                                   TextEditingController());
//                                                           _skumultivarianttrue.add(
//                                                               TextEditingController());
//                                                           _minstockwarningmultiple
//                                                               .add(
//                                                                   TextEditingController());
//
//                                                           _skumultivarianttrue[
//                                                                   i]
//                                                               .text = output1[0]
//                                                                       [i][0]
//                                                                   .toString() +
//                                                               "-" +
//                                                               output1[0][i][1]
//                                                                   .toString();
//
//                                                           return Column(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .start,
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               ExpansionTile(
//                                                                 maintainState:
//                                                                     true,
//                                                                 title: Column(
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .start,
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .start,
//                                                                   children: [
//                                                                     Text(
//                                                                       "color: " +
//                                                                           output1[0][i][0]
//                                                                               .toString(),
//                                                                     ),
//                                                                     Text(
//                                                                       "size:" +
//                                                                           output1[0][i][1]
//                                                                               .toString(),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                                 children: [
//                                                                   Padding(
//                                                                     padding: const EdgeInsets
//                                                                             .symmetric(
//                                                                         horizontal:
//                                                                             10.0),
//                                                                     child: Row(
//                                                                       children: [
//                                                                         Flexible(
//                                                                           child:
//                                                                               Column(
//                                                                             mainAxisAlignment:
//                                                                                 MainAxisAlignment.start,
//                                                                             crossAxisAlignment:
//                                                                                 CrossAxisAlignment.start,
//                                                                             children: [
//                                                                               InputContainer(
//                                                                                 enabled: false,
//                                                                                 abc: TextInputType.name,
//                                                                                 controller: TextEditingController(
//                                                                                   text: output1[0][i][0].toString(),
//                                                                                 ),
//                                                                                 isPasswordTextField: false,
//                                                                                 labelText: "color",
//                                                                                 compulsory: "*",
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         ),
//                                                                         const SizedBox(
//                                                                           width:
//                                                                               20,
//                                                                         ),
//                                                                         Flexible(
//                                                                           child:
//                                                                               Column(
//                                                                             mainAxisAlignment:
//                                                                                 MainAxisAlignment.start,
//                                                                             crossAxisAlignment:
//                                                                                 CrossAxisAlignment.start,
//                                                                             children: [
//                                                                               InputContainer(
//                                                                                 enabled: false,
//                                                                                 abc: TextInputType.name,
//                                                                                 controller: TextEditingController(
//                                                                                   text: output1[0][i][1].toString(),
//                                                                                 ),
//                                                                                 isPasswordTextField: false,
//                                                                                 labelText: "size",
//                                                                                 compulsory: "*",
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Padding(
//                                                                     padding:
//                                                                         const EdgeInsets.all(
//                                                                             8.0),
//                                                                     child:
//                                                                         InputContainer(
//                                                                       enabled:
//                                                                           false,
//                                                                       abc: TextInputType
//                                                                           .name,
//                                                                       // controller: TextEditingController(.),
//                                                                       controller:
//                                                                           _skumultivarianttrue[
//                                                                               i],
//                                                                       // TextEditingController(
//                                                                       //   text: output1[0][i][0].toString(),
//                                                                       // ),
//                                                                       isPasswordTextField:
//                                                                           false,
//                                                                       labelText:
//                                                                           "SKU",
//                                                                       compulsory:
//                                                                           "*",
//                                                                     ),
//                                                                   ),
//                                                                   Row(
//                                                                     children: [
//                                                                       Checkbox(
//                                                                         value: selecteditemse!
//                                                                             .contains(output1[0][i].toString()),
//                                                                         onChanged:
//                                                                             (bool?
//                                                                                 value) {
//                                                                           // setState(() {
//                                                                           //   this.check_availability =
//                                                                           //       value!;
//                                                                           // });
//                                                                           onSelectedRow(
//                                                                             value!,
//                                                                             output1[0][i].toString(),
//                                                                           );
//                                                                         },
//                                                                       ),
//                                                                       const SizedBox(
//                                                                         width:
//                                                                             5,
//                                                                       ),
//                                                                       const Text(
//                                                                         "AVAILABLE",
//                                                                         style: TextStyle(
//                                                                             fontWeight:
//                                                                                 FontWeight.normal),
//                                                                       ),
//                                                                       const SizedBox(
//                                                                         width:
//                                                                             20,
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                   Padding(
//                                                                     padding: const EdgeInsets
//                                                                             .symmetric(
//                                                                         horizontal:
//                                                                             10.0),
//                                                                     child: Row(
//                                                                       children: [
//                                                                         Flexible(
//                                                                           child:
//                                                                               Column(
//                                                                             mainAxisAlignment:
//                                                                                 MainAxisAlignment.start,
//                                                                             crossAxisAlignment:
//                                                                                 CrossAxisAlignment.start,
//                                                                             children: [
//                                                                               const Text('Minimum order'),
//                                                                               NumberInputWithIncrementDecrement(
//                                                                                 numberFieldDecoration: const InputDecoration(
//                                                                                   border: InputBorder.none,
//                                                                                 ),
//                                                                                 controller: minimumordercontroller,
//                                                                                 initialValue: 1,
//                                                                                 min: 0,
//                                                                                 max: 1,
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         ),
//                                                                         const SizedBox(
//                                                                           width:
//                                                                               20,
//                                                                         ),
//                                                                         Flexible(
//                                                                           child:
//                                                                               Column(
//                                                                             mainAxisAlignment:
//                                                                                 MainAxisAlignment.start,
//                                                                             crossAxisAlignment:
//                                                                                 CrossAxisAlignment.start,
//                                                                             children: [
//                                                                               const Text("Maximum order"),
//                                                                               NumberInputWithIncrementDecrement(
//                                                                                 numberFieldDecoration: const InputDecoration(
//                                                                                   border: InputBorder.none,
//                                                                                 ),
//                                                                                 controller: _controllers[i],
//                                                                                 initialValue: 1,
//                                                                                 min: 0,
//                                                                                 max: 10,
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   const SizedBox(
//                                                                     height: 20,
//                                                                   ),
//                                                                   Padding(
//                                                                     padding: const EdgeInsets
//                                                                             .symmetric(
//                                                                         horizontal:
//                                                                             10.0),
//                                                                     child: Row(
//                                                                       children: [
//                                                                         Flexible(
//                                                                           child:
//                                                                               Column(
//                                                                             mainAxisAlignment:
//                                                                                 MainAxisAlignment.start,
//                                                                             crossAxisAlignment:
//                                                                                 CrossAxisAlignment.start,
//                                                                             children: [
//                                                                               const Text('Price'),
//                                                                               NumberInputWithIncrementDecrement(
//                                                                                 numberFieldDecoration: const InputDecoration(
//                                                                                   border: InputBorder.none,
//                                                                                 ),
//                                                                                 controller: _pricecontrollers[i],
//                                                                                 initialValue: 1,
//                                                                                 min: 1,
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         ),
//                                                                         const SizedBox(
//                                                                           width:
//                                                                               20,
//                                                                         ),
//                                                                         Flexible(
//                                                                           child:
//                                                                               Column(
//                                                                             mainAxisAlignment:
//                                                                                 MainAxisAlignment.start,
//                                                                             crossAxisAlignment:
//                                                                                 CrossAxisAlignment.start,
//                                                                             children: [
//                                                                               const Text("Sales price"),
//                                                                               NumberInputWithIncrementDecrement(
//                                                                                 numberFieldDecoration: const InputDecoration(
//                                                                                   border: InputBorder.none,
//                                                                                 ),
//                                                                                 controller: _salespricecontrollers[i],
//                                                                                 initialValue: 1,
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   const SizedBox(
//                                                                     height: 10,
//                                                                   ),
//                                                                   Visibility(
//                                                                     visible:
//                                                                         trackableandmultiplevariation,
//                                                                     child:
//                                                                         Padding(
//                                                                       padding:
//                                                                           const EdgeInsets.all(
//                                                                               8.0),
//                                                                       child:
//                                                                           Column(
//                                                                         mainAxisAlignment:
//                                                                             MainAxisAlignment.start,
//                                                                         crossAxisAlignment:
//                                                                             CrossAxisAlignment.start,
//                                                                         children: [
//                                                                           Row(
//                                                                             children: [
//                                                                               Flexible(
//                                                                                 child: Column(
//                                                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                   children: [
//                                                                                     const Text('Inventory/Stock'),
//                                                                                     NumberInputWithIncrementDecrement(
//                                                                                       numberFieldDecoration: const InputDecoration(
//                                                                                         border: InputBorder.none,
//                                                                                       ),
//                                                                                       controller: _inventorymultivarianttrue[i],
//                                                                                       initialValue: 1,
//                                                                                       min: 1,
//                                                                                     ),
//                                                                                   ],
//                                                                                 ),
//                                                                               ),
//                                                                               const SizedBox(
//                                                                                 width: 15,
//                                                                               ),
//                                                                               Flexible(
//                                                                                 child: Column(
//                                                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                   children: [
//                                                                                     const Text('Min stock warning'),
//                                                                                     NumberInputWithIncrementDecrement(
//                                                                                       numberFieldDecoration: const InputDecoration(
//                                                                                         border: InputBorder.none,
//                                                                                       ),
//                                                                                       controller: _minstockwarningmultiple[i],
//                                                                                       initialValue: 1,
//                                                                                       min: 1,
//                                                                                     ),
//                                                                                   ],
//                                                                                 ),
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Padding(
//                                                                     padding: const EdgeInsets
//                                                                             .symmetric(
//                                                                         horizontal:
//                                                                             10.0),
//                                                                     child:
//                                                                         Column(
//                                                                       mainAxisAlignment:
//                                                                           MainAxisAlignment
//                                                                               .start,
//                                                                       crossAxisAlignment:
//                                                                           CrossAxisAlignment
//                                                                               .start,
//                                                                       children: [
//                                                                         const Padding(
//                                                                           padding:
//                                                                               EdgeInsets.symmetric(horizontal: 8.0),
//                                                                           child:
//                                                                               Text(
//                                                                             "Stock Status",
//                                                                             style:
//                                                                                 TextStyle(),
//                                                                           ),
//                                                                         ),
//                                                                         const SizedBox(
//                                                                           height:
//                                                                               10,
//                                                                         ),
//                                                                         DropdownButtonFormField(
//                                                                             onTap:
//                                                                                 () {
//                                                                               FocusScopeNode currentFocus = FocusScope.of(context);
//
//                                                                               if (!currentFocus.hasPrimaryFocus) {
//                                                                                 currentFocus.unfocus();
//                                                                               }
//                                                                             },
//                                                                             hint: const Text(
//                                                                                 'Select stock status'),
//                                                                             decoration:
//                                                                                 const InputDecoration(
//                                                                               border: InputBorder.none,
//                                                                               filled: true,
//                                                                             ),
//                                                                             icon: const Icon(Icons
//                                                                                 .arrow_drop_down_outlined),
//                                                                             items: stockstatus_dropdown.map(
//                                                                                 (ss) {
//                                                                               return DropdownMenuItem(
//                                                                                 value: ss.id,
//                                                                                 child: Text(ss.stockStatusName!),
//                                                                               );
//                                                                             }).toList(),
//                                                                             onChanged:
//                                                                                 (newVal) {
//                                                                               setState(() {
//                                                                                 selected_stockstatus = newVal as String;
//                                                                               });
//                                                                             },
//                                                                             value:
//                                                                                 selected_stockstatus),
//                                                                         // DropdownButtonFormField(
//                                                                         //   onTap:
//                                                                         //       () {
//                                                                         //     FocusScopeNode
//                                                                         //         currentFocus =
//                                                                         //         FocusScope.of(context);
//                                                                         //
//                                                                         //     if (!currentFocus
//                                                                         //         .hasPrimaryFocus) {
//                                                                         //       currentFocus
//                                                                         //           .unfocus();
//                                                                         //     }
//                                                                         //   },
//                                                                         //   hint: const Text(
//                                                                         //       'Select stock status'),
//                                                                         //
//                                                                         //   decoration:
//                                                                         //       const InputDecoration(
//                                                                         //     border:
//                                                                         //         InputBorder.none,
//                                                                         //     filled:
//                                                                         //         true,
//                                                                         //   ),
//                                                                         //   icon: const Icon(
//                                                                         //       Icons
//                                                                         //           .arrow_drop_down_outlined),
//                                                                         //   items: stockstatus_dropdown
//                                                                         //       .map(
//                                                                         //           (ss) {
//                                                                         //     return DropdownMenuItem(
//                                                                         //       value:
//                                                                         //           ss.id,
//                                                                         //       child:
//                                                                         //           Text(ss.stockStatusName!),
//                                                                         //     );
//                                                                         //   }).toList(),
//                                                                         //   onChanged:
//                                                                         //       (newVal) {
//                                                                         //     setState(() {
//                                                                         //       dropdownstatus.add(newVal as String);
//                                                                         //       // dropdownstatus[i] = newVal as String;
//                                                                         //     });
//                                                                         //
//                                                                         //     // selected_stockstatus =
//                                                                         //     //     newVal
//                                                                         //     //         as String?;
//                                                                         //   },
//                                                                         //   value:
//                                                                         //   selected_stockstatus,
//                                                                         // ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 15,
//                                                               ),
//                                                               const Divider(
//                                                                 color:
//                                                                     kdividercolor,
//                                                                 height: 10,
//                                                                 thickness: 10,
//                                                               ),
//                                                               // Text(output1[0][i][0]
//                                                               //     .toString()),
//                                                               // Text(output1[0][i][1]
//                                                               //     .toString()),
//                                                             ],
//                                                           );
//                                                         },
//                                                       ),
//                                                     ],
//                                                   ),
//                                           ],
//                                         ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       TextButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               pricesvisible = false;
//                                               varient_typetest.clear();
//                                               inventoryvisible = true;
//                                               val = val - 0.4;
//                                               output1.clear();
//                                             });
//                                           },
//                                           child: const Text('back')),
//                                       TextButton(
//                                           onPressed: () {
//                                             // setState(() {
//                                             // if (pricecontroller.text.isEmpty) {
//                                             //   Alert(
//                                             //     context: context,
//                                             //     style: commonAlertStyle,
//                                             //     type: AlertType.warning,
//                                             //     title: "price can't be empty",
//                                             //     buttons: [
//                                             //       DialogButton(
//                                             //         child: const Text(
//                                             //           "ok",
//                                             //           style: TextStyle(
//                                             //               color: Colors.white,
//                                             //               fontSize: 20),
//                                             //         ),
//                                             //         onPressed: () {
//                                             //           Navigator.pop(context);
//                                             //         },
//                                             //         color: Colors
//                                             //             .greenAccent.shade700,
//                                             //         radius: BorderRadius.circular(
//                                             //             10.0),
//                                             //       ),
//                                             //     ],
//                                             //   ).show();
//                                             // } else if (salespricecontroller
//                                             //     .text.isEmpty) {
//                                             //   Alert(
//                                             //     context: context,
//                                             //     style: commonAlertStyle,
//                                             //     type: AlertType.warning,
//                                             //     title:
//                                             //         "Sales price can't be empty",
//                                             //     buttons: [
//                                             //       DialogButton(
//                                             //         child: const Text(
//                                             //           "ok",
//                                             //           style: TextStyle(
//                                             //               color: Colors.white,
//                                             //               fontSize: 20),
//                                             //         ),
//                                             //         onPressed: () {
//                                             //           Navigator.pop(context);
//                                             //         },
//                                             //         color: Colors
//                                             //             .greenAccent.shade700,
//                                             //         radius: BorderRadius.circular(
//                                             //             10.0),
//                                             //       ),
//                                             //     ],
//                                             //   ).show();
//                                             // } else {
//
//                                             if (ismultiplevariation == true &&
//                                                 trackable == false) {
//                                               for (int ind = 0;
//                                                   ind < output1[0].length;
//                                                   ind++) {
//                                                 setState(() {
//                                                   varient_test.add(Variant(
//                                                     skuOfSeller:
//                                                         skusellercontroller
//                                                             .text,
//                                                     price:
//                                                         _pricecontrollers[ind]
//                                                             .text,
//                                                     salesPrice:
//                                                         _salespricecontrollers[
//                                                                 ind]
//                                                             .text,
//                                                     minStockWarning: "",
//                                                     inventory: "",
//                                                     stockStatus:
//                                                         selected_stockstatus,
//                                                     variantType: [
//                                                       {
//                                                         "inventory_type":
//                                                             type1controller
//                                                                 .text,
//                                                         "value": output1[0][ind]
//                                                             [0]
//                                                       },
//                                                       {
//                                                         "inventory_type":
//                                                             type2controller
//                                                                 .text,
//                                                         "value": output1[0][ind]
//                                                             [1]
//                                                       }
//                                                     ],
//                                                     isAvailable: selecteditemse!
//                                                         .contains(output1[0]
//                                                                 [ind]
//                                                             .toString()),
//                                                     minOrder: int.parse(
//                                                         minimumordercontroller
//                                                             .text),
//                                                     maxOrder: int.parse(
//                                                         _controllers[ind].text),
//                                                   ));
//                                                 });
//                                               }
//
//                                               val = val + 0.4;
//                                               pricesvisible = false;
//                                               imagesvisible = true;
//                                             } else if (ismultiplevariation ==
//                                                     true &&
//                                                 istrackable == true) {
//                                               for (int ind = 0;
//                                                   ind < output1[0].length;
//                                                   ind++) {
//                                                 setState(() {
//                                                   varient_test.add(Variant(
//                                                     inventory:
//                                                         _inventorymultivarianttrue[
//                                                                 ind]
//                                                             .text,
//                                                     minStockWarning:
//                                                         _minstockwarningmultiple[
//                                                                 ind]
//                                                             .text,
//                                                     skuOfSeller:
//                                                         skusellercontroller
//                                                             .text,
//                                                     price:
//                                                         _pricecontrollers[ind]
//                                                             .text,
//                                                     salesPrice:
//                                                         _salespricecontrollers[
//                                                                 ind]
//                                                             .text,
//                                                     stockStatus:
//                                                         selected_stockstatus,
//                                                     variantType: [
//                                                       {
//                                                         "inventory_type":
//                                                             type1controller
//                                                                 .text,
//                                                         "value": output1[0][ind]
//                                                             [0]
//                                                       },
//                                                       {
//                                                         "inventory_type":
//                                                             type2controller
//                                                                 .text,
//                                                         "value": output1[0][ind]
//                                                             [1]
//                                                       }
//                                                     ],
//                                                     isAvailable: selecteditemse!
//                                                         .contains(output1[0]
//                                                                 [ind]
//                                                             .toString()),
//                                                     minOrder: int.parse(
//                                                         minimumordercontroller
//                                                             .text),
//                                                     maxOrder: int.parse(
//                                                         _controllers[ind].text),
//                                                   ));
//                                                 });
//                                               }
//                                               val = val + 0.4;
//                                               pricesvisible = false;
//                                               imagesvisible = true;
//                                             } else if (ismultiplevariation ==
//                                                     false &&
//                                                 istrackable == true) {
//                                               varient_test.add(Variant(
//                                                 isAvailable: check_availability,
//                                                 minStockWarning:
//                                                     minimumstockwarningtrackabletruecontroller
//                                                         .text,
//                                                 inventory:
//                                                     inventorycountcontroller
//                                                         .text,
//                                                 maxOrder: int.parse(
//                                                     maximumordercontroller
//                                                         .text),
//                                                 minOrder: int.parse(
//                                                     minimumordercontroller
//                                                         .text),
//                                                 variantType: [],
//                                                 price: pricecontroller.text,
//                                                 salesPrice:
//                                                     salespricecontroller.text,
//                                                 stockStatus:
//                                                     selected_stockstatus,
//                                                 skuOfSeller:
//                                                     skusellercontroller.text,
//                                               ));
//                                               setState(() {
//                                                 val = val + 0.4;
//                                                 pricesvisible = false;
//                                                 imagesvisible = true;
//                                               });
//                                             } else if (ismultiplevariation ==
//                                                     false &&
//                                                 trackable == false) {
//                                               varient_test.add(Variant(
//                                                 isAvailable: check_availability,
//                                                 maxOrder: int.parse(
//                                                     maximumordercontroller
//                                                         .text),
//                                                 minOrder: int.parse(
//                                                     minimumordercontroller
//                                                         .text),
//                                                 price: pricecontroller.text,
//                                                 variantType: [],
//                                                 inventory: "",
//                                                 minStockWarning: "",
//                                                 salesPrice:
//                                                     salespricecontroller.text,
//                                                 stockStatus:
//                                                     selected_stockstatus,
//                                                 skuOfSeller:
//                                                     skusellercontroller.text,
//                                               ));
//                                               setState(() {
//                                                 val = val + 0.4;
//                                                 pricesvisible = false;
//                                                 imagesvisible = true;
//                                               });
//                                             }
//
//                                             // inspect(varient_test);
//
//                                             // });
//                                           },
//                                           child: const Text('continue')),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Visibility(
//                           visible: imagesvisible,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     const Text(
//                                       "Images",
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     IconButton(
//                                         onPressed: () {
//                                           Fluttertoast.showToast(
//                                               gravity: ToastGravity.TOP,
//                                               msg:
//                                                   'Please upload minimum image size of (1024px * 1024px)');
//                                         },
//                                         icon: const Icon(
//                                           Icons.help_outline_outlined,
//                                           color: Colors.grey,
//                                           size: 20,
//                                         ))
//                                   ],
//                                 ),
//
//                                 GridImagePicker(
//                                   setImageList: updateImage,
//                                   preImages: imageList,
//                                 ),
//                                 // Image.network(
//                                 //     data.productdetailData['image'][0]
//                                 //         ['document']['path']),
//
//                                 //  Padding(
//                                 //    padding: const EdgeInsets.all(8.0),
//                                 //    child: DottedBorder(
//                                 //      color: Colors.grey,
//                                 //      strokeWidth: 1,
//                                 //      dashPattern: [10,6],
//                                 //      child: Container(
//                                 //        width: double.infinity,
//                                 //        height: 50,
//                                 //
//                                 //        child: TextButton(onPressed: () async{
//                                 //          // showModalBottomSheet(
//                                 //          //   context: context,
//                                 //          //   builder: ((builder) => bottomSheet()),
//                                 //          // );
//                                 //        }, child: const Text("Upload image from Media")),
//                                 //      ),
//                                 //    ),
//                                 //  ),
//                                 // const Padding(
//                                 //    padding: EdgeInsets.all(8.0),
//                                 //    child: Text("Notes : Please upload minimum image size of (1024px * 1024px) for better look in your website.",
//                                 //      style: TextStyle(fontSize: 13,color: Colors.grey),),
//                                 //
//                                 //
//                                 //  ),
//                                 //  _imageFile == null
//                                 //      ? const SizedBox(
//                                 //    height: 1,
//                                 //  )
//                                 //      : Padding(
//                                 //    padding: const EdgeInsets.all(8.0),
//                                 //    child: Stack(
//                                 //      children: <Widget>[
//                                 //        // Image.file(
//                                 //        //   File(_imageFile!.path),
//                                 //        //   height: 100,
//                                 //        //   width: 100,
//                                 //        // ),
//                                 //        Positioned(
//                                 //          top: -8,
//                                 //          right: -2,
//                                 //          child: InkWell(
//                                 //            onTap: () {
//                                 //              setState(() {
//                                 //                _imageFile = null;
//                                 //              });
//                                 //            },
//                                 //            child: const Padding(
//                                 //              padding: EdgeInsets.all(8.0),
//                                 //              child: Icon(
//                                 //                Icons.clear,
//                                 //                color: Colors.red,
//                                 //                size: 28.0,
//                                 //              ),
//                                 //            ),
//                                 //          ),
//                                 //        ),
//                                 //      ],
//                                 //    ),
//                                 //  ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Visibility(
//                           visible: imagesvisible,
//                           child: Container(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       const Text(
//                                         "Status",
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       IconButton(
//                                           onPressed: () {
//                                             Fluttertoast.showToast(
//                                                 msg: 'Product Active status');
//                                           },
//                                           icon: Icon(
//                                             Icons.help_outline_outlined,
//                                             color: Colors.grey,
//                                             size: 20,
//                                           ))
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Checkbox(
//                                         value: this.active_status,
//                                         onChanged: (bool? value) {
//                                           setState(() {
//                                             this.active_status = value!;
//                                           });
//                                         },
//                                       ),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       const Text(
//                                         "ACTIVE",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.normal),
//                                       ),
//                                       const SizedBox(
//                                         height: 25,
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       TextButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               imagesvisible = false;
//                                               pricesvisible = true;
//                                               val = val - 0.2;
//                                               varient_test.clear();
//                                             });
//                                           },
//                                           child: const Text('back')),
//                                       TextButton(
//                                           onPressed: () async {
//                                             try {
//                                               Addproductrequest _request =
//                                                   Addproductrequest(
//                                                 // image: imageList,
//                                                 weight: weightcontroller.text,
//                                                 volume: Volume(
//                                                     height:
//                                                         heightcontroller.text,
//                                                     width: widthcontroller.text,
//                                                     length:
//                                                         lengthcontroller.text),
//                                                 tags: tags_list,
//                                                 skuOfSeller:
//                                                     skusellercontroller.text,
//                                                 isPublished: false,
//                                                 isActiveSeller: true,
//                                                 inventoryType:
//                                                     ismultiplevariation == true
//                                                         ? inventory_type
//                                                         : [],
//
//                                                 variant: varient_test,
//                                                 isTrackableInventory:
//                                                     istrackable,
//                                                 isMultipleVariation:
//                                                     ismultiplevariation,
//                                                 customAttribute:
//                                                     custom_attribute,
//
//                                                 productType:
//                                                     selected_productype,
//                                                 category: selected_category,
//                                                 name:
//                                                     productnamecontroller.text,
//                                                 urlKey: urlkeycontroller.text,
//                                                 brand: selected_brand,
//                                                 manufacturer:
//                                                     selected_manufacturer,
//                                                 description:
//                                                     descriptioncontroller.text,
//                                               );
//                                               ProductRepository repo =
//                                                   ProductRepository();
//                                               Addproductresponse res =
//                                                   await repo.testpostproduct(
//                                                       _request, imageList);
//                                               if (res.success == true) {
//                                                 Alert(
//                                                   context: context,
//                                                   style: commonAlertStyle,
//                                                   type: AlertType.success,
//                                                   title: res.msg,
//                                                   desc:
//                                                       "Customer can see your listing after approval",
//                                                   buttons: [
//                                                     DialogButton(
//                                                       child: const Text(
//                                                         "Successful",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20),
//                                                       ),
//                                                       onPressed: () {
//                                                         Navigator.pop(context);
//                                                         Navigator.pop(context);
//                                                       },
//                                                       color: Colors
//                                                           .greenAccent.shade700,
//                                                       radius:
//                                                           BorderRadius.circular(
//                                                               10.0),
//                                                     ),
//                                                   ],
//                                                 ).show();
//                                               } else {
//                                                 Alert(
//                                                   context: context,
//                                                   style: commonAlertStyle,
//                                                   type: AlertType.error,
//                                                   title: res.msg,
//                                                   desc:
//                                                       "Products could not be created",
//                                                   buttons: [
//                                                     DialogButton(
//                                                       child: const Text(
//                                                         "Close",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20),
//                                                       ),
//                                                       onPressed: () {
//                                                         Navigator.pop(context);
//                                                         // Navigator.pop(context);
//                                                       },
//                                                       color: Colors
//                                                           .redAccent.shade700,
//                                                       radius:
//                                                           BorderRadius.circular(
//                                                               10.0),
//                                                     ),
//                                                   ],
//                                                 ).show();
//                                               }
//                                             } catch (e) {
//                                               print(e);
// // updateSpinner(false);
//                                               Alert(
//                                                 context: context,
//                                                 style: commonAlertStyle,
//                                                 type: AlertType.error,
//                                                 title: "Sorry",
//                                                 desc:
//                                                     "Could not connect to the server",
//                                                 buttons: [
//                                                   DialogButton(
//                                                     child: const Text(
//                                                       "Close",
//                                                       style: TextStyle(
//                                                           color: Colors.white,
//                                                           fontSize: 20),
//                                                     ),
//                                                     onPressed: () {
//                                                       Navigator.pop(context);
//                                                       // Navigator.pop(context);
//                                                     },
//                                                     color: Colors
//                                                         .redAccent.shade700,
//                                                     radius:
//                                                         BorderRadius.circular(
//                                                             10.0),
//                                                   ),
//                                                 ],
//                                               ).show();
//                                             }
//                                           },
//                                           child: const Text('Submit')),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     crossAxisAlignment: CrossAxisAlignment.center,
// //                     children: <Widget>[
// //                       Padding(
// //                         padding:
// //                             const EdgeInsets.only(left: 15.0, top: 15.0),
// //                         child: SizedBox(
// //                           height: 40,
// //                           width: 95,
// //                           child: ElevatedButton(
// //                             style: ButtonStyle(
// //                                 backgroundColor:
// //                                     MaterialStateProperty.all(Colors.white),
// //                                 shape: MaterialStateProperty.all<
// //                                         RoundedRectangleBorder>(
// //                                     RoundedRectangleBorder(
// //                                   borderRadius: BorderRadius.circular(18.0),
// //                                 ))),
// //                             onPressed: () {
// //                               Navigator.pop(context);
// //                             },
// //                             child: const Text("Cancel",
// //                                 style: TextStyle(
// //                                     fontSize: 14, color: Colors.black)),
// //                           ),
// //                         ),
// //                       ),
// //                       Padding(
// //                         padding:
// //                             const EdgeInsets.only(left: 15.0, top: 15.0),
// //                         child: SizedBox(
// //                           height: 40,
// //                           width: 95,
// //                           child: ElevatedButton(
// //                             onPressed: () async {
// //                               // test_varient!.price = pricecontroller.toString();
// //                               //
// //                               // setState(() {
// //                               //   // document_list.add(Document(destination: 'public/files/',path: _imageFile!.path,filename: _imageFile.toString()));
// //                               //   varient_list!.add(
// //                               //       {
// //                               //         'isAvailable': check_availability,
// //                               //         'maxOrder': maximumordercontroller.text,
// //                               //         'minOrder': minimumordercontroller.text,
// //                               //         'price': pricecontroller.text,
// //                               //         'salesPrice': salespricecontroller.text,
// //                               //         'stockStatus': selected_stockstatus,
// //                               //         'skuOfSeller': skusellercontroller.text,
// //                               //       },
// //                               //   );
// //                               // });
// //                               // Map<String,dynamic> dat= {
// //                               //      "weight": "1333",
// //                               //      "volume": { "height": "23", "width": "33", "length": "33" },
// //                               //      "tags": ["attat", "atat"],
// //                               //      "sku_of_seller": "taatatt",
// //                               //      "variant": [{
// //                               //          "is_available": true,
// //                               //          "stock_status": "5df61e4017bcc76ed4c4a10f",
// //                               //          "min_order": "11",
// //                               //          "max_order": "12",
// //                               //          "sales_price": "11",
// //                               //          "price": "12",
// //                               //          "sku_of_seller": "taatatt"
// //                               //      }],
// //                               //      "is_trackable_inventory": false,
// //                               //      "is_multiple_variation": false,
// //                               //      "product_type": "5eb9304b4ad49d1b825fe005",
// //                               //      "category": "5eba4a434ad49d1b825fe671",
// //                               //      "name": "tataaaa",
// //                               //      "url_key": "tataaaa",
// //                               //      "brand": "5e3a67754ae64f55f7749a04",
// //                               //      "manufacturer": "5ec103794ad49d1b82600fbe",
// //                               //      "description": "tattatatat"
// //                               //  };
// //
// //                               // Addproductrequest _request = Addproductrequest(
// //                               //   weight: weightcontroller.text,
// //                               //   tags: tags_list,
// //                               //   skuOfSeller: skusellercontroller.text,
// //                               //   isTrackableInventory: istrackable,
// //                               //   isMultipleVariation: ismultiplevariation,
// //                               //   productType: selected_productype,
// //                               //   category: selected_category,
// //                               //   name: productnamecontroller.text,
// //                               //   urlKey: urlkeycontroller.text,
// //                               //   brand: selected_brand,
// //                               //   manufacturer: selected_manufacturer,
// //                               //   description: descriptioncontroller.text,
// //                               // );
// //                               // ProductRepository repo = ProductRepository();
// //                               // Addproductresponse res =
// //                               // await repo.updateImage(
// //                               //     _request,
// //                               //     true,
// //                               //     selected_stockstatus!,
// //                               //     minimumordercontroller.text,
// //                               //     maximumordercontroller.text,
// //                               //     salespricecontroller.text,
// //                               //     pricecontroller.text,
// //                               //     skusellercontroller.text,
// //                               //     heightcontroller.text,
// //                               //     lengthcontroller.text,
// //                               //     widthcontroller.text,
// //                               //     imageList);
// //
// //                               // final json = jsonEncode(_request);
// //
// //                               // Addproductresponse res = await repo
// //                               //     .addproductwithimage(_request, imageList);
// //                               // if(res.success == true){
// //                               //   print(res.msg);
// //                               // }else
// //                               //   {
// //                               //     print(res.msg);
// //                               //   }
//
// //                               // Addproductresponse res = await repo.addproductwithimage(json,imageList);
// //                             },
// //                             style: ButtonStyle(
// //                                 backgroundColor:
// //                                     MaterialStateProperty.all(Colors.green),
// //                                 shape: MaterialStateProperty.all<
// //                                         RoundedRectangleBorder>(
// //                                     RoundedRectangleBorder(
// //                                   borderRadius: BorderRadius.circular(18.0),
// //                                 ))),
// //                             child: const Text(
// //                               "Update",
// //                               style: TextStyle(
// //                                   fontSize: 14, color: Colors.white),
// //                             ),
// //                           ),
// //                         ),
// //                       )
// //                     ],
// //                   ),
//                         const SizedBox(
//                           height: 20,
//                         )
//                       ],
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void setprogress(String? newValue) {
//     setState(() {
//       val = val + 0.5;
//     });
//   }
//
//   Iterable<List<dynamic>> comb<T>(List<dynamic> sources) sync* {
//     if (sources.isEmpty || sources.any((l) => l.isEmpty)) {
//       yield [].toList();
//       return;
//     }
//     var indices = List<int>.filled(sources.length, 0);
//     var next = 0;
//     while (true) {
//       yield [for (var i = 0; i < indices.length; i++) sources[i][indices[i]]];
//       while (true) {
//         var nextIndex = indices[next] + 1;
//         if (nextIndex < sources[next].length) {
//           indices[next] = nextIndex;
//           break;
//         }
//         next += 1;
//         if (next == sources.length) return;
//       }
//       indices.fillRange(0, next, 0);
//       next = 0;
//     }
//   }
//
//   Widget singleItemList(int index, TextEditingController controllertxt) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: controllertxt,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "Qty",
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
