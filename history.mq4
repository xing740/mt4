//+------------------------------------------------------------------+
//|                                                      history.mq4 |
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
void prinfHelp(const string str, const bool b, double val)
{
  printf(str + " bool: " + b + " val: " + val);
}
const string curSb = Symbol();

int OnInit()
{
  ObjectsDeleteAll();
  int i, hstTotal = OrdersHistoryTotal();
  printf("history" + hstTotal);
  for (i = 0; i < hstTotal; i++)
  {
    if (OrderSelect(i, SELECT_BY_POS, MODE_HISTORY) != false)
    {
      if (curSb != OrderSymbol())
        continue;
      const datetime openTm = OrderOpenTime();
      string name = i;
      int idx = iBarShift(curSb, PERIOD_D1, openTm, false);
      const int type = OrderType();
      double createPos = 0;
      ENUM_OBJECT createType;
      if (type == OP_BUY || type == OP_BUYLIMIT || type == OP_BUYSTOP)
      {
        createPos = Low[idx] - 230 * Point;
        createType = OBJ_ARROW_UP;
      }
      else
      {
        createPos = High[idx] + 230 * Point;
        createType = OBJ_ARROW_DOWN;
      }
      if (ObjectCreate(name, createType, 0, openTm, createPos))
      {
        printf("set:" + ObjectSet(name, OBJPROP_COLOR, Yellow));
      }
    }
    else
    {
      printf("get order error! pos:" + i);
    }
  }
  return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
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
  //---

  //--- return value of prev_calculated for next call
  return (rates_total);
}
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
