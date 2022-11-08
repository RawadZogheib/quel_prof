import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:quel_prof/controller/chat/provider_chat.dart';
import 'package:quel_prof/controller/settings_provider/provider_theme.dart';
import 'package:quel_prof/widgets/other/MyCustomScrollBehavior.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () async {
      if (mounted) {
        await Provider.of<ProviderChat>(context, listen: false)
            .onInitState(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Consumer<ProviderChat>(builder: (context, providerChat, _) {
        return Column(
          children: [
            Expanded(
              child: !providerChat.isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ScrollConfiguration(
                        behavior: MyCustomScrollBehavior()
                            .copyWith(overscroll: false, scrollbars: false),
                        child: SingleChildScrollView(
                          controller: providerChat.scrollController,
                          reverse: true,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: providerChat.children,
                          ),
                        ),
                      ),
                    )
                  : const Center(
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator()),
                    ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4.0, right: 8.0, left: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                  color: Colors.transparent.withOpacity(
                      Provider.of<ProviderTheme>(context).themeMode == 'dark'
                          ? 0.5
                          : 0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(22.0))),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        // onTap: () => !isKeyboardVisible
                        //     ? Provider.of<ProviderChat>(context, listen: false)
                        //         .scrollDown()
                        //     : null,
                        controller: providerChat.textEditingController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          hintText: 'Message',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.8)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onPressed: () => providerChat.sendMessage(context),
                      icon: const Icon(Icons.send))
                ],
              ),
            ),
            !isKeyboardVisible
                ? SizedBox(height: MediaQuery.of(context).size.height * 0.1)
                : const SizedBox.shrink(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          ],
        );
      });
    });
  }
}
