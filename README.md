# Find Job 模版

此模版主要是项目结构，界面布局，组件的封装，GetX的基本使用，适合新人学习，后期大家有需要的功能可以提出，我会加上

---

## 项目结构

| 文件夹      | 说明     |
|----------|--------|
| i18n     | 多语言配置  |
| models   | 数据模型   |
| pages    | 页面视图   |
| routes   | 路由配置   |
| services | 程序所需服务 |
| store    | 全局状态   |
| utils    | 常用工具   |
| widgets  | 通用组件   |

### Widgets 通用组件

| 文件名              | 说明     |
|------------------|--------|
| alert            | 警告提示   |
| avatar           | 头像     |
| bottom_app_bar   | 底部操作栏  |
| bottom_sheet     | 底部弹出层  |
| button           | 按钮     |
| card             | 卡片     |
| cell             | 单元格    |
| checkbox         | 单选、复选  |
| dialog           | 弹出层    |
| empty            | 空数据提示  |
| expansion_tile   | 折叠面板   |
| gallery          | 图片预览   |
| image            | 图片     |
| input            | 输入框    |
| list_scroll_view | 滚动列表加载 |
| loading          | 加载指示器  |
| requirement      |        |
| switch           | 切换按钮   |
| tab_bar          | Tab切换  |
| tag              | 标签     |
| toast            | 轻提示    |

### Utils 工具

| 文件名             | 说明     |
|-----------------|--------|
| access          | 权限请求   |
| assets_picker   | 资源选择   |
| console         | 打印美化   |
| constants       | 全局常量   |
| convert         | 数据转换   |
| date            | 时间格式化  |
| input_formatter | 输入框格式化 |
| screen          | 屏幕参数   |
| validator       | 正则验证   |

### Pages 页面结构

| 文件名        | 说明      |
|------------|---------|
| widgets    | 当前页面的组件 |
| controller | 逻辑层     |
| view       | 视图层     |

---

## 开始运行

```shell
$ flutter pub get
$ cd ios
$ pod install --repo-update
$ flutter run
```
