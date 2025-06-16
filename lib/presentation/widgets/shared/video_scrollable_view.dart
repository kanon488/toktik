import 'package:flutter/material.dart';
import 'package:toktik/presentation/widgets/shared/video_buttons.dart';
import 'package:toktik/presentation/widgets/video/fullscreen_player.dart';
import 'package:toktik/video_post.dart';

class VideoScrollableView extends StatelessWidget {
  final List<VideoPost> videos;

  VideoScrollableView({
    super.key,
    required this.videos
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: videos.length,
      itemBuilder: (context,index){
        final VideoPost videoPost = videos[index];

        return Stack(
          children: [
            SizedBox.expand(
              child: FullscreenPlayer(
                videoUrl: videoPost.videoUrl,
                caption: videoPost.caption),
            ),
            Positioned(
              bottom: 40,
              right: 40,
              child: VideoButtons(video: videoPost)
              )
          ],
        );
      },
    );
  }
}