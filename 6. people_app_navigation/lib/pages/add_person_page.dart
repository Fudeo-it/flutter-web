import 'package:flutter/material.dart';
import 'package:people_app/widgets/app_drawer.dart';
import 'package:people_app/widgets/footer.dart';

class AddPersonPage extends StatelessWidget {
  AddPersonPage({Key? key}) : super(key: key);

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add Person'),
        ),
        body: Column(
          children: [
            _body(context),
            const Footer(),
          ],
        ),
      );

  Widget _body(BuildContext context) => Expanded(
        child: Row(
          children: [
            const AppDrawer(),
            Expanded(
              child: _form(context),
            ),
          ],
        ),
      );

  Widget _form(BuildContext context) {
    final fields = [
      _firstNameWidget(context),
      _lastNameWidget(context),
      _birthDateWidget(context),
      _addressWidget(context),
      _cityWidget(context),
      _stateWidget(context),
    ];

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add Person', style: Theme.of(context).textTheme.headline4),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (context, index) => fields[index],
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: fields.length,
            ),
          ),
          _saveButton(context),
        ],
      ),
    );
  }

  Widget _firstNameWidget(BuildContext context) => Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'First Name',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            flex: 4,
            child: TextField(
              controller: _firstNameController,
              keyboardType: TextInputType.name,
            ),
          ),
        ],
      );

  Widget _lastNameWidget(BuildContext context) => Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'Last Name',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            flex: 4,
            child: TextField(
              controller: _lastNameController,
              keyboardType: TextInputType.name,
            ),
          ),
        ],
      );

  Widget _birthDateWidget(BuildContext context) => Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'Birth Date',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            flex: 4,
            child: TextField(
              controller: _birthDateController,
              keyboardType: TextInputType.datetime,
            ),
          ),
        ],
      );

  Widget _addressWidget(BuildContext context) => Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'Address',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            flex: 4,
            child: TextField(
              controller: _addressController,
              keyboardType: TextInputType.streetAddress,
            ),
          ),
        ],
      );

  Widget _cityWidget(BuildContext context) => Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'City',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            flex: 4,
            child: TextField(
              controller: _cityController,
              keyboardType: TextInputType.streetAddress,
            ),
          ),
        ],
      );

  Widget _stateWidget(BuildContext context) => Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'State',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            flex: 4,
            child: TextField(
              controller: _stateController,
              keyboardType: TextInputType.streetAddress,
            ),
          ),
        ],
      );

  Widget _saveButton(BuildContext context) => Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Save'),
          ),
        ),
      );
}
