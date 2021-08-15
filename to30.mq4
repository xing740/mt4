//+------------------------------------------------------------------+
//|                                                         to30.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link "https://www.mql5.com"
#property version "1.00"
#property strict
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
void OnInit()
{
  //--- 启用 CHART_EVENT_MOUSE_MOVE 信息
  ChartSetInteger(0, CHART_EVENT_MOUSE_MOVE, 1);
  ////--- 禁用图表的上下文菜单（在右侧）
  //ChartSetInteger(0, CHART_CONTEXT_MENU, 0);
  ////--- 禁用十字准线（通过中间按钮）
  //ChartSetInteger(0, CHART_CROSSHAIR_TOOL, 0);
  ////--- 强制更新图表属性确保做好事件处理的准备
  //ChartRedraw();
}
//+------------------------------------------------------------------+
//| 鼠标点选位置                                                       |
//+------------------------------------------------------------------+
string MouseState(uint state)
{
  string res;
  res += "\nML: " + (((state & 1) == 1) ? "DN" : "UP");    // 鼠标左按键
  res += "\nMR: " + (((state & 2) == 2) ? "DN" : "UP");    // 鼠标右按键
  res += "\nMM: " + (((state & 16) == 16) ? "DN" : "UP");  // 鼠标中按键
  res += "\nMX: " + (((state & 32) == 32) ? "DN" : "UP");  // 鼠标第一个 X 键
  res += "\nMY: " + (((state & 64) == 64) ? "DN" : "UP");  // 鼠标第二个 X 键
  res += "\nSHIFT: " + (((state & 4) == 4) ? "DN" : "UP"); // shift 键
  res += "\nCTRL: " + (((state & 8) == 8) ? "DN" : "UP");  // control 键
  return (res);
}
//+------------------------------------------------------------------+
//| ChartEvent 函数                                                   |
//+------------------------------------------------------------------+
bool ctrl = false;
void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
  int bars = WindowFirstVisibleBar(); //图表左边第一根k
  if (id == CHARTEVENT_MOUSE_MOVE)
  {
    ctrl = ((uint)sparam & 8) == 8 ? true : false;
    //Comment("POINT: ", (int)lparam, ",", (int)dparam, "\n", MouseState((uint)sparam));
  }
  if (id == CHARTEVENT_CLICK && ctrl && _Period == PERIOD_D1)
  {
    int x = (int)lparam;
    int y = (int)dparam;
    datetime click_tm = 0;
    double price = 0;
    int window = 0;
    ChartXYToTimePrice(0, x, y, window, click_tm, price);

    int move_num = Bars(NULL, PERIOD_M30, Time[bars - 1], click_tm);

    ChartSetSymbolPeriod(0, NULL, PERIOD_M30);

    ChartNavigate(0, CHART_CURRENT_POS, move_num);
  }
}

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
  return (rates_total);
}