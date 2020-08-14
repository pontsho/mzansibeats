import 'package:mzansibeats/models/ThemeModel.dart';
import 'package:mzansibeats/models/BookmarkModel.dart';
import 'package:flutter/material.dart';
import 'package:mzansibeats/models/SongsModel.dart';
import 'package:mzansibeats/pages/PlaylistsWidget.dart';
import 'package:mzansibeats/util/AAppBar.dart';
import 'package:mzansibeats/util/showStatus.dart';
import '../custom_icons.dart';
import 'package:provider/provider.dart';

double height, width;

class PlayList extends StatelessWidget {
  TextEditingController editingController;

  SongsModel model;

  BookmarkModel b;

  ThemeChanger themeChanger;

  TextEditingController txt = TextEditingController();

  bool error = false;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    b = Provider.of<BookmarkModel>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    themeChanger = Provider.of<ThemeChanger>(context);
    return WillPopScope(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).backgroundColor,
          body: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        SliverSafeArea(
                          top: false,
                          sliver: MzansiAppBar(
                              title: "Playlists",
                              isBack: true,
                              height: height,
                              width: width),
                        )
                      ],
                  body: Stack(
                    children: <Widget>[
                      PlaylistWidget(model.db),
                      Align(
                        alignment: Alignment.bottomLeft,
                          child: ShowStatus(model, height, width, context)
                      )
                    ],
                  ))),
      onWillPop: () {},
    );
  }


}
