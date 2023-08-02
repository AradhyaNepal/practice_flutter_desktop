import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_flutter_desktop/keyboard_manager.dart';

class DisableKeyboard extends StatefulWidget {
  const DisableKeyboard({super.key});

  @override
  State<DisableKeyboard> createState() => _DisableKeyboardState();
}

class _DisableKeyboardState extends State<DisableKeyboard>
    with SingleTickerProviderStateMixin {
  bool disabledIsChecked = false;
  final _textEditingController = TextEditingController();

  late final AnimationController _animationController;
  late final Animation<Color?> _colorOne;

  Color get colorOne => _colorOne.value ?? Colors.white;

  Color get colorTwo => _colorTwo.value ?? Colors.white;
  late final Animation<Color?> _colorTwo;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )
      ..repeat(reverse: true)
      ..addListener(() {
        setState(() {});
      });
    _colorOne = ColorTween(begin: Colors.blue, end: Colors.red).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
      ),
    );
    _colorTwo = ColorTween(begin: Colors.redAccent, end: Colors.green).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = disabledIsChecked ? GoogleFonts.candal() : GoogleFonts.amaranth();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return RadialGradient(
                center: Alignment.topLeft,
                radius: 10,
                colors: <Color>[
                  colorOne,
                  colorTwo,
                  colorOne,
                  colorTwo,
                ],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: Text(
              disabledIsChecked ? "You can't use keyboard" : "You can use keyboard",
              textAlign: TextAlign.center,
              style: style.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 100,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.2,
            ),
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: "Type Anything",
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return RadialGradient(
                center: Alignment.topLeft,
                radius: 10,
                colors: <Color>[
                  colorOne,
                  colorTwo,
                  colorOne,
                  colorTwo,
                ],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: Switch(
              activeColor: Colors.blue,
              value: disabledIsChecked,
              onChanged: (value) async {
                disabledIsChecked = value;
                await KeyboardManager.blockInput(disabledIsChecked);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    ));
  }


  @override
  void dispose() {
    _textEditingController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
