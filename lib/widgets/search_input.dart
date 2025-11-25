import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onSubmitted;

  const SearchInput({super.key, required this.hint, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}