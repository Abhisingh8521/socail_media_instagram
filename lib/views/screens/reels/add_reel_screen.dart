import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kriscent_assignment/views/utils/extensions/widget_extensions.dart';
import 'package:video_player/video_player.dart';

import '../../../controllers/reel/reel_controller.dart';
import '../../../models/reels/reel_model.dart';
import 'post_widgets.dart';

class AddReelScreen extends StatefulWidget {
  @override
  _AddReelScreenState createState() => _AddReelScreenState();
}

class _AddReelScreenState extends State<AddReelScreen> {
  final ImagePicker _picker = ImagePicker();
  VideoPlayerController? _controller;
  File? _videoFile;
  TextEditingController captionController = TextEditingController();

  Future<void> _pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
        _controller = VideoPlayerController.file(_videoFile!)
          ..initialize().then((_) {
            setState(() {});
            _controller!.play();
          });
      });
    }
  }

  @override
  void initState() {
    _pickVideo();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  var searchArray = <String>[];

  @override
  Widget build(BuildContext context) {
    var view = PostWidgets(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Reel"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Expanded(child:InkWell(
             onTap: (){
               _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
             },
             child:   _videoFile == null
                 ? const Text('No video selected.')
                 : _controller != null && _controller!.value.isInitialized
                 ? AspectRatio(
               aspectRatio: _controller!.value.aspectRatio,
               child: VideoPlayer(_controller!),
             )
                 : Center(child: CircularProgressIndicator()),
           )),
            view.sendPost(()async{
              if(_videoFile != null && captionController.text.isNotEmpty){
                await ReelController().postMedia(File(_videoFile!.path),
                        (data) async {
                      var link = await data.ref.getDownloadURL();
                      var currentUser = FirebaseAuth.instance.currentUser?.uid;
                      var id = DateTime.now().microsecondsSinceEpoch.toString();
                      var date = DateTime.now().toString();
                      for (int i = 1; i <= captionController.text.length; i++) {
                        searchArray.add(captionController.text.substring(0,i));
                      }
                      await ReelController()
                          .addPost(ReelModel(
                          id: id,
                          caption: captionController.text.trim(),
                          postBy: currentUser,
                          createdAt: date,
                          reelUrl: link,
                        searchArray: searchArray
                      )).then((_)async{
                        await ReelController().addNewPost(id, currentUser??"");
                      });
                    });
                // LoaderBuilder(context: context).dismissLoader();
              }
            }, captionController).paddingAll(10)
          ],
        ),
      ),
    );
  }
}