import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_web_21/utils/utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:printing/printing.dart';

class PaperPDFPreviewPage extends StatefulWidget {
  static final String routName="/paperPDFPage";

  String url;
  String title;
  bool isExam = false;
  var isCopyLoaded;

  PaperPDFPreviewPage(this.url, {this.isExam, this.title, this.isCopyLoaded});

  @override
  _PaperPDFPreviewPageState createState() => _PaperPDFPreviewPageState();
}

class _PaperPDFPreviewPageState extends State<PaperPDFPreviewPage> {
  List<Widget> pdfList = [];
  int currentIndex = 0;
  var loading = true;
  List<Uint8List> images = [];

  @override
  void initState() {
    super.initState();
    getListFromPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Colors.white,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              currentIndex = index;
              setState(() {});
            },
            child: Container(
              width: 60,
              height: 60,
              child: Stack(
                children: [
                  Image.memory(
                    images[index],
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  currentIndex == index
                      ? Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.deepOrange,
                        size: 40,
                      ))
                      : Container()
                ],
              ),
            ),
          ),
          itemCount: pdfList.length,
        ),
      ),
    );
  }

  getListFromPdf() async {
    var document = await downloadFile(widget.url, "studentImage");
    await for (var page in Printing.raster(document.readAsBytesSync())) {
      final image = await page.toPng();
      images.add(image);
      pdfList.add(Container(
        color: Colors.white,
        child: PhotoView(
          imageProvider: MemoryImage(image),
          backgroundDecoration: BoxDecoration(color: Colors.white),
        ),
      ));
    }
    setState(() {
      loading = false;
      if (widget.isCopyLoaded != null) widget.isCopyLoaded(true);
    });
  }
}