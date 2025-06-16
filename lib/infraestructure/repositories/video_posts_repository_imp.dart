import 'package:toktik/domain/datasources/video_post_datasource.dart';
import 'package:toktik/domain/repositories/video_post_repository.dart';
import 'package:toktik/video_post.dart';

class VideoPostsRepositoryImp implements VideoPostRepository{
  final VideoPostDatasource videosDatasource;

  VideoPostsRepositoryImp({
    required this.videosDatasource
  });

  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userID) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page) {
    return videosDatasource.getTrendingVideosByPage(page);
  }

}