import 'dart:async';

import 'package:http/http.dart' as http;

class LoripsumApi {
  static Future<String> getLoripsum() async {
    Uri url =
        Uri.parse('http://loripsum.net/api/1/short/headers/decorate/bq/1/p/1');
    var response = await http.get(url);
    String? text = response.body;

    text = text.replaceAll('<p>', '');
    text = text.replaceAll('</p>', '');
    text = text.replaceAll('<h1>', '');
    text = text.replaceAll('</h1>', '');
    text = text.replaceAll('<i>', '');
    text = text.replaceAll('</i>', '');
    text = text.replaceAll("<blockquote cite='http://loripsum.net'>", '');
    text = text.replaceAll('</blockquote>', '');
    return text;
  }
}

class LoripsumBloc {
  final _controller = StreamController<String>();

  static String? lorim;
  Stream<String> get stream => _controller.stream;

  void fetch() async {
    String text = lorim ?? await LoripsumApi.getLoripsum();

    lorim = text;

    _controller.sink.add(text);
  }

  void dispose() {
    _controller.close();
  }
}
