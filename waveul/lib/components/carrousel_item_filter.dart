import 'package:flutter/material.dart';

class CarrouselItemFilter extends StatefulWidget {
  CarrouselItemFilter({super.key});

  @override
  State<CarrouselItemFilter> createState() => _CarrouselItemFilterState();
}

class _CarrouselItemFilterState extends State<CarrouselItemFilter> {
  final List<String> _items = const [
    "Todo",
    "Artistas",
    "Canciones",
    "Álbumes",
    "Playlists",
    "Perfiles",
  ];
  int _selected = 0;

  Widget _buildBody(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _items.length,
        separatorBuilder: (_, __) => SizedBox(width: 20),
        itemBuilder: (context, i) {
          final isSelected = i == _selected;
          return GestureDetector(
            onTap: () => setState(() => _selected = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(25),
                border:
                    isSelected
                        ? null
                        : Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
              ),
              child: Text(
                _items[i],
                style: TextStyle(
                  fontSize: 16,
                  color:
                      isSelected
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
