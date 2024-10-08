import { CirclePage } from './CirclePage';
import { MinePage } from './MinePage';
import { PracticePage } from './PracticePage';
import { UniversityInfoPage } from './UniversityInfoPage';
import { CalendarPage } from './CalendarPage';
import { BookPage } from './BookPage'
import router from '@ohos.router';

@Entry
@Component
struct Index {
  @StorageLink('currentTabIndex') currentTabIndex: number = 0;  // 被选中的页签索引

  build() {
    Tabs({index:this.currentTabIndex}){ // index 指示 Tabs 显示哪个页面
      TabContent() {
        BookPage()
   //       Text('开始阅读之旅')
   //         .fontColor('#000080')
   //         .fontSize(32)
   //         .onClick(() => {
   //           router.pushUrl({ url: 'pages/Read' })
        //         })
      }.tabBar(this.barBuilder(0, '阅读', $r('app.media.ic_circle'), $r('app.media.ic_circle_selected')))

      TabContent(){
        UniversityInfoPage()
      }.tabBar(this.barBuilder(1, '推荐', $r('app.media.ic_practice'), $r('app.media.ic_practice_selected')))

      TabContent(){
        CalendarPage()
      }.tabBar(this.barBuilder(2, '计划', $r('app.media.ic_circle'), $r('app.media.ic_circle_selected')))

      TabContent(){
        MinePage()
      }.tabBar(this.barBuilder(3, '我的', $r('app.media.ic_mine'), $r('app.media.ic_mine_selected')))

      TabContent(){
        CirclePage()
      }.tabBar(this.barBuilder(4, '动态', $r('app.media.ic_circle'), $r('app.media.ic_circle_selected')))

    }.barPosition(BarPosition.End)  // 导航栏位于页面底部
    .onChange((index) => {  // 选择新的页签时，修改被选中的页签索引
      this.currentTabIndex = index;
    })
    }

  // 自定义页签结构，根据被选中的页签索引决定每一个页签的样式
  @Builder barBuilder(index: number, title: string, icon: Resource, iconSelected: Resource) {
    Column() {
      Image(this.currentTabIndex === index ? iconSelected : icon)
        .width(25)
        .height(25)
      Text(title)
        .tabTitleStyle(this.currentTabIndex === index ? Color.Black:'#959595')
    }
  }
}

@Extend(Text) function tabTitleStyle(color: ResourceColor) {
  .fontSize(10)
  .fontWeight(FontWeight.Medium)
  .fontColor(color) //Color.Black
  .margin({ bottom: 2 })
}