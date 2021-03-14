//+------------------------------------------------------------------+
//|                                                   pointValue.mq4 |
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
//+------------------------------------------------------------------+
struct Sb_Ele{
    string head;
    string back;
};

input double num = 0.1;
int numValue = num * 10;
double val = 0;

Sb_Ele getElement(string name){
    string str1 = StringSubstr(name, 0, 3);
    string str2 = StringSubstr(name, 3, 3);
    Sb_Ele temp;
    temp.head = str1;
    temp.back = str2;
    return temp;
}

int OnInit()
  {
   ObjectCreate("pvBabel", OBJ_LABEL,0,0,0);
   ObjectSet("pvBabel", OBJPROP_CORNER, CORNER_LEFT_UPPER);
   ObjectSet("pvBabel", OBJPROP_XDISTANCE, 19);
   ObjectSet("pvBabel", OBJPROP_YDISTANCE, 27);
   return(INIT_SUCCEEDED);
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
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
    if(id != CHARTEVENT_CHART_CHANGE)return;
    string chartSb = Symbol();
    string ac =AccountCurrency();
    Sb_Ele chartEle = getElement(chartSb);
         
    if(chartEle.back == ac){
        val = numValue;
    }
    else if(chartEle.head == ac){
        val = numValue / Bid;
    }
    else {
        string tmpSb = ac + chartEle.back;
        double tmpBid = MarketInfo(tmpSb, MODE_BID);

        if(tmpBid == 0){
            tmpSb = chartEle.back + ac;
            tmpBid = MarketInfo(tmpSb, MODE_BID);
            val = numValue * tmpBid;
        }
        else{
            val = numValue / tmpBid;
        }
        printf(tmpBid);
        printf(tmpSb);
    }
    if(chartEle.back == "JPY" || chartEle.head == "JPY")val *= 100;
    string text = "手:" + num + "/" + "值:" + DoubleToStr(val, 2);
    ObjectSetText("pvBabel", text, 16, "宋体", Yellow);
  }