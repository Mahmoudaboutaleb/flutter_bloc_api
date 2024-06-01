// ignore_for_file: unnecessary_string_interpolations, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_api/business-logic-layer/cubit/characters_cubit_cubit.dart';
import 'package:flutter_bloc_api/contans/my_colors.dart';
import 'package:flutter_bloc_api/data-layer/models/characters.dart';
import 'package:flutter_bloc_api/presentation-layer/widgets/character_item.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters = [];
  late List<Character> searchedToCharacters = [];
  bool isSearched = false;
  TextEditingController? searchedController;
  FocusNode? searrchFocusedNode;

  @override
  void initState() {
    super.initState();
    searchedController = TextEditingController();
    searrchFocusedNode = FocusNode();
    context.read<CharactersCubitCubit>().getAllCharacter();
  }

  @override
  void dispose() {
    searchedController!.dispose();
    searrchFocusedNode!.dispose();
    super.dispose();
  }

  Widget _buildTextField() {
    return TextField(
      controller: searchedController,
      focusNode: searrchFocusedNode,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Find a character ...',
      ),
      onChanged: (value) {
        setState(() {
          if (value.isEmpty) {
            searchedToCharacters = allCharacters;
            isSearched = false;
          } else {
            searchedToCharacters = allCharacters.where((character) {
              return character.name.toLowerCase().contains(value.toLowerCase());
            }).toList();
            isSearched = true;
          }
        });
      },
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubitCubit, CharactersCubitState>(
      builder: (context, state) {
        if (state is CharactersCubitLoaded) {
          allCharacters = state.characters;
          return buildLoadedListWidget();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget buildLoadedListWidget() {
    return Container(
      color: MyColors.myGrey,
      child: Column(
        children: [
          Expanded(child: buildCharactersList()),
        ],
      ),
    );
  }

  Widget buildCharactersList() {
    final charactersToShow = isSearched ? searchedToCharacters : allCharacters;
    if (charactersToShow.isEmpty) {
      return emptyListOfSearch();
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: searchedController!.text.isEmpty
            ? allCharacters.length
            : charactersToShow.length,
        itemBuilder: (context, index) {
          return CharacterItem(
            character: searchedController!.text.isEmpty
                ? allCharacters[index]
                : charactersToShow[index],
          );
        },
      );
    }
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(MyColors.myYellow),
      ),
    );
  }

  Widget emptyListOfSearch() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 100,
            color: Colors.grey,
          ),
          SizedBox(height: 20),
          Text(
            'No characters found',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNoInternetConnected(ConnectivityResult connectivity) {
    final bool connected = connectivity != ConnectivityResult.none;
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          height: 24.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            color:
                connected ? const Color(0xFF00EE44) : const Color(0xFFEE4400),
            child: Center(
              child: Text("${connected ? 'ONLINE' : 'OFFLINE'}"),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                connected ? Icons.wifi : Icons.wifi_off,
                size: 80,
                color: connected ? Colors.green : Colors.red,
              ),
              const SizedBox(height: 20),
              Text(
                connected ? 'You are online' : 'No internet connection',
                style: TextStyle(
                  color: connected ? Colors.green : Colors.red,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<bool> showExitConfirmationDialog() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitConfirmationDialog,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            isSearched = false;
          });
        },
        child: Scaffold(
          appBar: AppBar(
            title: isSearched
                ? _buildTextField()
                : const Text(
                    'All Characters',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
            backgroundColor: MyColors.myYellow,
            elevation: 0,
            centerTitle: true,
            actions: [
              isSearched
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          searchedController!.clear();
                          isSearched = false;
                          FocusScope.of(context)
                              .unfocus(); // Remove focus when clearing search
                        });
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        if (isSearched) {
                          FocusScope.of(context)
                              .requestFocus(searrchFocusedNode);
                        }
                        setState(() {
                          isSearched = true;
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
            ],
          ),
          body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              return Stack(
                fit: StackFit.expand,
                children: [
                  child,
                  if (!connected) buildNoInternetConnected(connectivity),
                ],
              );
            },
            child: buildBlocWidget(), // Add child for OfflineBuilder
          ),
        ),
      ),
    );
  }
}
