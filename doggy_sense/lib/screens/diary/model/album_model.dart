import 'package:photo_manager/photo_manager.dart';

class AlbumModel {
  String? id;
  String? name;
  List<AssetEntity>? images;

  AlbumModel({required this.id, required this.name, required this.images});

  factory AlbumModel.fromGallery(
      String id, String name, List<AssetEntity> images) {
    return AlbumModel(id: id, name: name, images: images);
  }
}
