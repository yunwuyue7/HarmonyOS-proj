/*
 * Copyright (c) 2022-2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import router from '@ohos.router'
import util from '@ohos.util'
import fs from '@ohos.file.fs'
import picker from '@ohos.file.picker'
import Logger from '../model/Logger'
import mediaQuery from '@ohos.mediaquery';
import abilityAccessCtrl from '@ohos.abilityAccessCtrl'
import common from '@ohos.app.ability.common'

const TAG: string = 'Index'
const EXIT: string = 'exit'
const DATA_CHANGE: string = 'dataChange'
@Entry
@Component
struct Index {
  // @State res: string = router.getParams()["aa"]
  @State res: string = router.getParams()["aa"]
  @State uri: string = 'uri'
  @State strProg: string = '0'
  @State progress: number = 0
  @State fontSize: number = 15 //初始字号
  @State maxOffset: number = 0
  @State curOffset: number = 0
  @State isLand: boolean = false
  @State result: string = ''
  // @State @Watch('dataChange') expression: string = ''
  @State isDistributed: boolean = false
  @State isShow: boolean = false
  private scroller: Scroller = new Scroller()
  // private kvStoreModel: KvStoreModel = new KvStoreModel()
  // private remoteDeviceModel: RemoteDeviceModel = new RemoteDeviceModel()
  // private listener = mediaQuery.matchMediaSync('screen and (min-aspect-ratio: 1.5) or (orientation: landscape)')
  // dataChange() {
  //   Logger.info(TAG, `dataChange, expression = ${this.expression}`)
  //   this.kvStoreModel.put(DATA_CHANGE, this.expression)
  // }
  getProgress(): void {
    if (this.maxOffset != 0) {
      this.progress = (this.scroller.currentOffset().yOffset / this.maxOffset * 100)
      if (this.progress < 0) {
        this.progress = 0
      }
      this.strProg = this.progress.toFixed(0)
      if(this.strProg == "-0"){
        this.strProg = "0"
      }
    }
  }

  fixProgress(): void {
    this.scroller.scrollEdge(Edge.End)
    this.maxOffset = this.scroller.currentOffset().yOffset
    // this.scroller.scrollEdge(Edge.Top)
    // this.scroller.scrollBy(0, this.progress * this.maxOffset / 100)
  }

  importURI(): void {
    let textSelector = new picker.DocumentSelectOptions();
    let documentViewPicker = new picker.DocumentViewPicker(); // 创建文件选择器实例
    documentViewPicker.select(textSelector).then((DocumentSelectResult) => {
      this.uri = DocumentSelectResult[0]
    })
  }

  importText(): void {
    let file = fs.openSync(this.uri);
    let buf = new ArrayBuffer(64 * 1024 * 1024); //缓冲区为64Mb
    let rd = new util.TextDecoder("utf-8", { ignoreBOM: true })
    fs.read(file.fd, buf, (err, readLen) => {
      this.res = rd.decode(new Uint8Array(buf.slice(0, readLen)))
      fs.closeSync(file)
    })
    this.fixProgress()
  }
  // async aboutToAppear() {
  //   this.listener.on('change', this.onLand)
  //   let context = getContext(this) as common.UIAbilityContext
  //   let atManager = abilityAccessCtrl.createAtManager()
  //   try {
  //     atManager.requestPermissionsFromUser(context, ['ohos.permission.DISTRIBUTED_DATASYNC']).then((data) => {
  //       Logger.info(TAG, `data: ${JSON.stringify(data)}`)
  //     }).catch((err: object) => {
  //       Logger.info(TAG, `err: ${JSON.stringify(err)}`)
  //     })
  //   } catch (err) {
  //     Logger.info(TAG, `catch err->${JSON.stringify(err)}`)
  //   }
  //   Logger.info(TAG, `grantPermission,requestPermissionsFromUser`)
  //   let isRemote: string | undefined = AppStorage.get('isRemote')
  //   if (isRemote === 'isRemote' ? true : false) {
  //     this.isDistributed = true
  //     this.isShow = true
  //   }
  //   this.kvStoreModel.setOnMessageReceivedListener(context, DATA_CHANGE, (value: string) => {
  //     Logger.debug(TAG, `DATA_CHANGE: ${value},this.isDistributed = ${this.isDistributed}`)
  //     if (this.isDistributed) {
  //       if (value.search(EXIT) !== -1) {
  //         Logger.info(TAG, `EXIT ${EXIT}`)
  //         context.terminateSelf((error) => {
  //           Logger.error(TAG, `terminateSelf finished, error= ${error}`)
  //         })
  //       } else {
  //         if (value === 'null') {
  //           this.expression = ''
  //         } else {
  //           this.expression = value
  //         }
  //         // if (this.isOperator(this.expression.substr(this.expression.length - 1, this.expression.length))) {
  //         this.result = "1"
  //         // } else {
  //         //   this.result = "1"
  //         // }
  //       }
  //     }
  //   })
  // }
  build() {
    Row() {
      Column() {
        // TitleBarComponent({
        //   isLand: this.isLand,
        //   startAbilityCallBack: this.startAbilityCallBack,
        //   remoteDeviceModel: this.remoteDeviceModel,
        //   isDistributed: $isDistributed,
        //   isShow: this.isShow
        // })
        Row() {
          Select([{ value: '10vp' }, { value: '15vp' }, { value: '20vp' }, { value: '25vp' }, { value: '30vp' }, {
            value: '35vp'
          }])
            .backgroundColor("##FFFFFF")
            .fontColor(Color.Black)
            .selected(1)
            .value('字号')
            .font({ size: 15 })
            .fontColor('#182431')
            .selectedOptionFont({ size: 25, weight: 400 })
            .optionFont({ size: 15, weight: 400 })
            .onSelect((index: number) => {
              this.fontSize = 5 * (index + 2)
            })
            .margin({ left: 5, right: 5 })
            .layoutWeight(1)
          Button("选择文件")
            .onClick((event: ClickEvent) => {
              this.importURI()
            })
            .backgroundColor("##FFFFFF")
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Normal)
            .fontSize(15)
            .margin({ left: 5, right: 5 })
            .layoutWeight(1)
          Button("开始阅读")
            .onClick((event: ClickEvent) => {
              if (this.uri != 'uri') {
                this.importText()
              }
            })
            .backgroundColor("##FFFFFF")
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Normal)
            .fontSize(15)
            .margin({ left: 5, right: 5 })
            .layoutWeight(1)
          Button("同步进度")
            .onClick((event: ClickEvent) => {
              this.fixProgress()
            })
            .backgroundColor("##FFFFFF")
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Normal)
            .fontSize(15)
            .margin({ left: 5, right: 5 })
            .layoutWeight(1)
        }
        .height("8%")

        Row() {
          Scroll(this.scroller) {
            Text(this.res)
              .fontSize(this.fontSize)
              .width('100%')
            // .onClick(() => this.fixProgress())

          }

          .onScroll((() => this.getProgress()))
          .scrollable(ScrollDirection.Vertical)
          .scrollBar(BarState.Auto)
          .scrollBarColor(Color.Gray)
          .scrollBarWidth(10)
          // .onScrollStop((() => this.getProgress()))
        }
        .height("84%")

        Row() {
          Text(this.strProg + "%")
            .backgroundColor("#FFFFFF")
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Normal)
            .fontSize(15)
          Button("回到开头")
            .backgroundColor("#FFFFFF")
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Normal)
            .fontSize(15)
            .onClick(() => {
              this.scroller.scrollEdge(Edge.Top)
              this.getProgress()
            })
          Button("去到结尾")
            .backgroundColor("#FFFFFF")
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Normal)
            .fontSize(15)
            .onClick(() => {
              this.scroller.scrollEdge(Edge.End)
              this.getProgress()
            })
          Button("前进10%")
            .backgroundColor("#FFFFFF")
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Normal)
            .fontSize(15)
            .onClick(() => {
              if (this.progress > 90) {
                this.scroller.scrollEdge(Edge.End)
              } else {
                this.scroller.scrollBy(0, 0.1 * this.maxOffset)
              }
              this.getProgress()
            })
          Button("后退10%")
            .backgroundColor("#FFFFFF")
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Normal)
            .fontSize(15)
            .onClick(() => {
              if( this.progress < 10){
                this.scroller.scrollEdge(Edge.Top)

              } else {
                this.scroller.scrollBy(0, -0.1 * this.maxOffset)

              }
              this.getProgress()
            })
        }
        .height("8%")
      }
      .size({ width: '100%', height: '100%' })
    }
  }
}
