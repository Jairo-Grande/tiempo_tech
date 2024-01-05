import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiempo_tech/bloc/bloc/nasa_bloc.dart';
import 'package:tiempo_tech/bloc/favorite/favorites_bloc.dart';
import 'package:tiempo_tech/data/model/nasa_result_model.dart';
import 'package:tiempo_tech/dependency_injection/injection.dart';
import 'package:tiempo_tech/domain/repositories/database_repository.dart';
import 'package:tiempo_tech/utils/constants.dart';
import 'package:tiempo_tech/utils/screens.dart';

final DatabaseRepository _databaseRepository = locator<DatabaseRepository>();

class MyCard extends StatefulWidget {
  final Item? item;
  final bool like;

  const MyCard({
    super.key,
    required this.item,
    required this.like,
  });

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  IconData _icon = Icons.star_border_rounded;
  Color _color = Colors.white;
  late bool _isPressed;

  @override
  void initState() {
    super.initState();
  }

  initializeIconColor() async {
    Item? existingItem = await _databaseRepository
        .getItemByTitle(widget.item!.data!.first.title!);
    if (existingItem == null) {
      _icon = Icons.star_border_rounded;
      _color = Colors.white;
    } else {
      _icon = Icons.star_outlined;
      _color = Colors.yellow;
    }

    _isPressed = widget.like;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<NasaBloc>().add(ShowFullDetails(item: widget.item));
        Navigator.pushNamed(context, Routes.details);
      },
      child: Card(
        margin: const EdgeInsets.all(Const.margin),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Column(
            children: [
              (widget.item != null &&
                      widget.item!.links != null &&
                      widget.item!.links!.isNotEmpty &&
                      widget.item!.links![0].href != null)
                  ? SizedBox(
                      height: Screens.heigth(context) * 0.3,
                      width: double.infinity,
                      child: Stack(fit: StackFit.expand, children: [
                        Image.network(
                          widget.item?.links?[0].href ?? '',
                          fit: BoxFit.cover,
                          /*   height: Screens.heigth(context) *
                              0.3,  */ // Ajusta según sea necesario
                          //width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Text('Imagen no disponible'),
                            );
                          },
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: FutureBuilder(
                              future: initializeIconColor(),
                              builder: (context, snapshot) {
                                return IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPressed = !_isPressed;
                                      _icon = _isPressed
                                          ? Icons.star_outlined
                                          : Icons.star_border_rounded;
                                      _color = _isPressed
                                          ? Colors.yellow
                                          : Colors.white;
                                    });

                                    context.read<FavoritesBloc>().add(
                                        AddOrRemoveFavorite(
                                            item: widget.item!));
                                  },
                                  icon: Icon(
                                    _icon,
                                    color: _color,
                                    size: 30,
                                  ),
                                );
                              },
                            ))
                      ]),
                    )
                  : SizedBox(
                      height: Screens.heigth(context) * 0.3,
                      width: double.infinity,
                      child: const Center(child: Text('Imagen no disponible'))),
              ListTile(
                title: Text(
                    widget.item?.data?[0].title ?? 'No hay titulo disponible'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
