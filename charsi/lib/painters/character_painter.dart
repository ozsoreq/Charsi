import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/character_model.dart';

class CharacterPainter extends CustomPainter {
  final OutfitConfig outfit;
  final Gender gender;

  CharacterPainter({required this.outfit, required this.gender});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Proportions (relative to height)
    final headR = h * 0.11;
    final headCX = w * 0.5;
    final headCY = h * 0.195;

    final neckTop = headCY + headR * 0.75;
    final neckBot = headCY + headR * 1.35;
    final neckW = headR * 0.38;

    final shoulderY = neckBot;
    final bodyBot = shoulderY + h * 0.22;
    final hipW = headR * 1.55;
    final shoulderW = headR * 1.45;

    final legTop = bodyBot;
    final legBot = legTop + h * 0.25;
    final legW = headR * 0.36;
    final legGap = headR * 0.22;

    final footH = headR * 0.22;
    final footW = headR * 0.52;

    // Shadow
    _drawShadow(canvas, w * 0.5, legBot + footH + 4, headR * 1.4);

    // Back hair (behind head)
    _drawBackHair(canvas, headCX, headCY, headR, outfit.hairColor, outfit.hairStyle, gender);

    // Legs
    _drawLegs(canvas, headCX, legTop, legBot, legW, legGap, outfit.skinColor);

    // Shoes
    _drawShoes(canvas, headCX, legBot, footH, footW, legGap, outfit.shoesStyle, outfit.shoesColor);

    // Pants (if applicable)
    if (outfit.pantsStyle != PantsStyle.none) {
      _drawPants(canvas, headCX, legTop, legBot, legW, legGap, outfit.pantsStyle, outfit.pantsColor);
    }

    // Body base (skin for arms/torso)
    _drawBody(canvas, headCX, shoulderY, bodyBot, shoulderW, hipW, outfit.skinColor);

    // Arms
    _drawArms(canvas, headCX, shoulderY, bodyBot, shoulderW, headR, outfit.skinColor);

    // Clothing
    if (outfit.dressStyle != DressStyle.none) {
      _drawDress(canvas, headCX, shoulderY, legBot, shoulderW, outfit.dressStyle, outfit.dressColor);
    } else if (outfit.topStyle != TopStyle.none) {
      _drawTop(canvas, headCX, shoulderY, bodyBot, shoulderW, hipW, outfit.topStyle, outfit.topColor);
    }

    // Neck
    _drawNeck(canvas, headCX, neckTop, neckBot, neckW, outfit.skinColor);

    // Head
    _drawHead(canvas, headCX, headCY, headR, outfit.skinColor);

    // Face
    _drawFace(canvas, headCX, headCY, headR);

    // Front hair
    _drawFrontHair(canvas, headCX, headCY, headR, outfit.hairColor, outfit.hairStyle, gender);

