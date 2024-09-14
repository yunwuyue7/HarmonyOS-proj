import { isCancel } from '@ohos/axios'
@Observed
export class CalendarEvent {
  name: string
  isComplete: boolean
  incompleteValue: string
  completeValue: string
  year: number
  month: number
  day: number
  date: Date

  constructor(name = '新的事件', isComplete = false, incompleteValue = '未完成', completeValue = '已完成', date = new Date()) {
    this.name = name
    this.isComplete = isComplete
    this.incompleteValue = incompleteValue
    this.completeValue = completeValue
    this.date = date
    this.year = date.getFullYear()
    this.month = date.getMonth() + 1
    this.day = date.getDate()
  }
}

export var calendarEventData: CalendarEvent[] = [
  {
    name: "TOEFL词汇精选",
    isComplete: false,
    incompleteValue: "背前三章",
    completeValue: "成绩：120 分",
    year: 2024,
    month: 1,
    day: 1,
    date: new Date('2024-1-1')
  },
  {
    name: "计算机体系结构",
    isComplete: false,
    incompleteValue: "精读流水线部分",
    completeValue: "已结课",
    year: 2024,
    month: 3,
    day: 1,
    date: new Date('2024-3-1')
  },
  {
    name: "繁花",
    isComplete: false,
    incompleteValue: "阅读第拾叁章",
    completeValue: "已读完",
    year: 2024,
    month: 5,
    day: 1,
    date: new Date('2024-5-1')
  }
]

