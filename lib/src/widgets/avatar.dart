library fancy_avatar;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FancyAvatar extends StatelessWidget {

  const FancyAvatar(
      {Key? key,
        required this.radius,
        required this.image,
        this.ringColor,
        this.innerRingColor,
        this.avatarBackgroundColor,
        this.shadowColor,
        this.ringWidth = 2.0,
        this.spaceWidth = 3.0,
        this.elevation = 8.0})
      : assert(radius >= 0),
        assert(ringWidth >= 0),
        assert(spaceWidth >= 0),
        assert(elevation >= 0),
        assert(!(shadowColor != null && elevation == 0)),
        super(key: key);

  /// Total radius of the avatar. Any further width values make the avatar
  /// shrink inside of this boundary.
  final double radius;

  /// The image used in the avatar.
  final String image;

  /// The color of the outer ring around the avatar.
  ///
  /// By default this is [Colors.black]
  final Color? ringColor;

  /// The color of the inner ring - between the outer ring and avatar itself.
  ///
  /// Can be set to [Colors.transparent] in order to imitate detached effect
  /// of the outer ring and to see shadow.
  final Color? innerRingColor;

  /// The color behind the avatar. Only usefull for avatars with transparent
  /// background.
  ///
  /// By default this color is grey as [Colors.grey].
  final Color? avatarBackgroundColor;

  /// The color of the shadow that drops from the widget.
  ///
  /// This property can only be used if [elevation] property is set.
  ///
  /// By default it takes the value of [ringColor] with opacity set to 0.7
  final Color? shadowColor;

  /// The width of the outer ring.
  ///
  /// By default equals to 2.0
  final double ringWidth;

  /// The width of the 'empty' space between the avatar and the outer ring.
  ///
  /// By default equals to 3.0
  final double spaceWidth;

  /// The elevation of the widget. Affects the size and conentration of the
  /// shadow dropped behind it.
  ///
  /// By default takes a value of 8.0
  final double elevation;

  /// Builds an instance of the fancy avatar.
  ///
  /// ```dart
  /// FancyAvatar(40, Image.asset('assets/path/to/image.png'),
  /// ringColor: Colors.indigoAccent[400], spaceWidth: 4.5, elevation: 15.0)
  /// ```
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          elevation: elevation,
          shadowColor: shadowColor ?? ringColor?.withOpacity(.7),
          color: Colors.transparent,
          shape: CircleBorder(
              side: BorderSide(color: ringColor ?? Colors.black, width: ringWidth)),
          child: SizedBox(
            width: 2 * radius,
            height: 2 * radius,
            child: CircleAvatar(
              backgroundColor: innerRingColor ?? Colors.white.withOpacity(.3),
              radius: radius - 2 * ringWidth,
              child: ClipOval(
                child: DecoratedBox(
                  decoration:
                  BoxDecoration(color: avatarBackgroundColor ?? Colors.grey),
                  child: SizedBox(
                    width: 2 * radius - 2 * (spaceWidth + ringWidth),
                    height: 2 * radius - 2 * (spaceWidth + ringWidth),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) => Icon(Icons.person),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}