import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'fullscreen.dart';

class CommentCard extends StatefulWidget {
  // final String? username;
  final String? comment;
  final String? avatar;
  final String? image;
  final String? record;
  final String? timeago;

  final String? st_name;
  final AudioPlayer? advanceplayer;
  void Function()? onLongPress;
  CommentCard({
    required this.st_name,
    required this.comment,
    required this.avatar,
    this.advanceplayer,
    this.onLongPress,
    this.record,
    this.image,
    this.timeago,
  });
  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  Duration audioDuration = new Duration();
  Duration timeprogress = new Duration();
  bool isplaying = false;

  //// bool isplaying = false;
  // bool ispaused = false;
  // bool isloop = false;
  List<IconData> _icons = [Icons.play_circle_fill, Icons.pause_circle_filled];
  @override
  void initState() {
    /*  widget.advanceplayer!.onPlayerStateChanged.listen((PlayerState s) {
      if (mounted) {
        setState(() {
          playerState = s;
        });
      }
    });*/

    if (widget.advanceplayer != null) {
      widget.advanceplayer!.onPlayerStateChanged.listen((PlayerState s) {
        if (mounted) {
          if (s == PlayerState.completed) {
            setState(() {
              isplaying = false;
            });
          } else if (s == PlayerState.playing) {
            setState(() {
              isplaying = true;
            });
          } else if (s == PlayerState.paused) {
            setState(() {
              isplaying = false;
            });
          }
        }
      });
    }

    //widget.advanceplayer!.setSourceUrl(widget.record!);
    widget.advanceplayer!.onDurationChanged.listen((Duration duration) {
      if (mounted) {
        setState(() {
          audioDuration = duration;
        });
      }
    });

    widget.advanceplayer!.onPositionChanged.listen((Duration p) {
      if (mounted) {
        setState(() {
          timeprogress = p;
        });
      }
    });

    _loadAudioSourceAndDuration();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    //  timeprogress;
    // audioDuration;
    widget.advanceplayer!.release();
  }

  playaudio() async {
    await widget.advanceplayer!.play(UrlSource(widget.record!));
  }

  pausedaudio() async {
    await widget.advanceplayer!.pause();
  }

  Future<void> _loadAudioSourceAndDuration() async {
    if (widget.record != null) {
      await widget.advanceplayer!.setSourceUrl(widget.record!);
      final audioInfo = await widget.advanceplayer!.getDuration();
      if (mounted) {
        setState(() {
          audioDuration = audioInfo ?? Duration.zero;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, bottom: 10),
      child: InkWell(
        onLongPress: widget.onLongPress,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 237, 234, 234),
          ),
          child: Row(
            children: [
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        widget.avatar == null || widget.avatar == ""
                            ? CircleAvatar()
                            : CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    NetworkImage("${widget.avatar}")),
                        Center(
                          child: Text(
                            "${widget.st_name}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    widget.comment == null || widget.comment == ""
                        ? Text("")
                        : SelectableText(
                            " ${widget.comment}",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                    widget.image == null || widget.image == ""
                        ? Container()
                        : CachedNetworkImage(
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            imageUrl: "${widget.image}",
                            imageBuilder: (context, imageProvider) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreenImagePage(
                                          imageUrl: widget.image as String),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill)),
                                ),
                              );
                            },
                          ),
                    //////////////////////////////////////////////////////////////
                    widget.record == null || widget.record == ""
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 98, 112, 240),
                                  borderRadius: BorderRadius.circular(15)),
                              height: 75,
                              width: MediaQuery.of(context).size.height,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: isplaying
                                        ? Icon(
                                            _icons[1],
                                            size: 55,
                                            color: Color.fromARGB(
                                                255, 224, 38, 22),
                                          )
                                        : Icon(
                                            _icons[0],
                                            size: 55,
                                            color:
                                                Color.fromARGB(255, 6, 176, 77),
                                          ),
                                    onPressed: () async {
                                      if (widget.advanceplayer != null) {
                                        isplaying ? pausedaudio() : playaudio();
                                      }
                                    },
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            timeprogress
                                                .toString()
                                                .split(".")[0],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            audioDuration
                                                .toString()
                                                .split(".")[0],
                                            style: TextStyle(fontSize: 15),
                                          )
                                        ],
                                      ),
                                      Slider.adaptive(
                                        min: 0.0,
                                        max: audioDuration.inSeconds.toDouble(),
                                        value:
                                            timeprogress.inSeconds.toDouble(),
                                        onChanged: (value) {
                                          if (mounted) {
                                            setState(() {
                                              seekTosec(value.toInt());
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                    Divider(),
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [Text("${widget.timeago}")],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void seekTosec(int sec) {
    Duration newpostion = Duration(seconds: sec);
    widget.advanceplayer!.seek(newpostion);
  }
}
