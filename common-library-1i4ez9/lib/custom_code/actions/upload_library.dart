// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/foundation.dart';
import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:super_library_5mglde/custom_code/actions/super_library.dart';

class StorageService {
  static StorageService? _instance;
  static StorageService get instance => _instance ??= StorageService._();

  EdgeInsetsGeometry? uploadBottomSheetPadding;
  double? uploadBottomSheetSpacing;

  ///
  StorageService._();

  // StorageCustomize customize = StorageCustomize();

  /// [enableFilePickerExceptionHandler] is a flag to enable the exception
  /// handler. If it is true, it will show an error toast message when the user
  /// denies the permission to access the camera or the gallery. By default,
  /// it is true. If you want to handle the exception by yourself, set it to
  /// false.
  bool enableFilePickerExceptionHandler = true;

  init({
    // StorageCustomize? customize,
    bool? enableFilePickerExceptionHandler,
    EdgeInsetsGeometry? uploadBottomSheetPadding,
    double? uploadBottomSheetSpacing,
  }) {
    // if (customize != null) {
    //   this.customize = customize;
    // }
    if (enableFilePickerExceptionHandler != null) {
      this.enableFilePickerExceptionHandler = enableFilePickerExceptionHandler;
    }

    this.uploadBottomSheetPadding = uploadBottomSheetPadding;
    this.uploadBottomSheetSpacing = uploadBottomSheetSpacing;
  }

