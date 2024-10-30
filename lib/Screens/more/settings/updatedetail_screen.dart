import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:schoolworkspro_app/constants.dart';
import 'package:schoolworkspro_app/request/moredetailupdate_request.dart';
import 'package:schoolworkspro_app/services/updatepassword_service.dart';

import '../../../constants/colors.dart';

class Updatedetailscreen extends StatefulWidget {
  const Updatedetailscreen({Key? key}) : super(key: key);

  @override
  _UpdatedetailscreenState createState() => _UpdatedetailscreenState();
}

class _UpdatedetailscreenState extends State<Updatedetailscreen> {
  TextEditingController _contact = TextEditingController();
  TextEditingController _address = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  MultiValidator address() {
    return MultiValidator([
      RequiredValidator(errorText: 'Field cannot be empty'),
    ]);
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return "";
  }

  MultiValidator phoneNumberValidator() {
    return MultiValidator([
      RequiredValidator(errorText: 'Field cannot be empty'),
      MinLengthValidator(10,
          errorText: 'phone number must be at least 10 digits long'),
      MaxLengthValidator(10,
          errorText: 'phone number must not be more than 10 digits long'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          title: const Text(
            "Update details",
            style: TextStyle(color: white),
          ),

      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _contact,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                            .hasMatch(value) ||
                        value.length > 10 ||
                        value.length < 10) {
                      //  r'^[0-9]{10}$' pattern plain match number with length 10
                      return "Enter Correct Phone Number";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: kPrimaryColor,
                      ),
                      hintText: 'Enter phone number',
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // labelText: 'Phone number'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _address,
                  validator: address(),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      hintText: 'Enter address',
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // labelText: 'Address'
                  ),
                ),
              ),
              _isLoading == false
                  ? ElevatedButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) {
                          setState(() {
                            autovalidateMode =
                                AutovalidateMode.onUserInteraction;
                          });
                        } else {
                          setState(() {
                            _isLoading = true;
                          });
                          final data = MoredetailUpdateRequest(
                              contact: _contact.text, address: _address.text);
                          final result =
                              await Updatepasswordservice().updateDetails(data);

                          if (result.success == true) {
                            _contact.clear();
                            _address.clear();
                            setState(() {
                              _isLoading = true;
                            });
                            Fluttertoast.showToast(
                                msg: 'Details updated successfully');
                            setState(() {
                              _isLoading = false;
                            });
                          } else {
                            setState(() {
                              _isLoading = true;
                            });
                            Fluttertoast.showToast(
                                msg: 'Error updating detail');
                          }
                        }
                      },
                      child: const Text("Update"),
                    )
                  : const SpinKitDualRing(
                      color: kPrimaryColor,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
