# cloud_music
NetEase Music implement in flutter 基于flutter实现的网易云音乐

# tech stack(技术栈): 
    - Flutter
    - Dart
    - NetEase Cloud Music API (https://binaryify.github.io/NeteaseCloudMusicApi/#/)
    - Firebase firecloudstore
    - GetIt

# Overall Progress

# Daily Progress
8.24 Project init(项目初始化)
    - part of project framework(项目框架)
    - functional sign in page(功能性登录页面)
    - banner and search bar in home page(首页的轮播图和搜索栏)
    - search page UI(搜索页面UI)

<img height="400" src="/project_screenshot/search.png" width="200"/>

8.30 SingerList 
    - singer list UI(歌手列表UI)
    - Try to keep login status, however, the api doesn't support it(尝试保持登录状态，但是api不支持)

<img height="400" src="/project_screenshot/singerCategory.png" width="200"/>


8.31 StyleList
    - style list UI progress: 80%(风格列表UI进度：80%)

9.1 StyleList
    - style list UI progress: 100%(风格列表UI进度：100%)
    - style list to do: functionality of two scroll controllers(风格列表待做：两个滚动控制器的功能)

<img height="400" src="/project_screenshot/styleCategory.png" width="200"/>

9.2 StyleList Controller
    - left controller: 
    requirement: 
    this controller requires that when it's scroll to the offset that larger than the selected tag, 
    the selected tag is expected to be fix at the top of the screen
    (左侧控制器：该控制器要求当它滚动到大于选中标签的偏移量时，选中标签应固定在屏幕顶部)
    idea: I first created a Positioned Container that displays the text of the selected tag with the 
    same background color as the selected tag. Then, I implemented a listener for the scroll controller. 
    When the scroll controller's offset becomes greater than that of the selected tag, the Positioned 
    Container becomes visible; otherwise, it remains hidden.
    Furthermore, when re-selecting the first-level tag, I remove the existing listener and add it again. 
    This is necessary because the scroll controller's listener relies on the value of the selected tag index. 
    When we update the selected tag index, the listener doesn't automatically update, so we remove and re-add 
    it to ensure it functions correctly.
    (实现思路：我首先创建了一个定位容器，该容器显示与选中标签相同背景颜色的选中标签的文本。然后，我为滚动控制器实现了一个监听器。
    当滚动控制器的偏移量大于选中标签的偏移量时，定位容器变为可见；否则，它仍然隐藏。
    此外，当重新选择一级标签时，我删除现有的侦听器并再次添加它。这是必要的，因为滚动控制器的侦听器依赖于选定标签索引的值。
    当我们更新选定的标签索引时，侦听器不会自动更新，因此我们删除并重新添加它以确保其正确运行。)






