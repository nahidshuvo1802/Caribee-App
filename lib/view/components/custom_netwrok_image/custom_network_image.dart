import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final Border? border;
  final BorderRadius? borderRadius;
  final BoxShape boxShape;
  final Color? backgroundColor;
  final Widget? child;
  final ColorFilter? colorFilter;
  final List<BoxShadow>? boxShadow; // 🟢 Added boxShadow parameter

  const CustomNetworkImage({
    super.key,
    this.child,
    this.colorFilter,
    required this.imageUrl,
    this.backgroundColor,
    required this.height,
    required this.width,
    this.border,
    this.borderRadius,
    this.boxShape = BoxShape.rectangle,
    this.boxShadow, // 🟢 Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
          borderRadius: borderRadius,
          shape: boxShape,
          color: backgroundColor,
          boxShadow: boxShadow, // 🟢 Applied shadow
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: colorFilter,
          ),
        ),
        child: child,
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.6), // Updated for compatibility
        highlightColor: Colors.grey.withOpacity(0.3),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: border,
            color: Colors.grey.withOpacity(0.6),
            borderRadius: borderRadius,
            shape: boxShape,
            boxShadow: boxShadow, // 🟢 Applied shadow to placeholder
          ),
          child: child,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
          color: Colors.grey.withOpacity(0.6),
          borderRadius: borderRadius,
          shape: boxShape,
          boxShadow: boxShadow, // 🟢 Applied shadow to error widget
        ),
        child: const Icon(Icons.error),
      ),
    );
  }
}

class CustomNetworkImage2 extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final Border? border;
  final BoxShape boxShape;
  final Color? backgroundColor;
  final Widget? child;
  final ColorFilter? colorFilter;
  final List<BoxShadow>? boxShadow; // 🟢 Added parameter

  const CustomNetworkImage2({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.child,
    this.colorFilter,
    this.backgroundColor,
    this.border,
    this.boxShape = BoxShape.rectangle,
    this.boxShadow, // 🟢 Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: border,
            shape: boxShape,
            color: backgroundColor,
            boxShadow: boxShadow, // 🟢 Applied shadow
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.contain,
              colorFilter: colorFilter,
            ),
          ),
          child: child,
        ),
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.6),
          highlightColor: Colors.grey.withOpacity(0.3),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              border: border,
              color: Colors.grey.withOpacity(0.6),
              shape: boxShape,
              boxShadow: boxShadow, // 🟢 Applied shadow
            ),
            child: child,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: border,
            color: Colors.grey.withOpacity(0.6),
            shape: boxShape,
            boxShadow: boxShadow, // 🟢 Applied shadow
          ),
          child: const Icon(Icons.error),
        ),
      ),
    );
  }
}