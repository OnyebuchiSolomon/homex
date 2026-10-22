import 'package:flutter/material.dart';

import 'country_code.dart';

class CountryCodeView extends StatefulWidget {
  final ValueChanged<Country> onChanged;
  final String? initialPhoneCode;
  final bool disabled;
  final bool isCountryName;
  final bool isExpanded;
  const CountryCodeView({
    required this.onChanged,
    this.initialPhoneCode,
    this.disabled = false,
    this.isExpanded = false,
    super.key,
  }) : isCountryName = false;
  const CountryCodeView.countryName({
    required this.onChanged,
    this.initialPhoneCode,
    this.disabled = false,
    this.isExpanded = false,
    super.key,
  }) : isCountryName = true;

  @override
  State<CountryCodeView> createState() => _CountryCodeViewState();
}

class _CountryCodeViewState extends State<CountryCodeView> {
  late Country _country;

  @override
  void initState() {
    _country = countryList
        .singleWhere((c) => c.dialCode == (widget.initialPhoneCode ?? '+234'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.disabled
          ? null
          : () => showModalBottomSheet<dynamic>(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(24))),
          backgroundColor: Theme.of(context).canvasColor,
          isScrollControlled: true,
          builder: (BuildContext bc) {
            return FractionallySizedBox(
                heightFactor: .5,
                child: CountryBottomSheet(
                    isCountryName: widget.isCountryName,
                    onSelected: (country) {
                      setState(() => _country = country);
                      widget.onChanged.call(country);
                    }));
          }),
      child: Row(
        mainAxisSize: widget.isExpanded ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flag(_country),
          const SizedBox(width: 5),
          if (widget.isCountryName) ...[
            Expanded(child: Text(_country.name)),
          ] else ...[
            Text(_country.dialCode),
          ],
          const SizedBox(width: 5),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 18,
          )
        ],
      ),
    );
  }
}

class Flag extends StatelessWidget {
  final Country country;
  const Flag(this.country, {super.key});

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    return SizedBox(
      // the conditional 50 prevents irregularities caused by the flags in RTL mode
      width: isRtl ? 50 : null,
      child: Text(
        country.countryFlagEmoji,
        style: const TextStyle(
          fontSize: 25,
        ),
      ),
    );
  }
}

class CountryBottomSheet extends StatefulWidget {
  final bool isCountryName;
  final void Function(Country country) onSelected;
  const CountryBottomSheet({
    required this.onSelected,
    required this.isCountryName,
    super.key,
  });

  @override
  State<CountryBottomSheet> createState() => _CountryBottomSheetState();
}

class _CountryBottomSheetState extends State<CountryBottomSheet> {
  final _searchController = TextEditingController();

  List<Country> _filteredCountries = [];

  @override
  void didChangeDependencies() {
    _filteredCountries = countryList;
    super.didChangeDependencies();
  }

  void _filter(String query) {
    setState(() {
      if (query.isNotEmpty) {
        _filteredCountries = countryList
            .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        _filteredCountries = countryList;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //handle
          Center(
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 7,
                width: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          TextFormField(
            controller: _searchController,
            onChanged: _filter,
            decoration: const InputDecoration(
              labelText: 'Search',
              hintText: 'Search country',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemCount: _filteredCountries.length,
                separatorBuilder: (context, index) =>
                const Divider(thickness: .2),
                itemBuilder: (context, index) {
                  final c = _filteredCountries[index];
                  return InkWell(
                    onTap: () {
                      widget.onSelected.call(c);
                      Navigator.pop(context);
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flag(c),
                            if (!widget.isCountryName) ...[
                              const SizedBox(width: 15),
                              Text(c.dialCode),
                            ],
                            const SizedBox(width: 15),
                            Expanded(child: Text(c.name)),
                          ],
                        )),
                  );
                }),
          )
        ],
      ),
    );
  }
}
