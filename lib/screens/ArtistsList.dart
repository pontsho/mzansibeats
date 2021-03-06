import 'package:mzansibeats/Animations/transitions.dart';
import 'package:mzansibeats/Models/PlayListHelper.dart';
import 'package:mzansibeats/models/PlaylistRepo.dart';
import 'package:mzansibeats/models/ThemeModel.dart';
import 'package:mzansibeats/models/BookmarkModel.dart';
import 'package:mzansibeats/models/const.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:mzansibeats/models/SongsModel.dart';
import 'package:mzansibeats/screens/artists.dart';
import 'package:mzansibeats/util/AAppBar.dart';
import 'package:mzansibeats/util/showStatus.dart';
import '../custom_icons.dart';
import 'package:provider/provider.dart';
import 'Player.dart';

double height, width;

class ArtistsList extends StatelessWidget {
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
                              title: "Artists",
                              isBack: true,
                              height: height,
                              width: width),
                        )
                      ],
                  body: Stack(
                    children: <Widget>[
                      Artists(model.db),
                      Align(
                        alignment: Alignment.bottomLeft,
                          child: ShowStatus(model, height, width, context)
                      )
                    ],
                  ))),
      onWillPop: () {},
    );
  }
  
  getImage(model, pos) {
    if (model.songs[pos].albumArt != null) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:
              Image.file(File.fromUri(Uri.parse(model.songs[pos].albumArt))));
    } else {
      return Container(
          child: IconButton(
            onPressed: null,
            icon: Icon(
              Icons.music_note,
              color: Colors.white,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            // Box decoration takes a gradient
            gradient: LinearGradient(
              colors: <Color>[
                themeChanger.accentColor,
                Color(0xFF1976D2),
                Color(0xFF42A5F5),
              ],
            ),
          ));
    }
  }

  push(context) {
    Navigator.push(context, SlideRightRoute(page: PlayBackPage()));
  }
}