  /// Upload a file (or an image) to Firebase Storage.
  ///
  /// This method must be the only method that upload a file/photo into Storage
  /// or, the listing photos from `/storage` will not work properly.
  ///
  /// 범용 업로드 함수이며, 모든 곳에서 사용하면 된다.
  ///
  /// [path] is the file path on mobile phone(local storage) to upload.
  ///
  ///
  /// It returns the download url of the uploaded file.
  ///
  /// [progress] is a callback function that is called whenever the upload progress is changed.
  ///
  /// [complete] is a callback function that is called when the upload is completed.
  ///
  /// [compressQuality] is the quality of the compress for the image before uploading.
  /// 중요, compresssion 을 하면 이미지 가로/세로가 자동 보정 된다. 따라서 업로드를 하는 경우, 꼭 사용해야 하는 옵션이다.
  /// 참고로 compression 은 기본 이미지 용량의 내용에 따라 달라 진다.
  /// 이 값이 22 이면, 10M 짜리 파일이 140Kb 로 작아진다.
  /// 이 값이 70 이면, 30M 짜리 파일이 1M 로 작아진다.
  /// 이 값이 80 이면, 10M 짜리 파일이 700Kb 로 작아진다. 80 이면 충분하다. 기본 값이다.
  /// 이 값이 0 이면, compress 를 하지 않는다. 즉, 원본 사진을 그대로 올린다.
  ///
  /// [saveAs] is the path for the uploaded file to be saved in Firebase Storage.
  /// If it is null, it will be uploaded to the default path.
  ///
  /// This method does not handle any exception. You may handle it outisde if you want.
  ///
  ///
  Future<String?> uploadFile({
    Function(double)? progress,
    Function? complete,
    // Updated the default into zero
    // because videos and files will have problem
    // if we compress them using FlutterImageCompress.
    String? path,
    String? saveAs,
    String? type,
  }) async {
    if (path == null) return null;
    File file = File(path);
    if (!file.existsSync()) {
      dog('File does not exist: $path');
      throw Exception('File does not exist: $path');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final fileRef =
        storageRef.child(saveAs ?? "users/$myUid/${file.path.split('/').last}");
    // Review: Here only Image can be compressed. File and Video cannot be compressed.
    // It may cause error if you try to compress file or video.
    // So, we should check the file type before compressing.
    // Or... add custom compressing function for file and video, and/or image.
    // if (compressQuality > 0) {
    // final xfile = await FlutterImageCompress.compressAndGetFile(
    //   file.absolute.path,
    //   '${file.absolute.path}.compressed.jpg',
    //   quality: 100 - compressQuality,
    // );
    // file = File(xfile!.path);
    // }
    final uploadTask = fileRef.putFile(file);
    if (progress != null) {
      uploadTask.snapshotEvents.listen((event) {
        double rate = event.bytesTransferred / event.totalBytes;
        progress(rate < 0.2 ? 0.2 : rate);
      });
    }

    /// wait until upload-complete
    await uploadTask.whenComplete(() => complete?.call());
    final url = await fileRef.getDownloadURL();
    // print(fileRef.fullPath);

    return url;
  }

  /// Delete the uploaded file from Firebase Storage by the url.
  ///
  /// If the url is null or empty, it does nothing.
  ///
  /// If the [ref] is set, it will delete the field when the url is deleted.
  ///
  /// When the file does not exist in Firebsae Stroage,
  /// - If the [ref] is null, it will simply returns without firing exception.
  /// - If the [ref] is set, it will delete the field in the document.
  ///
  /// You can use this method especially when the file of the url in Storage is
  /// deleted already (or not exist). It will not throw an exception and you
  /// can continue the logic.
  Future<void> delete(
    String? url, {
    DatabaseReference? ref,
  }) async {
    if (url == null || url == '') return;
    final storageRef = FirebaseStorage.instance.refFromURL(url);
    try {
      await storageRef.delete();
    } on FirebaseException catch (e) {
      /// Oops! The file does not exist in the Firebase Storage.
      if (e.code == 'object-not-found') {
        if (ref == null) {
          /// Return as if the file is deleted.
          return;
        }
      } else {
        dog('Error deleting file on catch(FirebaseException): $url');
        dog(e.toString());
        rethrow;
      }
    } catch (e) {
      dog('Error deleting file on catch(e): $url');
      dog(e.toString());
    }

    if (ref != null) {
      await ref.remove();
    }
  }

  /// 이미지 업로드 소스(갤러리 또는 카메라) 선택창을 보여주고, 선택된 소스를 반환한다.
  ///
  /// [photoCamera] default true, 는 카메라를 선택할 수 있게 할지 여부이다.
  /// [photoGallery] default true, 는 갤러리를 선택할 수 있게 할지 여부이다.
  ///
  /// [videoCamera] default false, indicate whether to allow the video camera to be selected
  /// [videoGallery] default false, indicate whethere to allow the video gallery to be selected
  ///
  ///
  /// [fromGallery] default false, indicate whether to allow to select file from gallery
  /// [fromFile] default false, indicate whether to allow to select file from storage
  ///
  /// [spacing] default none, spacing between the selection,
  /// [padding] default EdgeInsets.zero, padding of the bottomsheet
  ///
  /// 사용자에게 사진/파일 업로드를 요청한다.
  ///
  /// 커스텀 디자인은 [customize] 에서 할 수 있다.
  Future<SourceType?> chooseUploadSource({
    required BuildContext context,
    bool? photoGallery,
    bool? photoCamera,
    bool? videoGallery,
    bool? videoCamera,
    bool? fromGallery,
    bool? fromFile,
    double? spacing,
    EdgeInsetsGeometry? padding,
  }) async {
    return await showModalBottomSheet(
      context: context,
      builder: (_) => StorageUploadSelectionBottomSheet(
        photoGallery: photoGallery,
        photoCamera: photoCamera,
        videoGallery: videoGallery,
        videoCamera: videoCamera,
        fromGallery: fromGallery,
        fromFile: fromFile,
        spacing: spacing,
        padding: padding,
      ),
    );
  }

  /// Update photos in the Firebase Storage.
  ///
  /// 사용자에게 사진/파일 업로드를 요청한다.
  ///
  /// 1. It displays the upload source selection dialog (camera or gallery).
  /// 2. It picks the file
  /// 3. It compresses the file
  /// 4. It uploads and calls back the function for the progress indicator.
  /// 5. It returns the download url of the uploaded file.
  ///
  /// If the user cancels the upload, it returns null.
  ///
  /// Ask user to upload a photo or a file
  ///
  /// Call this method when the user presses the button to upload a photo or a file.
  ///
  /// This method does not handle any exception. You may handle it outisde if you want.
  ///
  /// [saveAs] is the path on the Firebase storage to save the uploaded file.
  /// If it's empty, it willl save the file under "/users/$uid/". You can use
  /// this option to save the file under a different path.
  ///
  /// [photoCamera] is a flag to allow the user to choose the camera as the image source.
  ///
  /// [photoGallery] is a flag to allow the user to choose the gallery as the image source.
  ///
  /// [videoCamera] is a flag to allow the user to choose the camera as the video source.
  ///
  /// [videoGallery] is a flag to allow the user to choose the gallery as the video source.
  ///
  ///
  /// [fromGallery] is a flag to allow the user to choose the gallery as the file source.
  ///
  /// [fromFile] is a flag to allow the user to choose the storage as the file source.
  ///
  /// [maxHeight] is the maximum height of the image to upload.
  ///
  /// [maxWidth] is the maximum width of the image to upload.
  ///
  /// If specified, the images will be at most [maxWidth] wide and
  /// [maxHeight] tall. Otherwise the images will be returned at it's
  /// original width and height.
  ///
  /// The image compression quality is no longer supported. For using image
  /// thumbnail, refer to README.md
  ///
  /// It returns the download url of the uploaded file.
  Future<String?> upload({
    required BuildContext context,
    Function(double)? progress,
    Function()? complete,
    Function(SourceType?)? onUploadSourceSelected,
    String? saveAs,
    bool? photoCamera = true,
    bool? photoGallery = true,
    bool? videoCamera = false,
    bool? videoGallery = false,
    bool? fromGallery = false,
    bool? fromFile = false,
    double? spacing,
    EdgeInsetsGeometry? padding,
    double maxHeight = 1024,
    double maxWidth = 1024,
    int imageQuality = 95,
  }) async {
    final source = await chooseUploadSource(
      context: context,
      photoCamera: photoCamera,
      photoGallery: photoGallery,
      videoCamera: videoCamera,
      videoGallery: videoGallery,
      fromGallery: fromGallery,
      fromFile: fromFile,
      spacing: spacing,
      padding: padding,
    );
    onUploadSourceSelected?.call(source);
    if (context.mounted) {
      return await uploadFrom(
        context: context,
        source: source,
        progress: progress,
        complete: complete,
        saveAs: saveAs,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        imageQuality: imageQuality,
      );
    }
    return null;
  }

  /// Upload a file (or an image) and save the url at the field reference in Database.
  ///
  /// It can be any field of any document as long as it has permission.
  ///
  /// Logic
  /// 1. Upload
  /// 2. Save url at the path
  /// 3. Delete the previously existing upload (if there is an exsiting url in the field)
  ///
  /// [ref] is the document reference to save the url.
  ///
  /// example:
  /// ```dart
  /// await StorageService.instance.uploadAt(
  ///   context: context,
  ///   ref: my.ref,
  ///   filed: 'photoUrl',
  /// );
  /// ```
  Future<String?> uploadAt({
    required BuildContext context,
    required DatabaseReference ref,
    Function(double)? progress,
    Function()? complete,
    String? saveAs,
    bool photoCamera = true,
    bool photoGallery = true,
    double maxHeight = 1024,
    double maxWidth = 1024,
    int imageQuality = 95,
    double? spacing,
    EdgeInsetsGeometry? padding,
  }) async {
    String? oldUrl;
    String? url;

    /// Get the previous url
    final snapshot = await ref.get();
    if (snapshot.exists) {
      oldUrl = snapshot.value as String?;
    }

    if (context.mounted == false) return null;

    if (context.mounted) {
      url = await upload(
        context: context,
        progress: progress,
        complete: complete,
        saveAs: saveAs,
        photoCamera: photoCamera,
        photoGallery: photoGallery,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        imageQuality: imageQuality,
        spacing: spacing,
        padding: padding,
      );
    }

    /// If the upload is canceled, return null
    if (url == null) return null;

    /// Upload success, update the field
    ref.set(url);

    /// Delete old url
    ///
    if (oldUrl != null) {
      await delete(oldUrl);
    }
    return url;
  }

  /// Call this if method of uploading (like, from camera) is already known.
  ///
  /// [source] can be SourceType.photoGallery, SourceType.photoCamera,
  /// SourceType.videoGallery, SourceType.videoCamera, SourceType.file
  /// may return null if [source] is invalid.
  Future<String?> uploadFrom({
    required BuildContext context,
    required SourceType? source,
    Function(double)? progress,
    Function? complete,
    String? saveAs,
    String? type,
    double maxHeight = 1024,
    double maxWidth = 1024,
    int imageQuality = 95,
  }) async {
    if (source == null) return null;
    String? path = await getFilePathFromPicker(
      context: context,
      source: source,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
    );
    if (path == null) return null;
    return await uploadFile(
      path: path,
      saveAs: saveAs,
      progress: progress,
      complete: complete,
      type: type,
    );
  }

  Future<String?> getFilePathFromPicker({
    required BuildContext context,
    required SourceType? source,
    double maxHeight = 1024,
    double maxWidth = 1024,
    int imageQuality = 95,
  }) async {
    if (source == null) return null;

    try {
      if (source == SourceType.photoCamera) {
        final XFile? image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxHeight: maxHeight,
          maxWidth: maxWidth,
          imageQuality: imageQuality,
        );
        return image?.path;
      } else if (source == SourceType.photoGallery) {
        final XFile? image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        return image?.path;
      } else if (source == SourceType.videoCamera) {
        final XFile? video =
            await ImagePicker().pickVideo(source: ImageSource.camera);
        return video?.path;
      } else if (source == SourceType.videoGallery) {
        final XFile? video =
            await ImagePicker().pickVideo(source: ImageSource.gallery);
        return video?.path;
      } else if (source == SourceType.mediaGallery) {
        final XFile? image = await ImagePicker().pickMedia();
        return image?.path;
      } else if (source == SourceType.file) {
        final FilePickerResult? result = await FilePicker.platform.pickFiles();
        return result?.files.first.path;
      }
      return null;
    } on PlatformException catch (error) {
      if (enableFilePickerExceptionHandler == false) rethrow;

      if (error.code == 'photo_access_denied') {
        // errorToast(
        //   context: context,
        //   title: Text('Gallery Access Denied'),
        //   message: Text('Access permission to the gallery has been denied'.t),
        // );
        throw 'Access permission to the gallery has been denied';
      } else if (error.code == 'camera_access_denied') {
        // errorToast(
        //   context: context,
        //   title: Text('Camera Access Denied'),
        //   message: Text('Access permission to the Camera has been denied'),
        // );
        throw 'Access permission to the Camera has been denied';
      } else {
        /// rethrow the unhandled error from PlatformException if there's any
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String?>?> uploadMultiple({
    Function(double)? progress,
    Function? complete,
    String? type,
    double maxHeight = 1024,
    double maxWidth = 1024,
  }) async {
    final pickedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 100,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
    );
    List<XFile> xFilePicks = pickedFiles;

    if (xFilePicks.isEmpty) return null;
    List<Future<String?>> uploads = [];
    for (XFile xFilePick in xFilePicks) {
      uploads.add(uploadFile(
        path: xFilePick.path,
        progress: progress,
        complete: complete,
        type: type,
      ));
    }
    return Future.wait(uploads);
  }

  /// 여러 이미지를 화면에 보여준다.
  ///
  // showUploads(BuildContext context, List<String> urls, {int index = 0}) {
  //   // if (customize.showUploads != null) {
  //   //   return customize.showUploads!(context, urls, index: index);
  //   // }
  //   showGeneralDialog(
  //     context: context,
  //     pageBuilder: (context, _, __) =>
  //         DefaultImageCarouselScaffold(urls: urls, index: index),
  //   );
  // }

  // Future<List<String>> getAllImagesUrl(String uid) async {
  //   List<String> imageUrls = [];

  //   Reference storageRef =
  //       FirebaseStorage.instance.ref().child('users').child(uid);
  //   ListResult result = await storageRef.listAll();

  //   for (Reference ref in result.items) {
  //     String downloadUrl = await ref.getDownloadURL();
  //     imageUrls.add(downloadUrl);
  //   }

  //   return imageUrls;
  // }
}

/// General Upload Icon Button
///
/// This widget is displaying an IconButton and is used to upload an image,
/// video, or file.
///
/// You can change the following `photoCamera,photoGallery,videoCamera,videoGallery,fromGallery,fromFile` upload source property
/// with bool value true/false if you want to limit the upload source.
///
/// Or Simply use the following named constructor to:
///
/// Upload specific types of files you can use the name constructor:
/// [UploadIconButton.image], [UploadIconButton.video],  [UploadIconButton.file].
///
/// The [onUpload] function is called when the upload is complete.
///
/// If [photoGallery] is set to true, it will get only photos from gallery.
///
/// If [videoGallery] is set to true, it will get only videos from gallery.
///
/// If [photoCamera] is set to true, it will get only photos from camera.
///
/// If [videoCamera] is set to true, it will get only videos from camera.
///
/// If [fromGallery] is set to true, it will get whatever from Gallery.
/// It can be any file like image, pdf, zip, video, audio, etc.
///
/// If [fromFile] is set to true, it will get whatever from file storage(Not from gallery).
/// It can be any file like image, pdf, zip, video, audio, etc.
class UploadIconButton extends StatelessWidget {
  const UploadIconButton({
    super.key,
    required this.onUpload,
    this.onUploadSourceSelected,
    this.photoCamera = true,
    this.photoGallery = true,
    this.videoCamera = true,
    this.videoGallery = true,
    this.fromGallery = true,
    this.fromFile = true,
    this.progress,
    this.complete,
    this.icon = const Icon(Icons.add),
    this.iconSize,
    this.visualDensity,
    this.iconPadding,
    this.uploadBottomSheetPadding,
    this.uploadBottomSheetSpacing,
  });

  final void Function(String url) onUpload;
  final void Function(SourceType?)? onUploadSourceSelected;

  final Widget icon;
  final Function(double)? progress;
  final Function()? complete;
  final VisualDensity? visualDensity;

  final bool photoCamera;
  final bool photoGallery;

  final bool videoCamera;
  final bool videoGallery;

  final bool fromGallery;
  final bool fromFile;

  final double? iconSize;
  final EdgeInsetsGeometry? iconPadding;
  final EdgeInsetsGeometry? uploadBottomSheetPadding;
  final double? uploadBottomSheetSpacing;

  /// Upload Icon Button for Image from Galery and Camera
  const UploadIconButton.image({
    required this.onUpload,
    super.key,
    this.onUploadSourceSelected,
    this.photoCamera = true,
    this.photoGallery = true,
    this.progress,
    this.complete,
    this.icon = const Icon(
      Icons.camera_alt,
      color: Colors.black,
    ),
    this.iconSize,
    this.visualDensity,
    this.iconPadding,
    this.uploadBottomSheetPadding,
    this.uploadBottomSheetSpacing,
  })  : videoCamera = false,
        videoGallery = false,
        fromGallery = false,
        fromFile = false;

  /// Upload Icon Button for Video from Galery and Camera
  const UploadIconButton.video({
    required this.onUpload,
    super.key,
    this.onUploadSourceSelected,
    this.videoCamera = true,
    this.videoGallery = true,
    this.progress,
    this.complete,
    this.icon = const Icon(
      Icons.videocam,
      color: Colors.black,
    ),
    this.iconSize,
    this.visualDensity,
    this.iconPadding,
    this.uploadBottomSheetPadding,
    this.uploadBottomSheetSpacing,
  })  : photoCamera = false,
        photoGallery = false,
        fromGallery = false,
        fromFile = false;

  /// Upload Icon Button for files from Gallery and file storage
  const UploadIconButton.file({
    required this.onUpload,
    super.key,
    this.onUploadSourceSelected,
    this.fromGallery = true,
    this.fromFile = true,
    this.progress,
    this.complete,
    this.icon = const Icon(
      Icons.attach_file,
      color: Colors.black,
    ),
    this.iconSize,
    this.visualDensity,
    this.iconPadding,
    this.uploadBottomSheetPadding,
    this.uploadBottomSheetSpacing,
  })  : photoCamera = false,
        photoGallery = false,
        videoCamera = false,
        videoGallery = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      iconSize: iconSize,
      visualDensity: visualDensity,
      padding: iconPadding,
      onPressed: () async {
        final uploadedUrl = await StorageService.instance.upload(
          context: context,
          photoGallery: photoGallery,
          photoCamera: photoCamera,
          videoGallery: videoGallery,
          videoCamera: videoCamera,
          fromGallery: fromGallery,
          fromFile: fromFile,
          progress: progress,
          complete: complete,
          spacing: uploadBottomSheetSpacing,
          padding: uploadBottomSheetPadding,
          onUploadSourceSelected: onUploadSourceSelected,
        );
        if (uploadedUrl != null) {
          onUpload.call(uploadedUrl);
        }
      },
    );
  }
}

