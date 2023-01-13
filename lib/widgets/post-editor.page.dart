import 'package:arrivo_flutter/api/post.model.dart';
import 'package:arrivo_flutter/controllers/post.controller.dart';
import 'package:arrivo_flutter/providers/category.provider.dart';
import 'package:arrivo_flutter/widgets/post-list.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostEditor extends ConsumerWidget {
  static const String route = '/postEditor';
  const PostEditor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    final postId = args?["postId"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
      ),
      body: postId == null
          ? Editor()
          : FutureBuilder(
              future: ref.read(postControllerProvider).getPost(postId),
              builder: (context, post) {
                if (!post.hasData) {
                  return const LinearProgressIndicator();
                }

                return Editor(
                  post: post.data,
                );
              },
            ),
    );
  }
}

class Editor extends ConsumerStatefulWidget {
  final PostResponse? post;
  Editor({super.key, this.post});

  @override
  ConsumerState<Editor> createState() => _EditorState();
}

class _EditorState extends ConsumerState<Editor> {
  final _formKey = GlobalKey<FormState>();
  String? categoryIdController;
  String? statusController;
  String? labelController;

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);

    final titleController = TextEditingController(text: widget.post?.title);
    final bodyController = TextEditingController(text: widget.post?.body);

    final navigator = Navigator.of(context);

    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 600,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    label: Text("Category"),
                  ),
                  value: widget.post?.category.id,
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category.id,
                      child: Text(category.name),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Category is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      categoryIdController = value;
                    });
                  },
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    label: Text("Label"),
                  ),
                  value: widget.post?.label,
                  items: ["NORMAL", "PREMIUM"].map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Label is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      labelController = value;
                    });
                  },
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    label: Text("Status"),
                  ),
                  value: widget.post?.status,
                  items: ["DRAFT", "PENDING_REVIEW", "PUBLISHED"].map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Status is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      statusController = value;
                    });
                  },
                ),
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    label: Text("Title"),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: bodyController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    label: Text("Body"),
                  ),
                  // initialValue: widget.post?.body,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Body is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (widget.post != null) {
                              await ref.read(postControllerProvider).patchPost(
                                    widget.post!.id,
                                    title: titleController.text,
                                    categoryId: categoryIdController ?? widget.post?.category.id,
                                    status: statusController ?? widget.post?.status,
                                    label: labelController ?? widget.post?.label,
                                    body: bodyController.text,
                                  );
                            } else {
                              await ref.read(postControllerProvider).createPost(
                                    title: titleController.text,
                                    categoryId: categoryIdController!,
                                    status: statusController!,
                                    label: labelController!,
                                    body: bodyController.text,
                                  );
                            }

                            navigator.pushNamedAndRemoveUntil(PostList.route, (route) => false);
                          }
                        },
                        child: Text(widget.post != null ? "Save" : "Create"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
