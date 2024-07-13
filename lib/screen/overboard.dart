import 'dart:math';
import 'package:junior_journey/config/constant.dart';
import 'package:junior_journey/data/circular_clipper.dart';
import 'package:junior_journey/model/page_modal.dart';
import 'package:junior_journey/data/cache_image_network.dart';
import 'package:flutter/material.dart';

enum SwipeDirection { leftToRight, rightToLeft, skipToLast }

class OverBoard extends StatefulWidget {
  final List<PageModel> pages;
  final Offset? center;
  final bool? showBullets;
  final VoidCallback finishCallback;
  final VoidCallback? skipCallback;
  final String? skipText, nextText, finishText;

  const OverBoard({
    Key? key,
    required this.pages,
    this.center,
    this.showBullets,
    this.skipText,
    this.nextText,
    this.finishText,
    required this.finishCallback,
    this.skipCallback,
  }) : super(key: key);

  @override
  OverBoardState createState() => OverBoardState();
}

class OverBoardState extends State<OverBoard> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  final ScrollController scrollController = ScrollController();
  double bulletPadding = 5.0;
  double bulletSize = 10.0;
  double bulletContainerWidth = 0.0;
  int counter = 0;
  int last = 0;
  int total = 0;
  double initial = 0, distance = 0;
  Random random = Random();
  SwipeDirection _swipeDirection = SwipeDirection.rightToLeft;

  @override
  void initState() {
    super.initState();

    // initialize a animation with duration
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // initialize with Curved Animation
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    // totoal page length
    total = widget.pages.length;

    _animate();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (DragStartDetails details) {
        ">>>>>>>>>>Pan Start Called".logIt;
        initial = details.globalPosition.dx;
        ">>>>>>>>>>Initilaize Position : $initial".logIt;
      },
      onPanUpdate: (DragUpdateDetails details) {
        ">>>>>>>>>>Pan update Called".logIt;
        distance = details.globalPosition.dx - initial;
        ">>>>>>>>>>Update  Position : ${details.globalPosition.dx}".logIt;
      },
      onPanEnd: (DragEndDetails details) {
        ">>>>>>>>>>Pan End Called".logIt;
        initial = 0.0;
        setState(() {
          last = counter;
        });
        if (distance > 1 && counter > 0) {
          setState(() {
            counter--;
            _swipeDirection = SwipeDirection.leftToRight;
          });
          _animate();
        } else if (distance < 0 && counter < total - 1) {
          setState(() {
            counter++;
            _swipeDirection = SwipeDirection.rightToLeft;
          });
          _animate();
        }
      },
      child: Stack(
        children: <Widget>[
          _getPage(last),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return ClipOval(
                clipper: CircularClipper(animation.value, widget.center),
                child: _getPage(counter),
              );
            },
            child: Container(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Opacity(
                  opacity: (counter < total - 1) ? 1.0 : 0.0,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) => PRIMARY_COLOR,
                      ),
                    ),
                    onPressed: (widget.skipCallback ?? _skip),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(widget.skipText ?? "SKIP"),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(child: LayoutBuilder(
                    builder: (context, constraints) {
                      bulletContainerWidth = constraints.maxWidth - 40.0;
                      return Container(
                        padding: const EdgeInsets.all(20.0),
                        child: ((widget.showBullets ?? true)
                            ? SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                controller: scrollController,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    for (int i = 0; i < total; i++)
                                      Padding(
                                        padding: EdgeInsets.all(bulletPadding),
                                        child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 150),
                                            height: bulletSize,
                                            width: (i == counter)
                                                ? bulletSize * 2
                                                : bulletSize,
                                            decoration: BoxDecoration(
                                                color: (i == counter)
                                                    ? PRIMARY_COLOR
                                                    : Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      )
                                  ],
                                ),
                              )
                            : Container()),
                      );
                    },
                  )),
                ),
                (counter < total - 1
                    ? TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) => PRIMARY_COLOR,
                          ),
                        ),
                        onPressed: _next,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(widget.nextText ?? "NEXT"),
                        ))
                    : TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) => PRIMARY_COLOR,
                          ),
                        ),
                        onPressed: widget.finishCallback,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(widget.finishText ?? "FINISH"),
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getPage(index) {
    PageModel page = widget.pages[index];
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: page.color,
      child: page.child != null
          ? Center(
              child: page.doAnimateChild!
                  ? AnimatedBoard(
                      animation: animation,
                      child: page.child,
                    )
                  : page.child,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                page.doAnimateImage!
                    ? AnimatedBoard(
                        animation: animation,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: (page.imageAssetPath != null)
                              ? Image.asset(
                                  page.imageAssetPath!,
                                  width: 300.0,
                                  height: 300.0,
                                )
                              : buildCacheNetworkImage(
                                  width: 300,
                                  height: 300,
                                  url: page.imageFromUrl,
                                  plColor: Colors.transparent,
                                ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: (page.imageAssetPath != null)
                            ? Image.asset(
                                page.imageAssetPath!,
                                width: 300.0,
                                height: 300.0,
                              )
                            : buildCacheNetworkImage(
                                width: 300,
                                height: 300,
                                url: page.imageFromUrl,
                                plColor: Colors.transparent,
                              ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 30.0,
                    left: 30.0,
                    right: 30.0,
                  ),
                  child: Text(
                    page.title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 75.0,
                    left: 30.0,
                    right: 30.0,
                  ),
                  child: Text(
                    page.body!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: SOFT_GREY,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  _next() {
    setState(() {
      _swipeDirection = SwipeDirection.rightToLeft;
      last = counter;
      counter++;
    });
    _animate();
  }

  _skip() {
    setState(() {
      _swipeDirection = SwipeDirection.skipToLast;
      last = counter;
      counter = total - 1;
    });
    _animate();
  }

  _animate() {
    controller.forward(from: 0.0);

    double bulletDimension = (bulletPadding * 2) + (bulletSize);
    double scroll = bulletDimension * counter;
    double maxScroll = bulletDimension * total - 1;
    if (scroll > bulletContainerWidth &&
        _swipeDirection == SwipeDirection.rightToLeft) {
      double scrollDistance =
          (((scroll - bulletContainerWidth) ~/ bulletDimension) + 1) *
              bulletDimension;

      scrollController.animateTo(
        scrollDistance,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 100),
      );
    } else if (scroll < (maxScroll - bulletContainerWidth) &&
        _swipeDirection == SwipeDirection.leftToRight) {
      scrollController.animateTo(
        scroll,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 100),
      );
    } else if (_swipeDirection == SwipeDirection.skipToLast) {
      scrollController.animateTo(
        maxScroll,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 100),
      );
    }
  }
}

class AnimatedBoard extends StatelessWidget {
  final Widget? child;
  final Animation? animation;

  const AnimatedBoard({Key? key, this.animation, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(
        0.0,
        50.0 * (1.0 - animation!.value),
        0.0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: child,
      ),
    );
  }
}
