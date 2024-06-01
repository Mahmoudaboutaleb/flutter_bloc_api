import 'package:flutter/material.dart';
import 'package:flutter_bloc_api/contans/my_colors.dart';
import 'package:flutter_bloc_api/contans/settings.dart';
import 'package:flutter_bloc_api/data-layer/models/characters.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.all(8),
      padding: const EdgeInsetsDirectional.all(8),
      decoration: BoxDecoration(
          color: MyColors.myWhite,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: MyColors.myGrey,
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ]),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, characteresDetailsScreen,
              arguments: character);
        },
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              character.name,
              style: const TextStyle(
                  color: MyColors.myWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.3),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          child: Hero(
            tag: character.id,
            child: Container(
              color: MyColors.myGrey,
              child: character.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: "assets/images/loading.gif",
                      image: character.image,
                      fit: BoxFit.cover,
                    )
                  : Image.asset("assets/images/emptyImage.webp"),
            ),
          ),
        ),
      ),
    );
  }
}
