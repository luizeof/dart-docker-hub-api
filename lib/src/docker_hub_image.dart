/// Docker Image
class DockerImage {
  ///
  final String user;
  final String name;
  final String namespace;
  final String repository_type;
  final int status;
  final String description;
  final bool is_private;
  final bool is_automated;
  final bool can_edit;
  final int star_count;
  final int pull_count;
  final DateTime last_updated;
  final bool is_migrated;
  final bool has_starred;
  final String full_description;
  final String affiliation;

  DockerImage(
      {this.user,
      this.name,
      this.namespace,
      this.repository_type,
      this.status,
      this.description,
      this.is_private,
      this.is_automated,
      this.can_edit,
      this.star_count,
      this.pull_count,
      this.last_updated,
      this.is_migrated,
      this.has_starred,
      this.full_description,
      this.affiliation});

  factory DockerImage.fromJson(Map<String, dynamic> json) {
    return DockerImage(
      user: json['user'].toString(),
      name: json['name'].toString(),
      namespace: json['namespace'].toString(),
      repository_type: json['repository_type'].toString(),
      status: json['status'],
      description: json['description'].toString(),
      is_private: json['is_private'] == 'true' ? true : false,
      is_automated: json['is_automated'] == 'true' ? true : false,
      can_edit: json['can_edit'] == 'true' ? true : false,
      star_count: json['star_count'],
      pull_count: json['pull_count'],
      last_updated: json['last_updated'].toString().isNotEmpty
          ? DateTime.parse(json['last_updated'])
          : null,
      is_migrated: json['is_migrated'] == 'true' ? true : false,
      has_starred: json['has_starred'] == 'true' ? true : false,
      full_description: json['full_description'].toString(),
      affiliation: json['affiliation'].toString(),
    );
  }

  /// Repository Public URL
  String get publicUrl => 'https://hub.docker.com/r/${user}/${name}/';

  /// Repository Image Key
  String get imageKey => '${user}/${name}'.replaceAll('/', '__');
}
