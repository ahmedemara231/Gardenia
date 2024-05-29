class DownloadModel
{
  String urlPath;
  dynamic savePath;
  void Function(int, int) onReceiveProgress;

  DownloadModel({
    required this.urlPath,
    required this.savePath,
    required this.onReceiveProgress,
});
}