import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pxsera/constants/style_constant.dart';
import 'package:pxsera/src/blocs/category/category_bloc.dart';
import 'package:pxsera/src/blocs/search/search_bloc.dart';
import 'package:pxsera/src/ui/search/components/buildCategory.dart';
import 'package:pxsera/src/ui/search/components/searchCollectionView.dart';
import 'package:pxsera/src/ui/search/components/searchPhotoView.dart';
import 'package:pxsera/src/ui/search/components/searchUserView.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with AutomaticKeepAliveClientMixin {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: NestedScrollView(
            floatHeaderSlivers: true,
            clipBehavior: Clip.none,
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 60,
                    bottom: 0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Cùng khám phá nào!", style: kTitleSearchScreen),
                      Container(height: 20),
                      TextFormField(
                        onFieldSubmitted: (value) {
                          context.read<SearchBloc>().add(SearchWithQueryEvent(query: value));
                        },
                        controller: _controller,
                        style: const TextStyle(
                          color: Color(0xff242626),
                        ),
                        maxLength: 22,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: const Color(0xff242626),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                          filled: true,
                          fillColor: const Color(0xffe7e7e7),
                          counterText: "",
                          hintText: "Nhập vào từ khóa",
                          hintStyle: kTextFieldEnabled,
                          suffixIcon: GestureDetector(
                            onTap: () => context.read<SearchBloc>().add(
                                  SearchWithQueryEvent(query: _controller.text),
                                ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: const Color(0xff242626),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Icon(
                                    EvaIcons.search,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          suffixIconConstraints: const BoxConstraints(
                            minWidth: 25,
                            minHeight: 25,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xfff3f3f5),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xfff3f3f5),
                            ),
                          ),
                        ),
                      ),
                      Container(height: 15),
                      Row(
                        children: [
                          buildIndexedCategory(
                            index: 0,
                            categoryTitle: "Ảnh",
                          ),
                          buildIndexedCategory(
                            index: 1,
                            categoryTitle: "Người dùng",
                          ),
                          buildIndexedCategory(
                            index: 2,
                            categoryTitle: "Collections",
                          ),
                        ],
                      ),
                      Container(height: 20),
                    ],
                  ),
                ),
              ),
            ],
            body: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, categoryState) {
                if (categoryState is CategoryChangeState) {
                  return IndexedStack(
                    index: categoryState.index,
                    children: [
                      const searchPhotoView(),
                      const searchUserView(),
                      const searchCollectionView(),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
