import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class uploadImage {
  bool isImageTaken = false;
  String imagePath = '';
  String mediaurl = '';

  Future<void> openCamera() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      imagePath = image.path;
      isImageTaken = true;
    }
  }

  Future<void> uploadimage(BuildContext context) async {
    final File file = File(imagePath);
    final FirebaseStorage storage = FirebaseStorage.instance;
    final Reference reference =
        storage.ref().child('images/${DateTime.now()}.jpg');

    try {
      mediaurl = await reference.putFile(file).toString();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded to Firebase Storage!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image. Please try again.')));
    }
  }
}

class uploadVideo {
  bool isvideoTaken = false;
  String videoPath = '';
  String mediaurl = '';

  Future<void> recordvideo() async {
    final imagePicker = ImagePicker();
    final video = await imagePicker.pickVideo(source: ImageSource.camera);

    if (video != null) {
      videoPath = video.path;
      isvideoTaken = true;
    }
  }

  Future<void> uploadvideo(BuildContext context) async {
    final File file = File(videoPath);
    final FirebaseStorage storage = FirebaseStorage.instance;
    final Reference reference =
        storage.ref().child('videos/${DateTime.now()}.mp4');

    try {
      mediaurl = await reference.putFile(file).toString();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded to Firebase Storage!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image. Please try again.')));
    }
  }
}

class uploadAudio extends GetxController {
  String mediaurl = '';

  bool isInitialized = false;
  String? pathToAudio = 'audio${DateTime.now()}.wav';
  final Codec _codec = Codec.aacMP4;
  FlutterSoundRecorder? _flutterSoundRecorder;
  var isRecording = false.obs;

  void startRecording() async {
    String fileName = 'my_audio.wav';
    if (isInitialized) {
      print('.... recording');
      isRecording.value = true;
      await _flutterSoundRecorder!.startRecorder(
        toFile: fileName,
        codec: Codec.pcm16WAV, // Specify the desired audio codec
      );
    } else {
      await init();
      print('.... recording');
      isRecording.value = true;
      //await _flutterSoundRecorder!.startRecorder(toFile: pathToAudio);
      await _flutterSoundRecorder!.startRecorder(
        toFile: fileName,
        codec: Codec.pcm16WAV, // Specify the desired audio codec
      );
    }
  }

  void stopRecording() async {
    if (isInitialized) {
      await _flutterSoundRecorder!.stopRecorder().then((value) => {pathToAudio = value});
      isRecording.value = false;

    } else {
      await init();
      await _flutterSoundRecorder!.stopRecorder().then((value) => {pathToAudio = value});
      isRecording.value = false;
    }
  }

  Future init() async {
    _flutterSoundRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Permission was denid');
    }
    await _flutterSoundRecorder!.openRecorder();
    // pathToAudio = await _flutterSoundRecorder!.get();
    isInitialized = true;
  }

  @override
  void dispose() {
    _flutterSoundRecorder!.closeRecorder();
    _flutterSoundRecorder = null;
    isInitialized = false;
    super.dispose();
  }

  Future<void> uploadaudio(BuildContext context) async {
    final File file = File(pathToAudio!);
    final FirebaseStorage storage = FirebaseStorage.instance;
    final Reference reference =
        storage.ref().child('audios/${DateTime.now()}.mp3');

    try {
      mediaurl = await reference.putFile(file).toString();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded to Firebase Storage!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image. Please try again.')));
    }
  }
}
