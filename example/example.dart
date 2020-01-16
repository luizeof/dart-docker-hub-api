import 'package:docker_hub_api/docker_hub_api.dart';

void main() async {
  var repo = DockerRepository('nginx');

  var images = await repo.images(page: 1);

  var image = images.first;

  print(image.user);
  print(image.name);
  print(image.namespace);
  print(image.repository_type);
  print(image.status);
  print(image.description);
  print(image.is_private);
  print(image.is_automated);
  print(image.can_edit);
  print(image.star_count);
  print(image.pull_count);
  print(image.last_updated);
  print(image.is_migrated);
  print(image.has_starred);
  print(image.full_description);
  print(image.affiliation);
  print(repo.imageCount);
  print(repo.pageCount);
}
