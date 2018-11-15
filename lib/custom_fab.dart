import 'package:flutter/material.dart';

class CustomFab extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;
  final VoidCallback scanBarcodeCallback;

  CustomFab(
      {this.onPressed, this.tooltip, this.icon, this.scanBarcodeCallback});

  @override
  _CustomFabState createState() => _CustomFabState();
}

class _CustomFabState extends State<CustomFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;

  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });

    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor =
        ColorTween(begin: Colors.deepPurple, end: Colors.deepPurpleAccent)
            .animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.00, 1.00,
              curve: Interval(0.00, 1.00, curve: Curves.linear))),
    );
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.75, curve: _curve)));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  //This is returns a widget for the toggle Fab
  Widget toggle() {
    return FloatingActionButton(
      heroTag: "toggle",
      backgroundColor: _animateColor.value,
      onPressed: animate,
      tooltip: "Toggle",
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
      ),
    );
  }

  //This is returns a widget for the scan barcode Fab
  Widget scanWithBarcode() {
    return new Container(
      child: new FloatingActionButton(
        heroTag: "scan_barcode",
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: _onScanWithBarcodeClicked,
        tooltip: "Scan With Barcode",
        child: new Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
      ),
    );
  }

  //This is returns a widget for the add to cart Fab
  Widget addToCart() {
    return new Container(
      child: new FloatingActionButton(
        heroTag: "Add_to_cart",
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: _onAddToCartClicked,
        tooltip: "Add To Cart",
        child: new Icon(
          Icons.add_shopping_cart,
          color: Colors.white,
        ),
      ),
    );
  }

  _onScanWithBarcodeClicked() {
    widget.scanBarcodeCallback();
  }

  _onAddToCartClicked() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform:
              Matrix4.translationValues(0.0, _translateButton.value * 2.0, 0.0),
          child: scanWithBarcode(),
        ),
        Transform(
          transform:
              Matrix4.translationValues(0.0, _translateButton.value, 0.0),
          child: addToCart(),
        ),
        toggle(),
      ],
    );
  }
}
