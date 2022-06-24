/*
* 扩展：
* 1、导航栏右侧分享按钮等其它图标 IconButton
* 2、抽屉菜单 MyDrawer
* 3、底部导航栏 BottomNavigationBar
* 4、首页、商品、设置页面 HomePage、ProductsPage、SettingPage
* 5、计数器组件（包括加减、清零、清零对话框确认、容器装饰显示功能） countButton
* 6、商品组件（包括商品图片、商品描述、容器内边距调整、滚动组件） products
* 7、使用协议 useAgreement
* 8、复选框（具有勾选功能） WBLCheckbox
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() => runApp(WBLMaterialApp());

class WBLMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tabs();
  }
}

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int currentIndex = 0;
  List _pageList = [HomePage(), ProductsPage(), SettingPage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('实验4_4'),
          actions: <Widget>[
            //导航栏右侧分享按钮
            IconButton(icon: Icon(Icons.share), onPressed: () {}),
          ],
        ),
        drawer: MyDrawer(), //抽屉
        body: _pageList[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "首页",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: "商品",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "设置",
            ),
          ],
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: countButton(),
    );
  }
}

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: products(),
    );
  }
}

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      //使用ListView使能滚动
      children: [
        useAgreement(),
        WBLCheckbox(),
      ],
    ));
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "images/avatar.png",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "王宝龙",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add message'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class countButton extends StatefulWidget {
  var message = '可加减计数器';

  @override
  State<StatefulWidget> createState() {
    return _countButtonState();
  }
}

class _countButtonState extends State<countButton> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          _showNumber(),
          SizedBox(
            height: 30,
          ),
          _showCount(),
          SizedBox(
            height: 30,
          ),
          _ElevatedButton(), //抽
          SizedBox(
            height: 30,
          ), // 取出来
          Text(
            widget.message,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _showCount() {
    return Text(
      '当前计数:$_count',
      style: TextStyle(
        fontSize: 25,
      ),
    );
  }

  Widget _ElevatedButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text(
                '+',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  _count++;
                });
              },
            ),
            SizedBox(
              width: 40,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _count--;
                });
              },
              child: Text(
                '-',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        countZero(),
      ],
    );
  }

  Future<bool?> showDeleteConfirmDialog1() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要将计数器清零吗?"),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            TextButton(
              child: Text("确认"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Widget countZero() {
    return ElevatedButton(
      child: Text(
        "计数器清零",
        style: TextStyle(
          fontSize: 27,
          color: Colors.white,
        ),
      ),
      onPressed: () async {
        //弹出对话框并等待其关闭
        bool? delete = await showDeleteConfirmDialog1();
        if (delete == null) {
          print("取消清零");
        } else {
          print("已确认清零");
          setState(() {
            _count = 0;
          });
        }
      },
    );
  }

  Widget _showNumber() {
    //容器装饰数字后显示
    String countStr = _count.toString();

    return Container(
      margin: EdgeInsets.only(top: 0.0, left: 0.0),
      constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
      //卡片大小
      decoration: BoxDecoration(
        //背景装饰
        gradient: RadialGradient(
          //背景径向渐变
          colors: [Colors.red, Colors.orange],
          center: Alignment.topLeft,
          radius: .98,
        ),
        boxShadow: [
          //卡片阴影
          BoxShadow(
            color: Colors.black54,
            offset: Offset(2.0, 2.0),
            blurRadius: 4.0,
          )
        ],
      ),
      alignment: Alignment.center,
      //卡片内文字居中
      child: Text(
        countStr,
        style: TextStyle(
          color: Colors.white,
          fontSize: 40.0,
        ),
      ),
    );
  }
}

class products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title1 = 'MacBooks';
    var title2 = 'Lenovo Laptop';
    var title3 = 'Huawei Laptop';

    var describe1 = '使用独立的macOS系统，最新的macOS系列基于NeXT系统开发，不支持兼容。是一套完备而独立的操作系统。';
    var describe2 = '配备了高素质的售后服务和技术咨询队伍，提供了三年保修和及时、迅速的上门服务，让消费者真正做到“买得放心、用得安心！';
    var describe3 = '支持MatePen手写笔，这个和SurfacePen差不多，据现场体验该手写笔支持快速操作。';

    var imageURL1 =
        'https://tva1.sinaimg.cn/large/006y8mN6gy1g72j6nk1d4j30u00k0n0j.jpg';
    var imageURL2 =
        'https://tva1.sinaimg.cn/large/006y8mN6gy1g72imm9u5zj30u00k0adf.jpg';
    var imageURL3 =
        'https://tva1.sinaimg.cn/large/006y8mN6gy1g72imqlouhj30u00k00v0.jpg';

    return ListView(
      //使用ListView使能滚动
      children: [
        WBLProductItem(title1, describe1, imageURL1),
        WBLProductItem(title2, describe2, imageURL2),
        WBLProductItem(title3, describe3, imageURL3),
      ],
    );
  }
}

//商品widget
class WBLProductItem extends StatelessWidget {
  final String title; //商品标题
  final String describe; //商品描述
  final String imageURL; //商品图片

  WBLProductItem(this.title, this.describe, this.imageURL);

  @override
  Widget build(BuildContext context) {
    final style1 = TextStyle(
      fontSize: 30,
      color: Colors.red,
    );

    final style2 = TextStyle(
      fontSize: 17,
      color: Colors.black,
    );

    return Container(
      //给每个商品widget设置一个边框
      padding: EdgeInsets.all(5), //内边距
      decoration: BoxDecoration(
        border: Border.all(
          width: 5,
          color: Colors.black,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //商品标题对齐方式
        children: [
          Text(
            title,
            style: style1,
          ),
          SizedBox(
            height: 8,
          ), //使上下之间有间距
          Text(
            describe,
            style: style2,
          ),
          SizedBox(
            height: 12,
          ),
          Image.network(
            imageURL,
            width: 400,
            height: 200,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}

class WBLCheckbox extends StatefulWidget {
  var message = '同意使用协议';

  @override
  State<StatefulWidget> createState() {
    return WBLCheckboxState();
  }
}

class useAgreement extends StatelessWidget {
  var useAgreementContent =
      '''为使用本软件及服务，您应当阅读并遵守《本软件许可协议》（以下简称（本协议）。请您务必审慎阅读，从分理解各条款内容，特别是免除或者限制责任的条款，以及开通或使用某项服务的单独协议，并选择接受或不接受。限制，免责条款可能以加粗形式提示您注意。

除非您已阅读并接受本协议所有条款，否则您无权下载，安装或使用本软件及相关服务。您的下载，安装，登录等使用行为即视为您已阅读并同意上述协议的约束。 如果您未满18周岁，请在法定监护人的陪同下阅读本协议及其他上述协议，并特别注意未成年人使用条款。

一， 协议的范围

本协议是您与本软件之间关于您下载，安装，使用，复制本软件，以及使用本软件相关服务所订立的协议。

二， 关于本服务

本服务内容是指本软件客户端软件提供包括但不限于IOS及Android等多个版本，您必须选择与所安装手机相匹配的软件版本。

三， 软件的获取

您可以直接从本软件授权的第三方获取。

如果您从未经本软件授权的第三方获取本软件或与本软件名称相同的安装程序，本软件无法保证该软件能够正常使用，并对因此给您造成的损失不予负责。下载安装程序后，您需要按照该程序提示的步骤正确安装。

为提供更加优质，安全的服务，在本软件安装时本软件可能推荐您安装其他软件，您可以选择安装或不安装。

如果您不再需要使用本软件或者需要安装新版本软件，可以自行卸载。

四， 软件的更新

为了改善用户体验，完善服务内容，本软件将不断努力开发新的服务，并为您不时提供软件更新(这些更新可能会采取软件替换，修改，功能强化，版本升级等形式)。

为了保证本软件及服务的安全性和功能的一致性，本软件有权不向您特别通知而对软件进行更新，或者对软件的部分功能效果进行改变或限制。

本软件新版本发布后，旧版本的软件可能无法使用，本软件部保证旧版本软件继续可用及相应的服务，请您随时核对并下载最新版本。

五， 其他

您使用本软件即视为您已阅读并同意接受本软件协议的约束。本软件有权在必要时修改本协议条款。如果您不接受修改后的条款，应当停止使用本软件。''';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10), //内边距
      decoration: BoxDecoration(
        border: Border.all(
          width: 5,
          color: Colors.white,
        ),
      ),
      child: DefaultTextStyle(
        //1.设置文本默认样式
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
        textAlign: TextAlign.start,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "使用协议",
              style: TextStyle(
                  fontSize: 25.0,
                  inherit: false, //不继承默认样式
                  color: Colors.black),
            ),
            Text(useAgreementContent),
          ],
        ),
      ),
    );
  }
}

class WBLCheckboxState extends State<WBLCheckbox> {
  var flag = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            value: this.flag,
            onChanged: (value) {
              setState(() {
                if (value != null) flag = value;
              });
            },
          ),
          Text(widget.message,
              style: TextStyle(
                fontSize: 22,
              ))
        ],
      ),
    );
  }
}
