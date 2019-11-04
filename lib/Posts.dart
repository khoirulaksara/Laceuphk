class Posts{
  final String title;
  //final String content;
  final String imageurl;

  Posts(this.title, this.imageurl){
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
  }
}