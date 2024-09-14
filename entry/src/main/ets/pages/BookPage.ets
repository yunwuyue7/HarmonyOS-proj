import { CalendarEvent, calendarEventData } from '../model/Book'
import router from '@ohos.router'

@Preview
@Component
export struct BookPage {
  scroller:Scroller = new Scroller()
  @State calendarEvents:CalendarEvent[] = calendarEventData

  build() {
    Column() {
      // header
      Row(){
        Column() {
          Text('我的书籍')
            .fontWeight(FontWeight.Bold)
            .height(35)
            .fontSize(18)
        }
        .width('25%')
        .padding(10)
        .margin({ top: 10 })
        Column(){
        }
        .width('50%')
        Column() {
          Text('添加书籍')
            .fontWeight(FontWeight.Bold)
            .height(35)
            .fontSize(18)
            .fontColor(Color.Blue)
        }
        .width('25%')
        .padding(10)
        .margin({ top: 10 })
        .onClick(()=>{  // 点击事件卡，修改事件
          let newCalendarEvent = new CalendarEvent()
          this.calendarEvents.push(newCalendarEvent)
        })
      }
      Divider()
        .color(Color.Black)
        .margin({ left: 20, right: 20, top: 10 })


      List() {
        ForEach(this.calendarEvents, (calendarEvent) => {
          ListItem() {            CalendarEventItem({ calendarEvent:calendarEvent })
          }
        })
        ListItem().height(150).selectable(false)  // 占位符，不然最后一个项目在屏幕外
      } // List
      .width('100%')
      .height('100%')
      .alignListItem(ListItemAlign.Center)
    } // 最外层 Column
    .height('100%')
    .width('100%')
  }
}

// 自定义日历事件组件
@Component
struct CalendarEventItem {
  @State calendarEvent:CalendarEvent = calendarEventData[0]

  dialogController:CustomDialogController = new CustomDialogController({
    builder:ModifyEventDialog({
      calendarEvent:this.calendarEvent,
      isComplete:this.calendarEvent.isComplete
    }),
    customStyle:true, // 允许使用自定义的弹窗样式
    autoCancel:true  // 允许点击遮障层退出
  })

  build() {
    // 录取详情
    Row({space:15}) {
      if (this.calendarEvent.isComplete) {
        Image('badges/book.png')
          .height(60)
          .width(60)
      }
      else {
        Image('badges/book.png')
          .height(60)
          .width(60)
      }

      Column() {
        Text(this.calendarEvent.name)
          .height(30)
          .fontSize(25)
          .fontWeight(FontWeight.Bold)

        if (this.calendarEvent.isComplete) {
          Text(this.calendarEvent.completeValue)
            .height(20)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
        }
        else {
          Text(this.calendarEvent.incompleteValue)
            .height(20)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)

          Text(this.calendarEvent.year.toString() + '/' + this.calendarEvent.month.toString() + '/' + this.calendarEvent.day.toString())
            .height(20)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
        }
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('90%')
    .padding(10)
    .margin({ top: 10 })
    .borderRadius(10)
    .shadow({ radius: 20 })
    .onClick(()=>{  // 点击事件卡，修改事件
      this.dialogController.open()
    })
  } // build
}

// 自定义弹窗
@Preview
@CustomDialog
struct ModifyEventDialog{
  calendarEvent:CalendarEvent = calendarEventData[0]
  @Prop isComplete:boolean
  controller:CustomDialogController

  build(){
    Column() {
      Text("修改计划")
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Column() {
        // 事件名称
        Row({ space:10 }) {
          Text("书名")
          TextInput({ placeholder: '请输入书名', text:this.calendarEvent.name })
            .inputStyle()
            .onChange((value)=>{
              this.calendarEvent.name = value
            })
        }
        .padding({ top:0 })

        // 事件详情
        Row({ space:10 }) {
            Text("作者")
            TextInput({ placeholder: '请输入作者', text:this.calendarEvent.incompleteValue })
              .inputStyle()
              .onChange((value)=>{
                this.calendarEvent.incompleteValue = value
              })
          }
          .padding({ top:15 })


        // deadline

          Row({ space:10 }) {
            Text("笔记")
            TextInput({ placeholder: '请输入笔记', text:this.calendarEvent.cnbb })
              .inputStyle()
              .onChange((value)=>{
                this.calendarEvent.cnbb = value
              })
            }
          .padding({ top:15 })

        Text("开始阅读")
          .onClick(()=>{
                router.pushUrl({url: 'pages/Read', params: {aa: this.calendarEvent.context}})
            }
          )
          .margin({top: 15})
          .fontWeight(FontWeight.Bold)
          .height(35)
          .fontSize(18)
          .fontColor(Color.Blue)
          .width("100%")

      } // 主体 Column
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding({ top:20 })
    } // 最外层 Column
    .backgroundColor(Color.White)
    .width('80%')
    .padding(20)
    .borderRadius(10)
  }
}

@Extend(TextInput) function inputStyle() {
  .height(40)
  .layoutWeight(1)
  .fontSize(14)
}
