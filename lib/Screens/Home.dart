import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gsg_quiz_1/Helpers/CaptureImage.dart';
import 'package:gsg_quiz_1/Helpers/NetworkHelper.dart';
import 'package:gsg_quiz_1/Objects/Quote.dart';
import 'package:share_plus/share_plus.dart';

class Home extends StatefulWidget {
  String? url;
  Quote? quote;
  Home({super.key, this.url, this.quote});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Network_Helper, captureImage {
  SnackBar getResultSnackBar(ShareResult result) {
    return SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Share result: ${result.status}"),
          if (result.status == ShareResultStatus.success)
            Text("Shared to: ${result.raw}")
        ],
      ),
    );
  }

  GlobalKey globalKey = GlobalKey();
  Uint8List? pngBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.red),
            onPressed: () async {
              var newQuote = await getQuote();
              var newURL = await getImage(newQuote.tags?.first ?? 'school');
              setState(() {
                widget.quote = newQuote;
                widget.url = newURL;
              });
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          capturePng(context: context, globalKey: globalKey, pngBytes: pngBytes)
              .then((value) => onShareXFileFromAssets(context, value)
                  .then((result) => getResultSnackBar(result)));
        },
        isExtended: true,
        backgroundColor: Colors.redAccent,
        label: const Text('Share',
            style: TextStyle(
              fontFamily: 'FocusQuotes',
              fontSize: 24,
              color: Colors.white,
            )),
        icon: const Icon(Icons.share_outlined, color: Colors.white),
      ),
      body: RepaintBoundary(
        key: globalKey,
        child: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget.url ??
                      'https://images.rawpixel.com/image_1000/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjEwMTYtYy0wOF8xLWtzaDZtemEzLmpwZw.jpg',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.4),
                  BlendMode.lighten,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.quote?.content ?? 'Quote',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    backgroundColor: Colors.black.withOpacity(.4),
                    fontSize: 32,
                    fontFamily: 'FocusQuotes',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.quote?.author ?? 'Author',
                  style: const TextStyle(
                    fontFamily: 'FocusQuotes',
                    fontSize: 16,
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
