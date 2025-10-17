import 'package:flutter/material.dart';

class CarrouselItemFilter extends StatefulWidget {
  final Function(int index)? onItemSelected;

  CarrouselItemFilter({super.key, this.onItemSelected});

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

  Widget _points(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.circle,
              size: 10,
              color:
                  _selected >= 0 && _selected <= 2
                      ? Theme.of(context).colorScheme.surface
                      : Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.circle,
              size: 10,
              color:
                  _selected > 2
                      ? Theme.of(context).colorScheme.surface
                      : Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

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
            onTap:
                () => {
                  setState(() => _selected = i),
                  widget.onItemSelected?.call(i),
                  print(_selected),
                },

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
                          color: Theme.of(context).colorScheme.shadow,
                        ),
              ),
              child: Text(
                _items[i],
                style: TextStyle(
                  fontSize: 16,
                  color:
                      isSelected
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.shadow,
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
    return Column(children: [_points(context), _buildBody(context)]);
  }
}
