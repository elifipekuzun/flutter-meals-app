import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function setFilters;
  final Map<String, bool> filters;

  const FiltersScreen(
      {super.key, required this.setFilters, required this.filters});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget _buildSwitchListTile(
      String title, String subtitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: currentValue,
        onChanged: ((value) => updateValue(value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
              onPressed: () => widget.setFilters(widget.filters),
              icon: const Icon(Icons.save)),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                  'Gluten-Free',
                  'Only include gluten-free meals.',
                  widget.filters['gluten']!, (newValue) {
                setState(() {
                  widget.filters['gluten'] = newValue;
                });
              }),
              _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  widget.filters['vegetarian']!, (newValue) {
                setState(() {
                  widget.filters['vegetarian'] = newValue;
                });
              }),
              _buildSwitchListTile('Vegan', 'Only include vegan meals.',
                  widget.filters['vegan']!, (newValue) {
                setState(() {
                  widget.filters['vegan'] = newValue;
                });
              }),
              _buildSwitchListTile(
                  'Lactose-Free',
                  'Only include lactose-free meals.',
                  widget.filters['lactose']!, (newValue) {
                setState(() {
                  widget.filters['lactose'] = newValue;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
