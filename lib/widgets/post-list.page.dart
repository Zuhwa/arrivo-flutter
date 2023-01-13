import 'package:arrivo_flutter/api/post.model.dart';
import 'package:arrivo_flutter/controllers/post.controller.dart';
import 'package:arrivo_flutter/providers/user.provider.dart';
import 'package:arrivo_flutter/widgets/drawer.widget.dart';
import 'package:arrivo_flutter/widgets/post-editor.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostList extends ConsumerWidget {
  static const String route = '/home';
  const PostList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final postController = ref.read(postControllerProvider);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Arrivo"),
      ),
      body: FutureBuilder(
        future: postController.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<PostResponse>> posts) {
          if (posts.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Posts"),
                      if (user != null && user.roles.contains("Admin"))
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(PostEditor.route);
                          },
                          child: const Text("Add"),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        sortColumnIndex: 0,
                        showCheckboxColumn: false,
                        columns: const [
                          DataColumn(
                            label: Text("Title"),
                          ),
                          DataColumn(
                            label: Text("Category"),
                          ),
                          DataColumn(
                            label: Text("Body"),
                          ),
                          DataColumn(
                            label: Text("Status"),
                          ),
                          DataColumn(
                            label: Text("Label"),
                          ),
                        ],
                        rows: posts.data!
                            .map(
                              (post) => DataRow(
                                onSelectChanged: (value) {
                                  if (user != null && user.roles.contains("Admin")) {
                                    Navigator.of(context).pushNamed(
                                      PostEditor.route,
                                      arguments: {
                                        "postId": post.id,
                                      },
                                    );
                                  }
                                },
                                cells: [
                                  DataCell(
                                    Text(post.title),
                                  ),
                                  DataCell(
                                    Text(post.category.name),
                                  ),
                                  DataCell(
                                    Text(post.body),
                                  ),
                                  DataCell(
                                    Text(post.status ?? ""),
                                  ),
                                  DataCell(
                                    Text(post.label),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const LinearProgressIndicator();
        },
      ),
    );
  }
}