    // Hat
    if (outfit.hatStyle != HatStyle.none) {
      _drawHat(canvas, headCX, headCY, headR, outfit.hatStyle, outfit.hatColor);
    }
  }

  void _drawShadow(Canvas canvas, double cx, double y, double rx) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, y), width: rx * 2.2, height: rx * 0.4), paint);
  }

  void _drawBackHair(Canvas canvas, double cx, double cy, double r, Color color, HairStyle style, Gender gender) {
    final paint = Paint()..color = color;
    if (gender == Gender.female) {
      switch (style) {
        case HairStyle.longWavy:
        case HairStyle.longStraight:
        case HairStyle.medium:
          // Long hair flowing down sides
          final path = Path();
          path.moveTo(cx - r * 0.9, cy - r * 0.3);
          path.cubicTo(cx - r * 1.7, cy + r * 0.5, cx - r * 1.5, cy + r * 2.2, cx - r * 1.0, cy + r * 3.2);
          path.lineTo(cx - r * 0.5, cy + r * 3.2);
          path.cubicTo(cx - r * 0.8, cy + r * 2.0, cx - r * 0.9, cy + r * 1.0, cx - r * 0.2, cy + r * 0.2);
          path.close();
          canvas.drawPath(path, paint);

          final pathR = Path();
          pathR.moveTo(cx + r * 0.9, cy - r * 0.3);
          pathR.cubicTo(cx + r * 1.7, cy + r * 0.5, cx + r * 1.5, cy + r * 2.2, cx + r * 1.0, cy + r * 3.2);
          pathR.lineTo(cx + r * 0.5, cy + r * 3.2);
          pathR.cubicTo(cx + r * 0.8, cy + r * 2.0, cx + r * 0.9, cy + r * 1.0, cx + r * 0.2, cy + r * 0.2);
          pathR.close();
          canvas.drawPath(pathR, paint);
          break;
        case HairStyle.bun:
          canvas.drawCircle(Offset(cx, cy - r * 1.15), r * 0.38, paint);
          break;
        default:
          break;
      }
    }
  }

  void _drawHead(Canvas canvas, double cx, double cy, double r, Color skin) {
    final paint = Paint()..color = skin;
    canvas.drawCircle(Offset(cx, cy), r, paint);
    // Slight cheek blush
    final blushPaint = Paint()..color = Colors.pink.withOpacity(0.13);
    canvas.drawCircle(Offset(cx - r * 0.52, cy + r * 0.18), r * 0.26, blushPaint);
    canvas.drawCircle(Offset(cx + r * 0.52, cy + r * 0.18), r * 0.26, blushPaint);
  }

  void _drawFace(Canvas canvas, double cx, double cy, double r) {
    // Eyes
    final eyePaint = Paint()..color = const Color(0xFF3D2B1F);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx - r * 0.32, cy + r * 0.08), width: r * 0.22, height: r * 0.25),
      eyePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + r * 0.32, cy + r * 0.08), width: r * 0.22, height: r * 0.25),
      eyePaint,
    );
    // Eye shine
    final shinePaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(cx - r * 0.27, cy + r * 0.03), r * 0.05, shinePaint);
    canvas.drawCircle(Offset(cx + r * 0.37, cy + r * 0.03), r * 0.05, shinePaint);

    // Smile
    final smilePaint = Paint()
      ..color = const Color(0xFF8B5E3C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.065
      ..strokeCap = StrokeCap.round;
    final smilePath = Path();
    smilePath.moveTo(cx - r * 0.2, cy + r * 0.38);
    smilePath.quadraticBezierTo(cx, cy + r * 0.55, cx + r * 0.2, cy + r * 0.38);
    canvas.drawPath(smilePath, smilePaint);

    // Nose (tiny dot)
    final nosePaint = Paint()..color = const Color(0xFFC49A7A);
    canvas.drawCircle(Offset(cx, cy + r * 0.25), r * 0.055, nosePaint);
  }

  void _drawFrontHair(Canvas canvas, double cx, double cy, double r, Color color, HairStyle style, Gender gender) {
    final paint = Paint()..color = color;
    if (gender == Gender.female) {
      switch (style) {
        case HairStyle.longWavy:
          // Top of head + wavy fringe
          final path = Path();
          path.moveTo(cx - r * 0.95, cy - r * 0.1);
          path.cubicTo(cx - r * 0.8, cy - r * 1.25, cx + r * 0.8, cy - r * 1.25, cx + r * 0.95, cy - r * 0.1);
          path.cubicTo(cx + r * 0.75, cy - r * 0.7, cx + r * 0.2, cy - r * 0.85, cx, cy - r * 0.55);
          path.cubicTo(cx - r * 0.2, cy - r * 0.85, cx - r * 0.75, cy - r * 0.7, cx - r * 0.95, cy - r * 0.1);
          canvas.drawPath(path, paint);
          // Cowlick
          final cowlick = Path();
          cowlick.moveTo(cx + r * 0.05, cy - r * 1.22);
          cowlick.cubicTo(cx + r * 0.25, cy - r * 1.5, cx + r * 0.35, cy - r * 1.35, cx + r * 0.1, cy - r * 1.1);
          final strokePaint = Paint()
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = r * 0.12
            ..strokeCap = StrokeCap.round;
          canvas.drawPath(cowlick, strokePaint);
          break;
        case HairStyle.longStraight:
          final path = Path();
          path.moveTo(cx - r * 0.95, cy - r * 0.1);
          path.cubicTo(cx - r * 0.9, cy - r * 1.3, cx + r * 0.9, cy - r * 1.3, cx + r * 0.95, cy - r * 0.1);
          path.cubicTo(cx + r * 0.8, cy - r * 0.6, cx, cy - r * 0.5, cx - r * 0.8, cy - r * 0.6);
          canvas.drawPath(path, paint);
          break;
        case HairStyle.bun:
          final path = Path();
          path.moveTo(cx - r * 0.9, cy - r * 0.1);
          path.cubicTo(cx - r * 0.8, cy - r * 1.1, cx + r * 0.8, cy - r * 1.1, cx + r * 0.9, cy - r * 0.1);
          path.close();
          canvas.drawPath(path, paint);
          canvas.drawCircle(Offset(cx, cy - r * 1.18), r * 0.36, paint);
          break;
        case HairStyle.shortCurly:
          final path = Path();
          path.moveTo(cx - r * 0.95, cy - r * 0.05);
          path.cubicTo(cx - r, cy - r * 1.3, cx + r, cy - r * 1.3, cx + r * 0.95, cy - r * 0.05);
          path.cubicTo(cx + r * 0.8, cy - r * 0.5, cx, cy - r * 0.45, cx - r * 0.8, cy - r * 0.5);
          canvas.drawPath(path, paint);
          // Curly bumps on top
          for (int i = -1; i <= 1; i++) {
            canvas.drawCircle(Offset(cx + i * r * 0.45, cy - r * 1.2), r * 0.22, paint);
          }
          break;
        case HairStyle.medium:
          final path = Path();
          path.moveTo(cx - r * 0.95, cy - r * 0.1);
          path.cubicTo(cx - r * 0.85, cy - r * 1.25, cx + r * 0.85, cy - r * 1.25, cx + r * 0.95, cy - r * 0.1);
          path.cubicTo(cx + r * 0.7, cy - r * 0.5, cx, cy - r * 0.48, cx - r * 0.7, cy - r * 0.5);
          canvas.drawPath(path, paint);
          break;
        default:
          break;
      }
    } else {
      // Male hair styles
      switch (style) {
        case HairStyle.shortStraight:
          final path = Path();
          path.moveTo(cx - r * 0.95, cy - r * 0.05);
          path.cubicTo(cx - r * 0.85, cy - r * 1.15, cx + r * 0.85, cy - r * 1.15, cx + r * 0.95, cy - r * 0.05);
          path.cubicTo(cx + r * 0.7, cy - r * 0.55, cx, cy - r * 0.5, cx - r * 0.7, cy - r * 0.55);
          canvas.drawPath(path, paint);
          break;
        case HairStyle.shortCurly:
          final path = Path();
          path.moveTo(cx - r * 0.95, cy - r * 0.05);
          path.cubicTo(cx - r, cy - r * 1.25, cx + r, cy - r * 1.25, cx + r * 0.95, cy - r * 0.05);
          path.close();
          canvas.drawPath(path, paint);
          for (int i = -1; i <= 1; i++) {
            canvas.drawCircle(Offset(cx + i * r * 0.42, cy - r * 1.18), r * 0.2, paint);
          }
          break;
        case HairStyle.medium:
          final path = Path();
          path.moveTo(cx - r * 0.95, cy - r * 0.05);
          path.cubicTo(cx - r * 0.85, cy - r * 1.2, cx + r * 0.85, cy - r * 1.2, cx + r * 0.95, cy - r * 0.05);
          path.cubicTo(cx + r * 0.7, cy - r * 0.5, cx, cy - r * 0.48, cx - r * 0.7, cy - r * 0.5);
          canvas.drawPath(path, paint);
          break;
        default:
          // Default short hair
          final path = Path();
          path.moveTo(cx - r * 0.9, cy - r * 0.05);
          path.cubicTo(cx - r * 0.8, cy - r * 1.1, cx + r * 0.8, cy - r * 1.1, cx + r * 0.9, cy - r * 0.05);
          path.close();
          canvas.drawPath(path, paint);
      }
    }
  }

  void _drawNeck(Canvas canvas, double cx, double top, double bot, double nw, Color skin) {
    final paint = Paint()..color = skin;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, (top + bot) / 2), width: nw * 2, height: bot - top),
        Radius.circular(nw * 0.5),
      ),
      paint,
    );
  }

  void _drawBody(Canvas canvas, double cx, double top, double bot, double sw, double hw, Color skin) {
    final paint = Paint()..color = skin;
    final path = Path();
    path.moveTo(cx - sw, top);
    path.cubicTo(cx - sw * 1.1, top + (bot - top) * 0.5, cx - hw * 0.95, bot - (bot - top) * 0.1, cx - hw, bot);
    path.lineTo(cx + hw, bot);
    path.cubicTo(cx + hw * 0.95, bot - (bot - top) * 0.1, cx + sw * 1.1, top + (bot - top) * 0.5, cx + sw, top);
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawArms(Canvas canvas, double cx, double shoulderY, double bodyBot, double sw, double r, Color skin) {
    final paint = Paint()
      ..color = skin
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.38
      ..strokeCap = StrokeCap.round;

    // Left arm
    final leftArm = Path();
    leftArm.moveTo(cx - sw * 0.85, shoulderY + (bodyBot - shoulderY) * 0.1);
    leftArm.cubicTo(
      cx - sw * 1.35, shoulderY + (bodyBot - shoulderY) * 0.4,
      cx - sw * 1.3, shoulderY + (bodyBot - shoulderY) * 0.7,
      cx - sw * 1.0, bodyBot + r * 0.2,
    );
    canvas.drawPath(leftArm, paint);

    // Right arm
    final rightArm = Path();
    rightArm.moveTo(cx + sw * 0.85, shoulderY + (bodyBot - shoulderY) * 0.1);
    rightArm.cubicTo(
      cx + sw * 1.35, shoulderY + (bodyBot - shoulderY) * 0.4,
      cx + sw * 1.3, shoulderY + (bodyBot - shoulderY) * 0.7,
      cx + sw * 1.0, bodyBot + r * 0.2,
    );
    canvas.drawPath(rightArm, paint);

    // Hands
    final handPaint = Paint()..color = skin;
    canvas.drawCircle(Offset(cx - sw * 1.0, bodyBot + r * 0.2), r * 0.22, handPaint);
    canvas.drawCircle(Offset(cx + sw * 1.0, bodyBot + r * 0.2), r * 0.22, handPaint);
  }

  void _drawLegs(Canvas canvas, double cx, double top, double bot, double lw, double gap, Color skin) {
    final paint = Paint()..color = skin;
    // Left leg
    final leftRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(cx - gap - lw * 2, top, cx - gap, bot),
      Radius.circular(lw * 0.8),
    );
    canvas.drawRRect(leftRect, paint);
    // Right leg
    final rightRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(cx + gap, top, cx + gap + lw * 2, bot),
      Radius.circular(lw * 0.8),
    );
    canvas.drawRRect(rightRect, paint);
  }

  void _drawShoes(Canvas canvas, double cx, double legBot, double fh, double fw, double gap, ShoesStyle style, Color color) {
    final paint = Paint()..color = color;
    final darkPaint = Paint()..color = Color.lerp(color, Colors.black, 0.25)!;
    final leftCx = cx - gap - fw * 0.5;
    final rightCx = cx + gap + fw * 0.5;

    switch (style) {
      case ShoesStyle.sandals:
        // Simple flat sandal
        canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(leftCx, legBot + fh * 0.5), width: fw, height: fh), Radius.circular(fh * 0.4)),
          paint,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(rightCx, legBot + fh * 0.5), width: fw, height: fh), Radius.circular(fh * 0.4)),
          paint,
        );
        // Straps
        final strapPaint = Paint()..color = darkPaint.color..strokeWidth = fh * 0.25..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
        canvas.drawLine(Offset(leftCx - fw * 0.25, legBot), Offset(leftCx + fw * 0.25, legBot), strapPaint);
        canvas.drawLine(Offset(rightCx - fw * 0.25, legBot), Offset(rightCx + fw * 0.25, legBot), strapPaint);
        break;
      case ShoesStyle.sneakers:
        // Sneaker shape
        final sPath = Path();
        sPath.moveTo(leftCx - fw * 0.5, legBot + fh);
        sPath.lineTo(leftCx + fw * 0.6, legBot + fh);
        sPath.cubicTo(leftCx + fw * 0.7, legBot + fh, leftCx + fw * 0.65, legBot, leftCx + fw * 0.4, legBot);
        sPath.lineTo(leftCx - fw * 0.3, legBot);
        sPath.cubicTo(leftCx - fw * 0.55, legBot, leftCx - fw * 0.6, legBot + fh * 0.5, leftCx - fw * 0.5, legBot + fh);
        canvas.drawPath(sPath, paint);
        final sPath2 = Path();
        sPath2.moveTo(rightCx - fw * 0.6, legBot + fh);
        sPath2.lineTo(rightCx + fw * 0.5, legBot + fh);
        sPath2.cubicTo(rightCx + fw * 0.55, legBot + fh, rightCx + fw * 0.6, legBot + fh * 0.5, rightCx + fw * 0.5, legBot);
        sPath2.lineTo(rightCx - fw * 0.4, legBot);
        sPath2.cubicTo(rightCx - fw * 0.65, legBot, rightCx - fw * 0.7, legBot, rightCx - fw * 0.6, legBot + fh);
        canvas.drawPath(sPath2, paint);
        // White sole
        final solePaint = Paint()..color = Colors.white.withOpacity(0.7);
        canvas.drawRect(Rect.fromLTRB(leftCx - fw * 0.5, legBot + fh * 0.75, leftCx + fw * 0.6, legBot + fh), solePaint);
        canvas.drawRect(Rect.fromLTRB(rightCx - fw * 0.6, legBot + fh * 0.75, rightCx + fw * 0.5, legBot + fh), solePaint);
        break;
      case ShoesStyle.boots:
        // Boot shape
        for (final bcx in [leftCx, rightCx]) {
          final bPath = Path();
          bPath.moveTo(bcx - fw * 0.4, legBot - fh * 1.2);
          bPath.lineTo(bcx + fw * 0.4, legBot - fh * 1.2);
          bPath.lineTo(bcx + fw * 0.5, legBot + fh);
          bPath.lineTo(bcx - fw * 0.5, legBot + fh);
          bPath.close();
          canvas.drawPath(bPath, paint);
        }
        break;
      case ShoesStyle.heels:
        for (final hcx in [leftCx, rightCx]) {
          final hPath = Path();
          hPath.moveTo(hcx - fw * 0.5, legBot + fh);
          hPath.cubicTo(hcx - fw * 0.2, legBot, hcx + fw * 0.3, legBot, hcx + fw * 0.5, legBot + fh * 0.2);
          hPath.lineTo(hcx + fw * 0.5, legBot + fh);
          hPath.close();
          canvas.drawPath(hPath, paint);
          // Heel
          canvas.drawRect(Rect.fromLTRB(hcx + fw * 0.3, legBot + fh * 0.5, hcx + fw * 0.5, legBot + fh), darkPaint);
        }
        break;
      case ShoesStyle.loafers:
        for (final lcx in [leftCx, rightCx]) {
          canvas.drawRRect(
            RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(lcx, legBot + fh * 0.55), width: fw * 1.1, height: fh * 0.9), Radius.circular(fh * 0.35)),
            paint,
          );
        }
        break;
      case ShoesStyle.none:
        break;
    }
  }

  void _drawPants(Canvas canvas, double cx, double top, double bot, double lw, double gap, PantsStyle style, Color color) {
    final paint = Paint()..color = color;
    final darkColor = Color.lerp(color, Colors.black, 0.15)!;
    final creaseH = (bot - top) * 0.5;

    switch (style) {
      case PantsStyle.jeans:
      case PantsStyle.chinos:
      case PantsStyle.leggings:
        // Full length pants
        canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromLTRB(cx - gap - lw * 2 - 2, top, cx - gap + 2, bot), Radius.circular(lw * 0.5)),
          paint,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromLTRB(cx + gap - 2, top, cx + gap + lw * 2 + 2, bot), Radius.circular(lw * 0.5)),
          paint,
        );
        // Crease line
        final creasePaint = Paint()..color = darkColor..strokeWidth = 1.0..style = PaintingStyle.stroke;
        canvas.drawLine(Offset(cx - gap - lw, top + creaseH * 0.2), Offset(cx - gap - lw, bot - creaseH * 0.2), creasePaint);
        canvas.drawLine(Offset(cx + gap + lw, top + creaseH * 0.2), Offset(cx + gap + lw, bot - creaseH * 0.2), creasePaint);
        // Waistband
        canvas.drawRect(Rect.fromLTRB(cx - gap - lw * 2 - 2, top, cx + gap + lw * 2 + 2, top + (bot - top) * 0.12), paint);
        break;
      case PantsStyle.shorts:
        final shortBot = top + (bot - top) * 0.42;
        canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromLTRB(cx - gap - lw * 2 - 2, top, cx - gap + 2, shortBot), Radius.circular(lw * 0.5)),
          paint,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromLTRB(cx + gap - 2, top, cx + gap + lw * 2 + 2, shortBot), Radius.circular(lw * 0.5)),
          paint,
        );
        break;
      case PantsStyle.skirt:
        final skirtBot = top + (bot - top) * 0.55;
        final skirtPath = Path();
        skirtPath.moveTo(cx - lw * 2, top);
        skirtPath.lineTo(cx + lw * 2, top);
        skirtPath.lineTo(cx + lw * 2.8, skirtBot);
        skirtPath.lineTo(cx - lw * 2.8, skirtBot);
        skirtPath.close();
        canvas.drawPath(skirtPath, paint);
        break;
      case PantsStyle.none:
        break;
    }
  }

  void _drawDress(Canvas canvas, double cx, double top, double legBot, double sw, DressStyle style, Color color) {
    final paint = Paint()..color = color;
    final flareBot = legBot - (legBot - top) * 0.05;

    switch (style) {
      case DressStyle.aLine:
      case DressStyle.sundress:
        final path = Path();
        path.moveTo(cx - sw * 0.9, top);
        path.lineTo(cx + sw * 0.9, top);
        path.cubicTo(cx + sw * 1.5, top + (flareBot - top) * 0.5, cx + sw * 1.65, flareBot - (flareBot - top) * 0.15, cx + sw * 1.55, flareBot);
        path.lineTo(cx - sw * 1.55, flareBot);
        path.cubicTo(cx - sw * 1.65, flareBot - (flareBot - top) * 0.15, cx - sw * 1.5, top + (flareBot - top) * 0.5, cx - sw * 0.9, top);
        canvas.drawPath(path, paint);
        // Heart pattern overlay
        if (style == DressStyle.aLine) {
          _drawHeartPattern(canvas, cx, top, flareBot, sw, color);
        }
        // Neckline
        final neckPath = Path();
        neckPath.moveTo(cx - sw * 0.6, top);
        neckPath.cubicTo(cx - sw * 0.3, top + (flareBot - top) * 0.06, cx + sw * 0.3, top + (flareBot - top) * 0.06, cx + sw * 0.6, top);
        final neckPaint = Paint()
          ..color = Color.lerp(color, Colors.black, 0.1)!
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawPath(neckPath, neckPaint);
        break;

      case DressStyle.ballgown:
        final path = Path();
        path.moveTo(cx - sw * 0.85, top);
        path.lineTo(cx + sw * 0.85, top);
        path.cubicTo(cx + sw * 1.2, top + (flareBot - top) * 0.35, cx + sw * 2.0, flareBot * 0.85, cx + sw * 2.1, flareBot);
        path.lineTo(cx - sw * 2.1, flareBot);
        path.cubicTo(cx - sw * 2.0, flareBot * 0.85, cx - sw * 1.2, top + (flareBot - top) * 0.35, cx - sw * 0.85, top);
        canvas.drawPath(path, paint);
        // Sparkle dots
        _drawSparkles(canvas, cx, top, flareBot, sw, color);
        break;

      case DressStyle.casual:
        final path = Path();
        path.moveTo(cx - sw * 0.9, top);
        path.lineTo(cx + sw * 0.9, top);
        path.lineTo(cx + sw * 1.2, flareBot);
        path.lineTo(cx - sw * 1.2, flareBot);
        path.close();
        canvas.drawPath(path, paint);
        // Pocket detail
        final pocketPaint = Paint()
          ..color = Color.lerp(color, Colors.black, 0.12)!
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(cx + sw * 0.6, top + (flareBot - top) * 0.65), width: sw * 0.5, height: sw * 0.38),
            Radius.circular(4),
          ),
          pocketPaint,
        );
        break;

      case DressStyle.tshirtDress:
        final bodyPart = top + (flareBot - top) * 0.38;
        // Fitted bodice
        canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromLTRB(cx - sw, top, cx + sw, bodyPart), Radius.circular(4)),
          paint,
        );
        // Skirt flare
        final sPath = Path();
        sPath.moveTo(cx - sw, bodyPart);
        sPath.lineTo(cx + sw, bodyPart);
        sPath.lineTo(cx + sw * 1.4, flareBot);
        sPath.lineTo(cx - sw * 1.4, flareBot);
        sPath.close();
        canvas.drawPath(sPath, paint);
        // Collar
        final collarPaint = Paint()..color = Color.lerp(color, Colors.white, 0.3)!;
        canvas.drawOval(Rect.fromCenter(center: Offset(cx, top + (flareBot - top) * 0.04), width: sw * 0.7, height: (flareBot - top) * 0.08), collarPaint);
        break;

      case DressStyle.none:
        break;
    }
  }

  void _drawHeartPattern(Canvas canvas, double cx, double top, double bot, double sw, Color dressColor) {
    final heartPaint = Paint()..color = Colors.white.withOpacity(0.55);
    final positions = [
      Offset(cx - sw * 0.3, top + (bot - top) * 0.25),
      Offset(cx + sw * 0.5, top + (bot - top) * 0.2),
      Offset(cx - sw * 0.6, top + (bot - top) * 0.5),
      Offset(cx + sw * 0.2, top + (bot - top) * 0.48),
      Offset(cx + sw * 0.8, top + (bot - top) * 0.55),
      Offset(cx - sw * 0.1, top + (bot - top) * 0.7),
      Offset(cx + sw * 0.55, top + (bot - top) * 0.75),
      Offset(cx - sw * 0.75, top + (bot - top) * 0.78),
    ];
    for (final pos in positions) {
      _drawHeart(canvas, pos, 5.5, heartPaint);
    }
  }

  void _drawHeart(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    path.moveTo(center.dx, center.dy + size * 0.5);
    path.cubicTo(center.dx - size * 1.5, center.dy - size * 0.5, center.dx - size * 2, center.dy + size * 0.8, center.dx, center.dy + size * 2);
    path.cubicTo(center.dx + size * 2, center.dy + size * 0.8, center.dx + size * 1.5, center.dy - size * 0.5, center.dx, center.dy + size * 0.5);
    canvas.drawPath(path, paint);
  }

  void _drawSparkles(Canvas canvas, double cx, double top, double bot, double sw, Color dressColor) {
    final sparkPaint = Paint()..color = Colors.white.withOpacity(0.45);
    final rng = math.Random(42);
    for (int i = 0; i < 14; i++) {
      final x = cx + (rng.nextDouble() * sw * 3.8 - sw * 1.9);
      final y = top + rng.nextDouble() * (bot - top);
      canvas.drawCircle(Offset(x, y), 2.5, sparkPaint);
    }
  }

  void _drawTop(Canvas canvas, double cx, double top, double bot, double sw, double hw, TopStyle style, Color color) {
    final paint = Paint()..color = color;

    switch (style) {
      case TopStyle.tshirt:
        final path = Path();
        path.moveTo(cx - sw * 0.9, top);
        path.lineTo(cx + sw * 0.9, top);
        path.cubicTo(cx + sw * 1.05, top + (bot - top) * 0.5, cx + hw * 0.95, bot, cx + hw, bot);
        path.lineTo(cx - hw, bot);
        path.cubicTo(cx - hw * 0.95, bot, cx - sw * 1.05, top + (bot - top) * 0.5, cx - sw * 0.9, top);
        canvas.drawPath(path, paint);
        // Collar
        final collarPaint = Paint()
          ..color = Color.lerp(color, Colors.black, 0.15)!
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawArc(Rect.fromCenter(center: Offset(cx, top + (bot - top) * 0.02), width: sw * 0.7, height: (bot - top) * 0.18), 0, math.pi, false, collarPaint);
        break;

      case TopStyle.hoodie:
        final path = Path();
        path.moveTo(cx - sw * 0.85, top);
        path.lineTo(cx + sw * 0.85, top);
        path.cubicTo(cx + sw * 1.05, top + (bot - top) * 0.5, cx + hw * 0.95, bot, cx + hw, bot);
        path.lineTo(cx - hw, bot);
        path.cubicTo(cx - hw * 0.95, bot, cx - sw * 1.05, top + (bot - top) * 0.5, cx - sw * 0.85, top);
        canvas.drawPath(path, paint);
        // Hood
        final hoodPaint = Paint()..color = Color.lerp(color, Colors.black, 0.08)!;
        canvas.drawArc(Rect.fromCenter(center: Offset(cx, top), width: sw * 1.2, height: (bot - top) * 0.5), math.pi, math.pi, false, hoodPaint);
        // Kangaroo pocket
        final pocketPaint = Paint()..color = Color.lerp(color, Colors.black, 0.1)!;
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(cx, top + (bot - top) * 0.72), width: hw * 1.0, height: (bot - top) * 0.25),
            Radius.circular(8),
          ),
          pocketPaint,
        );
        break;

      case TopStyle.buttonUp:
        final path = Path();
        path.moveTo(cx - sw * 0.9, top);
        path.lineTo(cx + sw * 0.9, top);
        path.cubicTo(cx + sw * 1.05, top + (bot - top) * 0.5, cx + hw * 0.95, bot, cx + hw, bot);
        path.lineTo(cx - hw, bot);
        path.cubicTo(cx - hw * 0.95, bot, cx - sw * 1.05, top + (bot - top) * 0.5, cx - sw * 0.9, top);
        canvas.drawPath(path, paint);
        // Buttons
        final buttonPaint = Paint()..color = Color.lerp(color, Colors.black, 0.3)!;
        for (int i = 0; i < 4; i++) {
          canvas.drawCircle(Offset(cx, top + (bot - top) * (0.2 + i * 0.22)), 3, buttonPaint);
        }
        // Collar points
        final colPaint = Paint()..color = Colors.white;
        final colPath = Path();
        colPath.moveTo(cx, top + (bot - top) * 0.12);
        colPath.lineTo(cx - sw * 0.35, top);
        colPath.lineTo(cx - sw * 0.55, top + (bot - top) * 0.18);
        colPath.close();
        canvas.drawPath(colPath, colPaint);
        final colPath2 = Path();
        colPath2.moveTo(cx, top + (bot - top) * 0.12);
        colPath2.lineTo(cx + sw * 0.35, top);
        colPath2.lineTo(cx + sw * 0.55, top + (bot - top) * 0.18);
        colPath2.close();
        canvas.drawPath(colPath2, colPaint);
        break;

      case TopStyle.tank:
        final path = Path();
        path.moveTo(cx - sw * 0.7, top);
        path.lineTo(cx + sw * 0.7, top);
        path.cubicTo(cx + sw * 0.9, top + (bot - top) * 0.5, cx + hw * 0.85, bot, cx + hw, bot);
        path.lineTo(cx - hw, bot);
        path.cubicTo(cx - hw * 0.85, bot, cx - sw * 0.9, top + (bot - top) * 0.5, cx - sw * 0.7, top);
        canvas.drawPath(path, paint);
        // Tank straps
        final strapPaint = Paint()..color = color;
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(cx - sw * 0.68, top - 4, sw * 0.22, (bot - top) * 0.15), Radius.circular(4)), strapPaint);
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(cx + sw * 0.46, top - 4, sw * 0.22, (bot - top) * 0.15), Radius.circular(4)), strapPaint);
        break;

      case TopStyle.none:
        break;
    }
  }

  void _drawHat(Canvas canvas, double cx, double cy, double r, HatStyle style, Color color) {
    final paint = Paint()..color = color;
    final darkPaint = Paint()..color = Color.lerp(color, Colors.black, 0.2)!;

    switch (style) {
      case HatStyle.sunhat:
        // Wide brim
        canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy - r * 0.95), width: r * 2.8, height: r * 0.42), paint);
        // Cap
        canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy - r * 1.1), width: r * 1.6, height: r * 0.7), paint);
        // Band
        final bandPaint = Paint()..color = const Color(0xFFFFD700);
        canvas.drawRect(Rect.fromLTRB(cx - r * 0.8, cy - r * 1.05, cx + r * 0.8, cy - r * 0.88), bandPaint);
        break;

      case HatStyle.beanie:
        final path = Path();
        path.moveTo(cx - r * 0.95, cy - r * 0.45);
        path.cubicTo(cx - r * 0.9, cy - r * 1.4, cx + r * 0.9, cy - r * 1.4, cx + r * 0.95, cy - r * 0.45);
        path.close();
        canvas.drawPath(path, paint);
        // Ribbed band
        canvas.drawRect(Rect.fromLTRB(cx - r * 0.95, cy - r * 0.55, cx + r * 0.95, cy - r * 0.35), darkPaint);
        // Pompom
        canvas.drawCircle(Offset(cx, cy - r * 1.38), r * 0.22, Paint()..color = Colors.white);
        break;

      case HatStyle.cap:
        // Cap dome
        final dome = Path();
        dome.moveTo(cx - r * 0.9, cy - r * 0.5);
        dome.cubicTo(cx - r * 0.85, cy - r * 1.3, cx + r * 0.85, cy - r * 1.3, cx + r * 0.9, cy - r * 0.5);
        dome.close();
        canvas.drawPath(dome, paint);
        // Brim
        canvas.drawOval(Rect.fromCenter(center: Offset(cx + r * 0.35, cy - r * 0.5), width: r * 1.6, height: r * 0.25), darkPaint);
        break;

      case HatStyle.tophat:
        // Cylinder
        canvas.drawRect(Rect.fromLTRB(cx - r * 0.6, cy - r * 1.6, cx + r * 0.6, cy - r * 0.7), paint);
        // Brim
        canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy - r * 0.7), width: r * 1.7, height: r * 0.3), paint);
        // Band
        canvas.drawRect(Rect.fromLTRB(cx - r * 0.6, cy - r * 0.95, cx + r * 0.6, cy - r * 0.82), darkPaint);
        break;

      case HatStyle.beret:
        final path = Path();
        path.moveTo(cx - r * 0.9, cy - r * 0.65);
        path.cubicTo(cx - r * 1.1, cy - r * 1.2, cx + r * 0.5, cy - r * 1.5, cx + r * 0.9, cy - r * 0.75);
        path.cubicTo(cx + r * 0.7, cy - r * 0.5, cx - r * 0.5, cy - r * 0.5, cx - r * 0.9, cy - r * 0.65);
        canvas.drawPath(path, paint);
        canvas.drawCircle(Offset(cx + r * 0.15, cy - r * 1.12), r * 0.1, darkPaint);
        break;

      case HatStyle.none:
        break;
    }
  }

  @override
  bool shouldRepaint(CharacterPainter oldDelegate) =>
      oldDelegate.outfit != outfit || oldDelegate.gender != gender;
}
