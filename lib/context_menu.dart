import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'interceptor.dart';

class ContextMenu extends StatefulWidget {
  final Widget child;

  const ContextMenu({super.key, required this.child});

  @override
  State<ContextMenu> createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  OverlayEntry? _overlayEntry;
  Offset _anchorOffset = Offset.zero;
  final LayerLink _layerLink = LayerLink();

  void _showMenu(BuildContext context, Offset globalPosition) {
    _hideMenu();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final screenSize = MediaQuery.of(context).size;
        const double menuWidth = 150;
        const double menuHeight = 150;

        final localOffset = overlay.globalToLocal(globalPosition);
        final double left = (localOffset.dx + menuWidth > screenSize.width)
            ? screenSize.width - menuWidth - 10
            : localOffset.dx;
        final double top = (localOffset.dy + menuHeight > screenSize.height)
            ? screenSize.height - menuHeight - 10
            : localOffset.dy;

        return Positioned(
          left: left,
          top: top,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: Offset.zero,
            child: Material(
              elevation: 8,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: SizedBox(
                width: menuWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: ['Create', 'Edit', 'Remove']
                      .map((text) => ListTile(
                            title: Text(text),
                            onTap: _hideMenu,
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context, rootOverlay: true)?.insert(_overlayEntry!);
  }

  void _hideMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _hideMenu();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Interceptor(
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Listener(
          onPointerDown: (PointerDownEvent event) {
            final isMouse = event.kind == PointerDeviceKind.mouse;
            final isRightClick = isMouse && (event.buttons == 2);

            final isDesktopOrWeb = kIsWeb ||
                defaultTargetPlatform == TargetPlatform.windows ||
                defaultTargetPlatform == TargetPlatform.macOS ||
                defaultTargetPlatform == TargetPlatform.linux;

            if (isDesktopOrWeb && isRightClick) {
              _showMenu(context, event.position);
            } else {
              _hideMenu();
            }
          },
          child: widget.child,
        ),
      ),
    );
  }
}