class StorageUploadSelectionBottomSheet extends StatelessWidget {
  const StorageUploadSelectionBottomSheet({
    super.key,
    this.photoGallery = true,
    this.photoCamera = true,
    this.videoGallery = false,
    this.videoCamera = false,
    this.fromGallery = false,
    this.fromFile = false,
    this.padding,
    this.spacing,
  });

  final bool? photoGallery;
  final bool? photoCamera;
  final bool? videoGallery;
  final bool? videoCamera;
  final bool? fromGallery;
  final bool? fromFile;
  final EdgeInsetsGeometry? padding;
  final double? spacing;

  /// if padding and uploadBottmSheetPadding is not set return `EdgeInsets.zero`
  EdgeInsetsGeometry get getPadding =>
      padding ??
      StorageService.instance.uploadBottomSheetPadding ??
      EdgeInsets.zero;

  /// if spacing and uploadBottomSheetSpacing is not set return `null`
  double? get getSpacing =>
      spacing ?? StorageService.instance.uploadBottomSheetSpacing;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: getPadding,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 48),
                Expanded(
                  child: Text(
                    'Upload from',
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButtonTheme(
                  // It should not be affected in themings because
                  // sometimes it might be wierd to have borders here.
                  data: const IconButtonThemeData(),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.cancel),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (photoGallery == true) ...[
              ListTile(
                leading: const Icon(Icons.photo),
                title: Text('Select photo from gallery'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context, SourceType.photoGallery);
                },
              ),
              if (getSpacing != null) SizedBox(height: getSpacing),
            ],
            if (photoCamera == true && !kIsWeb) ...[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text('Take photo from camera'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context, SourceType.photoCamera);
                },
              ),
              if (getSpacing != null) SizedBox(height: getSpacing),
            ],
            if (videoGallery == true) ...[
              ListTile(
                leading: const Icon(Icons.videocam),
                title: Text('Select video from gallery'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context, SourceType.videoGallery);
                },
              ),
              if (getSpacing != null) SizedBox(height: getSpacing),
            ],
            if (videoCamera == true && !kIsWeb) ...[
              ListTile(
                leading: const Icon(Icons.video_call),
                title: Text('Take video from camera'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context, SourceType.videoCamera);
                },
              ),
              if (getSpacing != null) SizedBox(height: getSpacing),
            ],
            if (fromGallery == true) ...[
              ListTile(
                leading: const Icon(Icons.file_present_rounded),
                title: Text('Take file from gallery'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context, SourceType.mediaGallery);
                },
              ),
              if (getSpacing != null) SizedBox(height: getSpacing),
            ],
            if (fromFile == true) ...[
              ListTile(
                leading: const Icon(Icons.snippet_folder_rounded),
                title: Text('Choose file'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context, SourceType.file);
                },
              ),
              if (getSpacing != null) SizedBox(height: getSpacing),
            ],
            SizedBox(height: getSpacing != null && getSpacing! >= 8 ? 8 : 16),
            TextButton(
              child: Text(
                'Close',
                // style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

enum SourceType {
  /// Opens up the device camera, letting the user to take a new picture.
  photoCamera,

  /// Opens the user's gallery to select a photo(s) and photo only.
  photoGallery,

  /// Open up the user's gallery to select a video(s) and video and some audio files only.
  videoGallery,

  /// Open up the device camera, letting the user take video from camera
  videoCamera,

  /// Open up the gallery folder for picking up any type of media
  mediaGallery,

  /// Open up file
  file,
}

Future uploadLibrary() async {
  // Add your function code here!
}
