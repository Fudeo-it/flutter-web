import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:people_app/models/person.dart';
import 'package:people_app/widgets/app_drawer.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  late final _persons = Person.persons();
  bool _direction = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('People'),
        ),
        body: _body,
      );

  Widget get _body => Row(
        children: [
          const AppDrawer(),
          _table,
        ],
      );

  Widget get _table => Expanded(
        child: SingleChildScrollView(
          child: DataTable(
            headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            sortColumnIndex: 0,
            sortAscending: _direction,
            columns: [
              DataColumn(
                  label: const Text('Id'),
                  numeric: true,
                  onSort: (columnIndex, sortAscending) {
                    setState(() {
                      _direction = !_direction;
                      _persons.sort((a, b) =>
                          a.id.compareTo(b.id) * (_direction ? 1 : -1));
                    });
                  }),
              const DataColumn(label: Text('First Name')),
              const DataColumn(label: Text('Last Name')),
              const DataColumn(label: Text('Birth Date')),
              const DataColumn(label: Text('Address')),
              const DataColumn(label: Text('City')),
              const DataColumn(label: Text('State')),
            ],
            rows: _persons
                .map((person) => DataRow(
                      cells: [
                        DataCell(Text(person.id.toString())),
                        DataCell(Text(person.firstName)),
                        DataCell(Text(person.lastName)),
                        DataCell(Text(DateFormat(DateFormat.YEAR_MONTH_DAY)
                            .format(person.birthDate))),
                        DataCell(Text(person.address)),
                        DataCell(Text(person.city)),
                        DataCell(Text(person.state)),
                      ],
                    ))
                .toList(growable: false),
          ),
        ),
      );
}
