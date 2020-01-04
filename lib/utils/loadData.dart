class LoadData {
  // _loadData() async {
  //   while (_firstCatPosts.length != 0) {
  //     _firstCatPosts.removeLast();
  //   }
  //   await WordpressApi.loadURL();
  //   String dataURL =
  //       WordpressApi.firstTitleUrl.replaceAll('*', pageNumber.toString());
  //   print("URL after replace string is: " + dataURL);
  //   http.Response response = await http.get(dataURL);
  //   await _loadData2();
  //   setState(() {
  //     this._appBarTitle = Text(WordpressApi.appTitle);
  //     final postJSON = jsonDecode(response.body);
  //     for (var postJSON in postJSON) {
  //       final posts = Posts(postJSON['title'],
  //           postJSON["media"]["colormag-featured-image"], postJSON["id"]);
  //       _firstCatPosts.add(posts);
  //       reversedPosts = _firstCatPosts.reversed.toList();
  //     }
  //     _controller = PageController(initialPage: _firstCatPosts.length - 1);
  //     currentPage = _firstCatPosts.length - 1.0;
  //     _controller.addListener(() {
  //       setState(() {
  //         currentPage = _controller.page;
  //         setUI();
  //       });
  //     });
  //   });
  //   setUI();
  // }
}