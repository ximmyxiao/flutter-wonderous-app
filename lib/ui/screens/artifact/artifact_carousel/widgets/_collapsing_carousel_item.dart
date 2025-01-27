part of '../artifact_carousel_screen.dart';

/// Handles the carousel specific logic, like setting the height and vertical alignment of each item.
/// This lets the child simply render it's contents
class _CollapsingCarouselItem extends StatelessWidget {
  const _CollapsingCarouselItem(
      {Key? key,
      required this.child,
      required this.indexOffset,
      required this.width,
      required this.bottom,
      required this.onPressed,
      required this.title})
      : super(key: key);
  final Widget child;
  final int indexOffset;
  final double width;
  final double bottom;
  final VoidCallback onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    // Calculate offset, this will be subtracted from the bottom padding moving the element downwards
    double vtOffset = 0;
    if (indexOffset == 1) vtOffset = width * .1;
    if (indexOffset == 2) vtOffset = width * .4;
    if (indexOffset > 2) vtOffset = width;

    final content = AnimatedOpacity(
      duration: $styles.times.fast,
      opacity: indexOffset.abs() <= 2 ? 1 : 0,
      child: AnimatedPadding(
        duration: $styles.times.fast,
        padding: EdgeInsets.only(bottom: max(bottom - vtOffset, 0)),
        child: BottomCenter(
          child: AnimatedContainer(
            duration: $styles.times.fast,
            // Center item is portrait, the others are square
            height: indexOffset == 0 ? width * 1.5 : width,
            width: width,
            child: child,
          ),
        ),
      ),
    );
    if (indexOffset > 2) return content;
    return AppBtn.basic(onPressed: onPressed, semanticLabel: title, child: content);
  }
}

class _DoubleBorderImage extends StatelessWidget {
  const _DoubleBorderImage(this.data, {Key? key}) : super(key: key);
  final HighlightData data;
  @override
  Widget build(BuildContext context) => Container(
        // Add an outer border with the rounded ends.
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: $styles.colors.offWhite, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(999)),
        ),

        child: Padding(
          padding: EdgeInsets.all($styles.insets.xs),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: ColoredBox(
              color: $styles.colors.greyMedium,
              child: AppImage(image: NetworkImage(data.imageUrlSmall), fit: BoxFit.cover, scale: 0.5),
            ),
          ),
        ),
      );
}
