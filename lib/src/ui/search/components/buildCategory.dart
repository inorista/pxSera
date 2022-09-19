import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pxsera/src/blocs/category/category_bloc.dart';

class buildIndexedCategory extends StatelessWidget {
  final int index;
  final String categoryTitle;
  const buildIndexedCategory({
    required this.index,
    required this.categoryTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, categoryState) {
        Color getSelectedColor() {
          if (categoryState is CategoryChangeState) {
            if (index == categoryState.index) {
              return const Color(0xff9DB5B2);
            }
          }
          return const Color(0xffe7e7e7);
        }

        return GestureDetector(
          onTap: () => context.read<CategoryBloc>().add(ChangedIndexCategory(selectedIndex: index)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: getSelectedColor(),
              ),
              child: Text(
                "${categoryTitle}",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff242626),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
