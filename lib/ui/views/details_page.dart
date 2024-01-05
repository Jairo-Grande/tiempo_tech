import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiempo_tech/bloc/bloc/nasa_bloc.dart';
import 'package:tiempo_tech/data/model/nasa_result_model.dart';
import 'package:tiempo_tech/ui/widgets/custom_card.dart';
import 'package:tiempo_tech/utils/constants.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(children: [
        BlocBuilder<NasaBloc, NasaState>(
          builder: (context, state) {
            if (state is ShowNasaItemDetails) {
              return Padding(
                padding: const EdgeInsets.all(Const.padding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyCard(
                        item: state.item,
                        like: false,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Titulo: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: state.item?.data?[0].title ??
                                  'No esta disponible',
                            )
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'descripción: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text: state.item?.data?[0].description ??
                                    'No esta Disponible')
                          ],
                        ),
                      ),
                    ]),
              );
            }
            return const SizedBox(
              child: Column(
                children: [
                  Text('Empty'),
                ],
              ),
            );
          },
        )
      ])),
    );
  }
}
