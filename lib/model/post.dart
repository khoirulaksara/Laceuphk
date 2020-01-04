class Post {
  final String title;
  //final String content;
  final String imageurl;
  final int postId;

  Post(this.title, this.imageurl, this.postId){
    if (title == null) {
      throw new ArgumentError("title of Posts cannot be null. "
          "Received: '$title'");
    }
    // if (content == null) {
    //   throw new ArgumentError("content of Posts cannot be null. "
    //       "Received: '$content'");
    // }
    if (imageurl == null) {
      throw new ArgumentError("imageurl of Posts cannot be null. "
          "Received: '$imageurl'");
    }

    if (postId == null) {
      throw new ArgumentError("postId of Posts cannot be null. "
          "Received: '$postId'");
    }
  }
}