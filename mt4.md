1.ea使用 
加载：文件-数据文件夹-mt5-experts
打开新窗口，托入指标，正常打勾(好像只需打勾主标题),设置参数，点击ea交易，
通过底部工具栏"ea交易"查看加载是否成功，查看日志可看交易信息。
某些ea需要自定义指标，需要把作者的自定义指标放到相应文件夹

ontick()价格每波动一次，就触发一次，所以ea逻辑写在这个函数中

2.指标使用
....indicators
int OnCalculate(....):很多事件会触发这个函数,价格跳动一次都
会触发，所以为了效率，可在有新的k线生成时，才执行某些逻辑。
eg:rates_total(当有k线数)-prev_calculated(上次触发时的rates_total值) > 0;
自定义指标：
1.通过导航定义输入变量和绘制的属性变量(线、箭头...(也可通过函数设置))
2.#property indicator_chart_window  表示指标在主图上显示
3.绘制变量的显示原理，是通过找到每个点的坐标，如果是线，就是每个点相连，如果是箭头，就是在点的坐标位画个箭头就好。每个绘制变量都有单独的一个数组，点的纵坐标是容器的idx(0是最新的k线)，横坐标是idx对应的值。

3.脚本使用
....scripts
托入如果没有执行，工具-选项-ea交易里设置（相当于总开关）
void onstart();托入时执行一次

绘制变量:就是一个属性，可用objectCreate创建对象
4.触发事件
某个函数有多种原因会触发时，触发的原因会通过参数传入

5.定时器
int OnInit()
  {
   EventSetTimer(2);//在初始化时，默认设置了定时器触发时间周期
   return(INIT_SUCCEEDED);
  }
6.void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
id:捕获的事件
后几个参数根据捕获到的事件而定：
eg:lp 可能这个阿诗玛值，dp：当前对象位置的价格，sp:对象的名称

7.extern
脚本加载时由用户决定的变量值。

8.input
const类型的extern 

9.predefined Variables:预定义变量，获取当天货币的信息
10.Technical Indicator Functions 技术指标的使用
调用对应函数，填入指标的参数(相当于拖入指标时，填入的参数)
调用自定义指标：iCustom(....),自定义指标上可能有多种绘制属性，每种绘制属性通过Idx找到，用瞄准器可查找绘制属性的Idx

11.创建图表上的对象
bool ObjectCreate(string name, int type, int window, datetime time1, double price1, void time2, void price2, void time3, void price3); 
windom:例主图表和指标图表

对象还有很多属性，上面的函数没有体现出来，可用ObjectGet()设置对象的其它属性。
OBJ_LABEL:是固定位置的，所以window后的两个参数是像素的意思，以
左上角为圆点。

12.系统的枚举类型都不需要加“”



美元账户,标准手
1.第二个货币是美元，   点值：10
2.第一个货币是美元，  10 / 当前价
3.日元特殊处理
4.交叉货币  eg:eur/gdb 如果账户是gdb，刚点值是10gdb，如果 usd/gdb当前是1.5，说明1usd是1.5,所以要算10gdb等于多少usd是10gdb / 1.5


ctrl + 点

