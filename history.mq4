//+------------------------------------------------------------------+
//|                                                      history.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
void prinfHelp(const string str, const bool b, double val) {
  printf(str + " bool: " + b + " val: " + val);
}
const string curSb = Symbol();

int OnInit()   {
  ObjectsDeleteAll();
  int i, hstTotal = OrdersHistoryTotal();
  printf("history" + hstTotal);
  for (i = 0;i < hstTotal;i++)     {
    if (OrderSelect(i, SELECT_BY_POS, MODE_HISTORY) != false)        {
      if (curSb != OrderSymbol())continue;
      const datetime openTm = OrderOpenTime();
      const double maxPrice = MathMax(OrderOpenPrice(), OrderClosePrice());
      string name = i;
      printf("tm:" + openTm + "mp:" + maxPrice);
      int idx = iBarShift(curSb, PERIOD_D1, openTm, false);
      double val = High[idx];
      prinfHelp("hight", 0, val);
      if (ObjectCreate(name, OBJ_ARROW, 0, openTm, val + 230 * Point)) {
        printf("set:" + ObjectSet(name, OBJPROP_COLOR, Yellow));
        //return;
      }
    }
    else {
      printf("get order error! pos:" + i);
    }
  }
  return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
  const int prev_calculated,
  const datetime& time[],
  const double& open[],
  const double& high[],
  const double& low[],
  const double& close[],
  const long& tick_volume[],
  const long& volume[],
  const int& spread[])   {
  //---

  //--- return value of prev_calculated for next call
  return(rates_total);
}
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
