import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import '../Utils/Utils.dart';

class GalleryFolderController with ChangeNotifier {
  bool isloading = true;

//gallery folder list
  Future galleryfolderlist() async {
    isloading = true;
    List temp = [];
    final List<AssetPathEntity> galleryList =
        await PhotoManager.getAssetPathList(
      type: RequestType.video,
    );
    gallerylist.clear();
    temp.addAll(galleryList);
    for (int i = 1; i < temp.length; i++) {
      int t = (await temp[i].assetCountAsync);
      if (t != 0) {
        totalvideos.add(t);
        gallerylist.add(temp[i]);
      }
    }
    for (int i = 0; i < gallerylist.length; i++) {
      final List<AssetEntity> listt =
          await gallerylist[i].getAssetListPaged(page: 0, size: 1);
      print("objec${listt.length}");
      if (listt.isNotEmpty) {
        for (var data in listt) {
          Uint8List? thumbnail = (await data.thumbnailData);
          galleryuint.add(thumbnail!);
        }
      } else {
        final ByteData bytes =
            await rootBundle.load('assets/images/vr_icon.png');
        final Uint8List list = bytes.buffer.asUint8List();
        galleryuint.add(list);
      }
    }
    log(galleryuint.length.toString());
    isloading = false;
    notifyListeners();
  }

//video in each folder
  Future videoinfolders(AssetPathEntity item) async {
    videolist = [];
    videothumbnailuint = [];
    isloading = true;
    item = await item.obtainForNewProperties();
    assetcount = await item.assetCountAsync;
    final List<AssetEntity> listt =
        await item.getAssetListPaged(page: 0, size: 50);
    videolist.addAll(listt);
    for (var asset in videolist) {
      Uint8List img = (await asset.thumbnailData)!;
      if (img=="") {
        final ByteData bytes =
            await rootBundle.load('assets/images/vr_icon.png');
        final Uint8List list = bytes.buffer.asUint8List();
        videothumbnailuint.add(list);
      } else {
      videothumbnailuint.add(img);}
    }
    Future.delayed(const Duration(seconds: 1), () {
      isloading = false;
      notifyListeners();
    });
  }

  void loader() {
    isloading = false;
    notifyListeners();
  }

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }
}
