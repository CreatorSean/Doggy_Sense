import 'package:doggy_sense/screens/feed/view_model/upload_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class UploadChoice extends ConsumerWidget {
  const UploadChoice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadState = ref.watch(uploadProvider);
    final uploadNotifier = ref.read(uploadProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            '취소',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        title: const Text('사진첩 선택'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      body: uploadState.albums.isNotEmpty
          ? ListView.builder(
              itemCount: uploadState.albums.length,
              itemBuilder: (context, index) {
                final album = uploadState.albums[index];
                final images = album.images;

                return GestureDetector(
                  onTap: () {
                    // 선택된 앨범 인덱스를 변경
                    uploadNotifier.changeIndex(index);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: images != null && images.isNotEmpty
                              ? AssetEntityImage(
                                  images[0],
                                  fit: BoxFit.cover,
                                  isOriginal: true,
                                )
                              : const SizedBox(), // 이미지가 없을 경우 빈 위젯 반환
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              album.name ?? '앨범 이름 없음',
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text('${images?.length ?? 0}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(child: Text('텅')),
    );
  }
}
