import 'package:doggy_sense/screens/diary/model/album_model.dart';
import 'package:doggy_sense/screens/diary/view/upload_choice.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class UploadState {
  final List<AlbumModel> albums;
  final AssetEntity? selectedImage;
  final int index;

  UploadState({
    required this.albums,
    required this.selectedImage,
    required this.index,
  });

  // 초기 상태 생성
  UploadState.initial()
      : albums = [],
        selectedImage = null,
        index = 0;

  UploadState copyWith({
    List<AlbumModel>? albums,
    AssetEntity? selectedImage,
    int? index,
  }) {
    return UploadState(
      albums: albums ?? this.albums,
      selectedImage: selectedImage ?? this.selectedImage,
      index: index ?? this.index,
    );
  }
}

class UploadNotifier extends StateNotifier<UploadState> {
  UploadNotifier() : super(UploadState.initial()) {
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      await getAlbum();
    } else {
      PhotoManager.openSetting();
    }
  }

  Future<void> getAlbum() async {
    final paths = await PhotoManager.getAssetPathList(type: RequestType.image);
    for (AssetPathEntity asset in paths) {
      final images = await asset.getAssetListRange(start: 0, end: 10000);
      if (images.isNotEmpty) {
        final album = AlbumModel.fromGallery(asset.id, asset.name, images);
        // 현재 상태의 albums에 새 앨범 추가
        state = state.copyWith(albums: [...state.albums, album]);
      }
    }
  }

  // 선택한 이미지 변경
  void selectImage(AssetEntity image) {
    state = state.copyWith(selectedImage: image);
  }

  // 앨범 인덱스 변경
  void changeIndex(int newIndex) {
    state = state.copyWith(index: newIndex);
  }

  // 네비게이션 이동 (Provider 방식)
  void moveToChoose(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const UploadChoice()),
    );
  }
}

// UploadNotifier를 사용할 수 있도록 provider 정의
final uploadProvider = StateNotifierProvider<UploadNotifier, UploadState>(
  (ref) => UploadNotifier(),
);
