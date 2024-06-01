// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_api/business-logic-layer/cubit/characters_cubit_cubit.dart';
import 'package:flutter_bloc_api/contans/settings.dart';
import 'package:flutter_bloc_api/data-layer/models/characters.dart';
import 'package:flutter_bloc_api/data-layer/repository/characters_repository.dart';
import 'package:flutter_bloc_api/data-layer/web-services/characters_web_services.dart';
import 'package:flutter_bloc_api/presentation-layer/screens/characters_details_screen.dart';
import 'package:flutter_bloc_api/presentation-layer/screens/characters_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubitCubit charactersCubitCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubitCubit = CharactersCubitCubit(charactersRepository, []);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characteresScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => charactersCubitCubit,
                child: const CharactersScreen()));
      case characteresDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => CharacteresDetailsScreen(
                  character: character,
                ));
    }
    return null;
  }
}
