import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:toktik/presentation/widgets/video/video_background.dart';
import 'package:video_player/video_player.dart';

class FullscreenPlayer extends StatefulWidget {

  final String videoUrl;
  final String caption;

  const FullscreenPlayer({
    super.key,
    required this.videoUrl,
    required this.caption
  });

  @override
  State<FullscreenPlayer> createState() => _FullScreenPlayerState();
}


class _FullScreenPlayerState extends State<FullscreenPlayer>{
  late VideoPlayerController  controller;
  late Future<void> _initializeVideoPlayerFuture;
  
  @override
  void initState() {

    super.initState();

    controller = VideoPlayerController.asset(widget.videoUrl);
    _initializeVideoPlayerFuture = controller.initialize().then((_){
      controller.setVolume(10);
      controller.setLooping(true);
      controller.play();
    });
    

  }
   @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context){

    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context,snapshot){
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator(strokeWidth: 2,));  
        }
        return GestureDetector(
          onTap: (){
            if (controller.value.isPlaying) {
              controller.pause();
            }
            else{
              controller.play();
            }
            
          },
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(
              children: [
                VideoPlayer(controller),

                VideoBackground(stops: const[0.8,1.0]),

                Positioned(
                  bottom: 50,
                  left: 20,
                  child: _VideoCaption(caption: widget.caption))
                ])
            ),
        );
      });
  } 
}

class _VideoCaption extends StatelessWidget {
  final String caption;

  const _VideoCaption({
    super.key,
    required this.caption
  });
  @override
  Widget build(BuildContext context) {
    final size =  MediaQuery.of(context).size;
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return SizedBox(
      width: size.width * 0.6,
      child: Text(caption,maxLines: 2, style: titleStyle),
    );
  }
}