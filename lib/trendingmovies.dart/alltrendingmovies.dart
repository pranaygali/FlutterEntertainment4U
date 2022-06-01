import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:http/http.dart' as http;

class TrendMovies extends StatefulWidget {
  const TrendMovies({Key? key}) : super(key: key);

  @override
  State<TrendMovies> createState() => _TrendMoviesState();
}

class _TrendMoviesState extends State<TrendMovies> {
  late WebViewController _controller;
  void _fetchAllMovies() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Movies'),
        centerTitle: false,
      ),
      body: Center(
        child: WebView(
          initialUrl: 'https://www.imdb.com/?ref_=ls_mv_close',
          onWebViewCreated: (WebViewController webviewcontroller) {
            _controller = webviewcontroller;
          },
        ),
      ),
    );
  }
}
