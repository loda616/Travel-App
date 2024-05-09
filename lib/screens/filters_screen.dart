import 'package:flutter/material.dart';
import 'package:travel_mobile/widgets/app_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const screenRoute = '/filters';

  final Function saveFilters;
  final Map<String, bool > currentFilter;

  FiltersScreen(this.currentFilter,this.saveFilters, {Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _Summer = false;
  var _Winter = false;
  var _Family = false;

  @override
  void initState() {
    _Summer = widget.currentFilter['summer'] ?? false;
    _Winter = widget.currentFilter['winter'] ?? false;
    _Family = widget.currentFilter['family'] ?? false;
    super.initState();
  }


  Widget buildSwitchListTile(
      String title, String subtitle, bool currentValue, Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الفلترة'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'summer' : _Summer ,
                'winter' : _Winter ,
                'family' : _Family,
              };
              widget.saveFilters(selectedFilters);
            },

            icon: Icon(Icons.save),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          SizedBox(height: 50),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  'الرحلات الصيفية',
                  'إظهار رحلات فصل الصيف فقط',
                  _Summer,
                      (newValue) {
                    setState(() {
                      _Summer = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  'الرحلات الشتوية',
                  'إظهار رحلات فصل الشتاء فقط',
                  _Winter,
                      (newValue) {
                    setState(() {
                      _Winter = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  'للعائلات',
                  'إظهار الرحلات العائلية فقط',
                  _Family,
                      (newValue) {
                    setState(() {
                      _Family = newValue;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
