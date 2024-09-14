import { isCancel } from '@ohos/axios'
@Observed
export class CalendarEvent {
  name: string
  isComplete: boolean
  incompleteValue: string
  completeValue: string
  cnbb: string
  year: number
  month: number
  day: number
  date: Date
  no: number
  prog: number
  context: string

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
    name: "算法导论",
    isComplete: false,
    incompleteValue: "Thomas H. Cormen 等",
    completeValue: "成绩：120 分",
    year: 2024,
    month: 9,
    day: 12,
    date: new Date('2024-9-12'),
    cnbb: "所以我认为浪费时间在这个补基础的点，不值。与其这样",
    no: 0,
    prog: 25,
    context: "《算法导论》自第一版出版以来，已经成为世界范围内广泛使用的大学教材和专业人员的标准参\
    本书深入浅出，全面地介绍了计算机算法。对每一个算法的分析既易于理解又十分有趣，并保持了数学严谨性。本书的设计目标全面，适用于多种用途。涵盖的内容有"
  },
  {
    name: "现代操作系统",
    isComplete: false,
    incompleteValue: "AnderwS.Tanenbaum",
    completeValue: "已结课",
    year: 2024,
    month: 9,
    day: 2,
    date: new Date('2024-9-2'),
    cnbb: "Andrew S. Tanenbaum教授编写的教材《现代操作系统》现在已经是第...",
    no: 1,
    prog: 40,
    context: "《算法导论》自第一版出版以来，已经成为世界范围内广泛使用的大学教材和专业人员的标准参\
    本书深入浅出，全面地介绍了计算机算法。对每一个算法的分析既易于理解又十分有趣，并保持了数学严谨性。本书的设计目标全面，适用于多种用途。涵盖的内容有"
  },
  {
    name: "深入理解计算机系统",
    isComplete: false,
    incompleteValue: "Bryant,R.E. 等",
    completeValue: "已读完",
    year: 2024,
    month: 8,
    day: 23,
    date: new Date('2024-8-23'),
    cnbb: "本书 [5]主要介绍了计算机系统的基本概念，包括最底层执本",
    no: 2,
    prog: 72,
    context: "《算法导论》自第一版出版以来，已经成为世界范围内广泛使用的大学教材和专业人员的标准参 \
    本书深入浅出，全面地介绍了计算机算法。对每一个算法的分析既易于理解又十分有趣，并保持了数学严谨性。本书的设计目标全面，适用于多种用途。涵盖的内容有"
  }
]

