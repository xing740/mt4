//+------------------------------------------------------------------+
//|                                                        trade.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
extern float volume = 0.5;
void OnStart()
  {
    int res = OrderSend(Symbol(), OP_BUYLIMIT, volume, Ask - 300 * Point, 100, Ask - 600 * Point, 0, "xx", 1, 0, Green);
    if(res < 0) {
      Print("error! info #", GetLastError());
    }
  }
//+------------------------------------------------------------------+
