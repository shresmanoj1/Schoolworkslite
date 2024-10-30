import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
// import 'package:image_downloader/image_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:schoolworkspro_app/Screens/widgets/snack_bar.dart';
import 'package:share_plus/share_plus.dart';


class Paymentmethoddetailscreen extends StatefulWidget {
  final data;
  const Paymentmethoddetailscreen({Key? key, this.data}) : super(key: key);

  @override
  State<Paymentmethoddetailscreen> createState() =>
      _PaymentmethoddetailscreenState();
}

class _PaymentmethoddetailscreenState extends State<Paymentmethoddetailscreen> {
  String _message = "";
  String _path = "";
  String _size = "";
  String _mimeType = "";
  File? _imageFile;
  int _progress = 0;


  Future<void> _download(String url) async {
    final response = await http.get(Uri.parse(url));

    // Get the image name
    final imageName = path.basename(url);
    // Get the document directory path
    final appDir = await path_provider.getApplicationDocumentsDirectory();

    // This is the saved image path
    // You can use it to display the saved image later
    final localPath = path.join(appDir.path, imageName);

    // Downloading
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);
  }

  @override
  void initState() {
    // TODO: implement initState
    // ImageDownloader.callback(onProgressUpdate: (String? imageId, int progress) {
    //   setState(() {
    //     _progress = progress;
    //   });
    // });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          widget.data['payment_type'],
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.data['qr'] == null || widget.data['qr'].isEmpty
                ? SizedBox()
                :
                      Container(
                          height: 230,
                          width: 230,
                          child: Image.network(
                              'https://api.schoolworkspro.com/uploads/${widget.data['qr']}')),
           


            widget.data['name'] == null || widget.data['name'].isEmpty
                ? const SizedBox()
                : RichText(
                    text: TextSpan(
                      text: 'Name: ',
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.data['name'].toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),

            widget.data['account_no'] == null ||
                    widget.data['account_no'].isEmpty
                ? const SizedBox()
                : RichText(
                    text: TextSpan(
                      text: 'A/c no: ',
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.data['account_no'].toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),

            widget.data['bank_name'] == null || widget.data['bank_name'].isEmpty
                ? const SizedBox()
                : RichText(
                    text: TextSpan(
                      text: 'Bank: ',
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.data['bank_name'].toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
          Builder(builder: (context) {
            if(_progress > 0 && _progress <= 99){
              return Text('Downloading...');
            }else if(_progress == 0){
              return SizedBox();
            }
            else{
              return Text('QR Downloaded');
            }

          },),
          // _progress == 0 ? SizedBox():  Text('Progress: $_progress % Downloaded'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // IconButton(onPressed:(){
                //   _downloadImage('https://api.schoolworkspro.com/uploads/${widget.data['qr']}');
                // }, icon: const Icon(Icons.save)),
                IconButton(onPressed: () async{
                  String text =  widget.data['payment_type'] == "bank" ?
                  "A/c name: " + widget.data['name'] +"\n"+"A/c number: " + widget.data['account_no'] + "\n" + "Payment type: "+widget.data['payment_type'] + "\n" + "Bank name: " + widget.data['bank_name']
                      : "A/c name: " + widget.data['name'] +"\n"+"A/c number: " + widget.data['account_no'] + "\n" + "Payment type: "+widget.data['payment_type'] + "\n";
                  final uri = Uri.parse('https://api.schoolworkspro.com/uploads/${widget.data['qr']}');
                  final res = await http.get(uri);

                  final bytes = res.bodyBytes;

                  final temp = await getTemporaryDirectory();
                  final path = '${temp.path}/image.jpg';

                  File(path).writeAsBytesSync(bytes);
                  await Share.shareFiles([path],
                      text: text);
                }, icon:const Icon(Icons.share)),

              ],
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 180,
                width: double.infinity,
                color: Colors.orange.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("NOTES",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Text(
                        "- Pay your dues to our account details, or Scan QR code to pay if available.",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "- After payment is succcess, Attach the receipt and fill the form in previous page ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "- After you click on post, the tickets will be created to administration and they will approve ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            )
            // RichText(
            //   text: const TextSpan(
            //     text: 'Account number: ',
            //     style: TextStyle(fontSize: 14, color: Colors.black),
            //     children: <TextSpan>[
            //       TextSpan(
            //         text: ' ${'as'}',
            //       ),
            //     ],
            //   ),
            // ),
            // RichText(
            //   text: const TextSpan(
            //     text: 'Name of payment: ',
            //     style: TextStyle(fontSize: 14, color: Colors.black),
            //     children: <TextSpan>[
            //       TextSpan(
            //         text: ' ${'as'}',
            //       ),
            //     ],
            //   ),
            // ),
            // RichText(
            //   text: const TextSpan(
            //     text: 'Name of payment: ',
            //     style: TextStyle(fontSize: 14, color: Colors.black),
            //     children: <TextSpan>[
            //       TextSpan(
            //         text: ' ${'as'}',
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
  // Future<void> _downloadImage(
  //     String url, {
  //       AndroidDestinationType? destination,
  //       bool whenError = false,
  //       String? outputMimeType,
  //     }) async {
  //   String? fileName;
  //   String? path;
  //   int? size;
  //   String? mimeType;
  //   try {
  //     String? imageId;
  //
  //     if (whenError) {
  //       imageId = await ImageDownloader.downloadImage(url,
  //           outputMimeType: outputMimeType)
  //           .catchError((error) {
  //         if (error is PlatformException) {
  //           String? path = "";
  //           if (error.code == "404") {
  //             print("Not Found Error.");
  //           } else if (error.code == "unsupported_file") {
  //             print("UnSupported FIle Error.");
  //             path = error.details["unsupported_file_path"];
  //           }
  //           setState(() {
  //             _message = error.toString();
  //             _path = path ?? '';
  //           });
  //         }
  //
  //         print(error);
  //       }).timeout(Duration(seconds: 10), onTimeout: () {
  //         print("timeout");
  //         return;
  //       });
  //     } else {
  //       if (destination == null) {
  //         imageId = await ImageDownloader.downloadImage(
  //           url,
  //           outputMimeType: outputMimeType,
  //         );
  //       } else {
  //         imageId = await ImageDownloader.downloadImage(
  //           url,
  //           destination: destination,
  //           outputMimeType: outputMimeType,
  //         );
  //       }
  //     }
  //
  //     if (imageId == null) {
  //       return;
  //     }
  //     fileName = await ImageDownloader.findName(imageId);
  //     path = await ImageDownloader.findPath(imageId);
  //     size = await ImageDownloader.findByteSize(imageId);
  //     mimeType = await ImageDownloader.findMimeType(imageId);
  //   } on PlatformException catch (error) {
  //     setState(() {
  //       _message = error.message ?? '';
  //     });
  //     return;
  //   }
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     var location = Platform.isAndroid ? "Directory" : "Photo Library";
  //     _message = 'Saved as "$fileName" in $location.\n';
  //     _size = 'size:     $size';
  //     _mimeType = 'mimeType: $mimeType';
  //     _path = path ?? '';
  //
  //     if (!_mimeType.contains("video")) {
  //       _imageFile = File(path!);
  //     }
  //     return;
  //   });
  // }
}
