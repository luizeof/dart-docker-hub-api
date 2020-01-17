import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'docker_hub_image.dart';

/// Docker Repository
class DockerRepository {
  ///
  DockerRepository(this.user);

  /// Docker Hub API Base Url
  final String _base_url = 'https://hub.docker.com/v2/repositories/';

  /// Docker Hub Repository User
  String user;

  /// Response Body
  var responseBody;

  /// Number of Repository Images
  int imageCount;

  /// Number of Navigation Pages
  int get pageCount => (imageCount > 0) ? (imageCount / 10).ceil() : 1;

  String get publicUrl => 'https://hub.docker.com/r/${user}/';

  /// Repository Full Path
  String _repoPath(String _name) {
    return '${_base_url}${user}/${_name}?page=' + pageCount.toString();
  }

  /// Handle Request Success
  void _handleSuccess(Response response) {
    responseBody = response.body;
  }

  /// Handle Request Error
  void _handleFailure(error) {
    responseBody = error.osError.message;
  }

  /// Make a HTTP GET Request
  void httpGet(_url) async {
    await get(
      _url,
    ).then(_handleSuccess).catchError(_handleFailure);
  }

  /// Return Parsed JSON
  Map<String, dynamic> _getJson() {
    return jsonDecode(responseBody);
  }

  /// Return All Images
  Future<List<DockerImage>> images({int page = 1}) async {
    await httpGet('${_base_url}${user}/?page=${page}');
    imageCount = _getJson()['count'];
    var images = <DockerImage>[];
    final data = _getJson()['results'];
    for (var i = 0; i < data.length; i++) {
      final _repo_path = _repoPath(data[i]['name']);
      var imageResponse = await get(_repo_path);
      final imageData = jsonDecode(imageResponse.body);
      images.add(
        DockerImage.fromJson(imageData),
      );
    }
    return images;
  }

  /// Return All Images
  Future<DockerImage> getImage(String _name) async {
    await httpGet('${_base_url}${user}/${_name}');
    try {
      return DockerImage.fromJson(_getJson());
    } catch (e) {
      return null;
    }
  }

  ///
}
