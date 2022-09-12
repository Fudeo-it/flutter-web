import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:people_app/cubits/persons/persons_cubit.dart';
import 'package:people_app/models/person.dart';
import 'package:people_app/widgets/app_drawer.dart';
import 'package:people_app/widgets/exception_widget.dart';
import 'package:people_app/widgets/footer.dart';
import 'package:people_app/widgets/loading_widget.dart';

class PeoplePage extends StatelessWidget {
  final _scrollController = ScrollController();

  PeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => PersonsCubit(
          peopleRepository: context.read(),
        )..fetchPeople(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('People'),
          ),
          body: Column(
            children: [
              _body,
              const Footer(),
            ],
          ),
        ),
      );

  Widget get _body => Expanded(
        child: Row(
          children: [
            const AppDrawer(),
            Expanded(
              child: BlocBuilder<PersonsCubit, PersonsState>(
                  builder: (context, state) {
                if (state is ErrorPersonsState) {
                  return const ExceptionWidget();
                } else if (state is LoadedPersonsState) {
                  return _table(context, people: state.people);
                }

                return const LoadingWidget();
              }),
            ),
          ],
        ),
      );

  Widget _table(
    BuildContext context, {
    required List<Person> people,
  }) =>
      Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('People', style: Theme.of(context).textTheme.headline4),
            Expanded(
              child: SizedBox(
                width: double.maxFinite,
                child: Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      headingTextStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                      columns: [
                        'Id',
                        'First Name',
                        'Last Name',
                        'Birth Date',
                        'Address',
                        'City',
                        'State',
                      ]
                          .map(
                            (column) => DataColumn(label: Text(column)),
                          )
                          .toList(growable: false),
                      rows: people
                          .map(
                            (person) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(person.id.toString())),
                                DataCell(Text(person.firstName)),
                                DataCell(Text(person.lastName)),
                                DataCell(Text(
                                    DateFormat(DateFormat.YEAR_MONTH_DAY)
                                        .format(person.birthDate))),
                                DataCell(Text(person.address)),
                                DataCell(Text(person.city)),
                                DataCell(Text(person.state)),
                              ],
                            ),
                          )
                          .toList(growable: false),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
