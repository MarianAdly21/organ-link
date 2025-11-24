import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class AppCachedNetworkImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double borderRadius;
  final Widget? errorPlaceholder;
  final Widget? loadingPlaceholder;
  final BoxFit? boxFit;
  final int? maxWidthDiskCache;
  final int? memCacheWidth;
  final int? maxHeightDiskCache;
  final int? memCacheHeight;
  final bool enableCache;

  const AppCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.errorPlaceholder,
    this.loadingPlaceholder,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.boxFit,
    this.maxWidthDiskCache,
    this.memCacheWidth,
    this.maxHeightDiskCache,
    this.memCacheHeight,
    this.enableCache = true,
  });

  @override
  State<AppCachedNetworkImage> createState() => _AppCachedNetworkImageState();
}

class _AppCachedNetworkImageState extends State<AppCachedNetworkImage> {
  @override
  void dispose() {
    _deleteImageFromCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _checkMemory();
    return widget.imageUrl.isEmpty
        ? SizedBox(
            height: widget.height,
            width: widget.width,
            child: const _ImageErrorWidget(),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: _isSVGImage(widget.imageUrl)
                ? SvgPicture.network(
                    widget.imageUrl,
                    height: widget.height,
                    width: widget.width,
                    fit: widget.boxFit ?? BoxFit.contain,
                    placeholderBuilder: (context) =>
                        widget.loadingPlaceholder ??
                        const _ImageShimmerLoadingBuilder(),
                  )
                : CachedNetworkImage(
                    height: widget.height,
                    width: widget.width,
                    imageUrl: widget.imageUrl,
                    fit: widget.boxFit,

                    /// when enable to cache the image then
                    cacheKey: widget.enableCache ? widget.imageUrl : null,
                    maxWidthDiskCache: widget.maxWidthDiskCache,
                    memCacheWidth: widget.memCacheWidth,
                    maxHeightDiskCache: widget.maxHeightDiskCache,
                    memCacheHeight: widget.memCacheHeight,

                    // placeholder: (context, url) => Image.asset(AppAssetPaths.placeholderIcon),
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      return widget.loadingPlaceholder ??
                          const _ImageShimmerLoadingBuilder();
                    },
                    errorWidget: (context, url, error) =>
                        widget.errorPlaceholder ?? const _ImageErrorWidget(),
                  ),
          );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Helper methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Future _deleteImageFromCache() async {
    if (!widget.enableCache) {
      await CachedNetworkImage.evictFromCache(widget.imageUrl);
    }
  }

  bool _isSVGImage(String attachmentPath) {
    final String ext = attachmentPath.split(".").last.toLowerCase();
    return ext == "svg";
  }

  void _checkMemory() {
    final ImageCache imageCache = PaintingBinding.instance.imageCache;
    if (imageCache.currentSizeBytes >= 100 << 19 ||
        imageCache.currentSize >= imageCache.maximumSize) {
      imageCache.clear();
      imageCache.clearLiveImages();
    }
  }
}

class AppCachedNetworkImageProvider extends CachedNetworkImageProvider {
  final String imageUrl;

  const AppCachedNetworkImageProvider({
    required this.imageUrl,
    int? maxHeight,
    int? maxWidth,
  }) : super(imageUrl, maxHeight: maxHeight, maxWidth: maxWidth);
}

class _ImageShimmerLoadingBuilder extends StatelessWidget {
  const _ImageShimmerLoadingBuilder()
    : super(key: const ValueKey("_ImageProgressIndicatorBuilder"));

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Shimmer.fromColors(
        baseColor: AppColors.baseShimmerColor,
        highlightColor: AppColors.highlightShimmerColor,
        child: Container(
          decoration: const BoxDecoration(color: AppColors.whiteLoader),
        ),
      ),
    );
  }
}

class _ImageErrorWidget extends StatelessWidget {
  const _ImageErrorWidget() : super(key: const ValueKey("_ImageErrorWidget"));

  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      child: Center(
        child: Padding(padding: EdgeInsets.all(20.0), child: Icon(Icons.error)),
      ),
    );
  }
}
