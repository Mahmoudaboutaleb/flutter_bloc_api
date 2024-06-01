// import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc_api/contans/my_colors.dart';
import 'package:flutter_bloc_api/data-layer/models/characters.dart';

class CharacteresDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacteresDetailsScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    sliverAppBar() {
      return SliverAppBar(
        pinned: true,
        // floating: true,
        expandedHeight: 600,
        backgroundColor: MyColors.myGrey.withOpacity(0.2),
        foregroundColor: MyColors.myWhite,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            character.name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          background: Hero(
            tag: character.name,
            child: Image.network(
              character.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    Widget charactersInfo(String title, String info) {
      return RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            TextSpan(
              text: info,
              style: const TextStyle(fontSize: 14, color: MyColors.myWhite),
            ),
          ]));
    }

    Widget buildDivider(double endIndent) {
      return Divider(
        color: MyColors.myYellow,
        height: 32,
        thickness: 3,
        endIndent: endIndent,
      );
    }

    return Scaffold(
        backgroundColor: MyColors.myGrey,
        body: CustomScrollView(
          slivers: [
            sliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(14),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 5,
                            width: 60,
                            decoration: BoxDecoration(
                              color: MyColors.myWhite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        charactersInfo('Status:  ', character.status),
                        buildDivider(267),
                        charactersInfo('Species:  ', character.species),
                        buildDivider(255),
                        charactersInfo('Gender:  ', character.gender),
                        buildDivider(260),
                        charactersInfo(
                            'Origin:  ', character.origin["name"].toString()),
                        buildDivider(270),
                        charactersInfo('Location:  ',
                            character.location["name"].toString()),
                        buildDivider(250),
                        charactersInfo(
                            'Episode:  ', character.episode.join(' / ')),
                        buildDivider(255),
                      ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        FadeAnimatedText(character.created,
                            textStyle: const TextStyle(
                                fontSize: 20,
                                color: MyColors.myWhite,
                                shadows: [
                                  Shadow(
                                      color: Colors.yellow,
                                      blurRadius: 7,
                                      offset: Offset(0, 0))
                                ])),
                      ],
                      onTap: () {},
                    ),
                  ),
                ),
                const SizedBox(
                  height: 500,
                )
              ]),
            ),
          ],
        ));
  }
}
