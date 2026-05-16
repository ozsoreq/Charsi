import 'dart:ui';

enum Gender { female, male }

enum HairStyle {
  longWavy,
  longStraight,
  bun,
  shortCurly,
  shortStraight,
  medium,
}

enum DressStyle {
  none,
  aLine,
  casual,
  ballgown,
  sundress,
  tshirtDress,
}

enum TopStyle {
  none,
  tshirt,
  hoodie,
  buttonUp,
  tank,
}

enum PantsStyle {
  none,
  jeans,
  shorts,
  leggings,
  skirt,
  chinos,
}

enum ShoesStyle {
  none,
  sandals,
  sneakers,
  boots,
  heels,
  loafers,
}

enum HatStyle {
  none,
  sunhat,
  beanie,
  cap,
  tophat,
  beret,
}

class OutfitConfig {
  final Color skinColor;
  final Color hairColor;
  final HairStyle hairStyle;
  final DressStyle dressStyle;
  final Color dressColor;
  final TopStyle topStyle;
  final Color topColor;
  final PantsStyle pantsStyle;
  final Color pantsColor;
  final ShoesStyle shoesStyle;
  final Color shoesColor;
  final HatStyle hatStyle;
  final Color hatColor;
  final String outfitName;

  const OutfitConfig({
    this.skinColor = const Color(0xFFE8B89A),
    this.hairColor = const Color(0xFF5C3317),
    this.hairStyle = HairStyle.longWavy,
    this.dressStyle = DressStyle.aLine,
    this.dressColor = const Color(0xFFE8715A),
    this.topStyle = TopStyle.none,
    this.topColor = const Color(0xFF4A90D9),
    this.pantsStyle = PantsStyle.none,
    this.pantsColor = const Color(0xFF2C5F8A),
    this.shoesStyle = ShoesStyle.sandals,
    this.shoesColor = const Color(0xFF8B5E3C),
    this.hatStyle = HatStyle.none,
    this.hatColor = const Color(0xFFE8715A),
    this.outfitName = 'My Outfit',
  });

  OutfitConfig copyWith({
    Color? skinColor,
    Color? hairColor,
    HairStyle? hairStyle,
    DressStyle? dressStyle,
    Color? dressColor,
    TopStyle? topStyle,
    Color? topColor,
    PantsStyle? pantsStyle,
    Color? pantsColor,
    ShoesStyle? shoesStyle,
    Color? shoesColor,
    HatStyle? hatStyle,
    Color? hatColor,
    String? outfitName,
  }) {
    return OutfitConfig(
      skinColor: skinColor ?? this.skinColor,
      hairColor: hairColor ?? this.hairColor,
      hairStyle: hairStyle ?? this.hairStyle,
      dressStyle: dressStyle ?? this.dressStyle,
      dressColor: dressColor ?? this.dressColor,
      topStyle: topStyle ?? this.topStyle,
      topColor: topColor ?? this.topColor,
      pantsStyle: pantsStyle ?? this.pantsStyle,
      pantsColor: pantsColor ?? this.pantsColor,
      shoesStyle: shoesStyle ?? this.shoesStyle,
      shoesColor: shoesColor ?? this.shoesColor,
      hatStyle: hatStyle ?? this.hatStyle,
      hatColor: hatColor ?? this.hatColor,
      outfitName: outfitName ?? this.outfitName,
    );
  }

  Map<String, dynamic> toJson() => {
        'skinColor': skinColor.toARGB32(),
        'hairColor': hairColor.toARGB32(),
        'hairStyle': hairStyle.index,
        'dressStyle': dressStyle.index,
        'dressColor': dressColor.toARGB32(),
        'topStyle': topStyle.index,
        'topColor': topColor.toARGB32(),
        'pantsStyle': pantsStyle.index,
        'pantsColor': pantsColor.toARGB32(),
        'shoesStyle': shoesStyle.index,
        'shoesColor': shoesColor.toARGB32(),
        'hatStyle': hatStyle.index,
        'hatColor': hatColor.toARGB32(),
        'outfitName': outfitName,
      };

  factory OutfitConfig.fromJson(Map<String, dynamic> json) => OutfitConfig(
        skinColor: Color(json['skinColor'] as int),
        hairColor: Color(json['hairColor'] as int),
        hairStyle: HairStyle.values[json['hairStyle'] as int],
        dressStyle: DressStyle.values[json['dressStyle'] as int],
        dressColor: Color(json['dressColor'] as int),
        topStyle: TopStyle.values[json['topStyle'] as int],
        topColor: Color(json['topColor'] as int),
        pantsStyle: PantsStyle.values[json['pantsStyle'] as int],
        pantsColor: Color(json['pantsColor'] as int),
        shoesStyle: ShoesStyle.values[json['shoesStyle'] as int],
        shoesColor: Color(json['shoesColor'] as int),
        hatStyle: HatStyle.values[json['hatStyle'] as int],
        hatColor: Color(json['hatColor'] as int),
        outfitName: json['outfitName'] as String,
      );
}

class CharacterModel {
  final String playerName;
  final int playerAge;
  final Gender gender;
  final String characterName;
  final OutfitConfig currentOutfit;
  final List<OutfitConfig> savedOutfits;

  const CharacterModel({
    this.playerName = '',
    this.playerAge = 0,
    this.gender = Gender.female,
    this.characterName = '',
    this.currentOutfit = const OutfitConfig(),
    this.savedOutfits = const [],
  });

  CharacterModel copyWith({
    String? playerName,
    int? playerAge,
    Gender? gender,
    String? characterName,
    OutfitConfig? currentOutfit,
    List<OutfitConfig>? savedOutfits,
  }) {
    return CharacterModel(
      playerName: playerName ?? this.playerName,
      playerAge: playerAge ?? this.playerAge,
      gender: gender ?? this.gender,
      characterName: characterName ?? this.characterName,
      currentOutfit: currentOutfit ?? this.currentOutfit,
      savedOutfits: savedOutfits ?? this.savedOutfits,
    );
  }
}
