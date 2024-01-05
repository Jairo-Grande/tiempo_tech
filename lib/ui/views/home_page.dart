import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiempo_tech/bloc/bloc/nasa_bloc.dart';

import 'package:tiempo_tech/data/model/nasa_result_model.dart';
import 'package:tiempo_tech/domain/repositories/database_repository.dart';

import 'package:tiempo_tech/ui/widgets/custom_card.dart';
import 'package:tiempo_tech/ui/widgets/custom_textfield.dart';
import 'package:tiempo_tech/utils/constants.dart';
import 'package:tiempo_tech/dependency_injection/injection.dart' as dep_iny;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Item?> items = [];

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<NasaBloc>().add(SearchNasaDataByParameter(query: 'Apollo'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.favorites);
                },
                child: const Text('ir a favoritos'))
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(Const.padding),
                  child: CustomTextFormField(
                    onChanged: (value) {
                      context
                          .read<NasaBloc>()
                          .add(SearchNasaDataByParameter(query: value));
                    },
                    controller: TextEditingController(),
                    hintText: 'Buscar',
                    prefixIcon: Icon(
                      Icons.search,
                      color: theme.primaryColor,
                    ),
                  )),
              BlocConsumer<NasaBloc, NasaState>(
                listener: (context, state) {
                  if (state is NasaHasData) {
                    items = [];
                    items = state.nasaData.collection!.items!;
                  }
                },
                builder: (context, state) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return MyCard(
                          item: items[index],
                          like: false,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
