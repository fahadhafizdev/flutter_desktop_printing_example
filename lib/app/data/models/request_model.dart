class RequestModel {
  dynamic docUrl;
  final String url;
  final String title;
  final bool downlodable;
  final bool isFastPrint;

  RequestModel(
      {required this.title,
      required this.url,
      this.docUrl,
      required this.downlodable,
      required this.isFastPrint});
}
