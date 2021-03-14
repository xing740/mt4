//+------------------------------------------------------------------+
//|                                                   pointValue.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
struct Sb_Ele{
    string head;
    string back;
};

Sb_Ele getElement(string name){
    string str1 = StringSubstr(name, 0, 3);
    string str2 = StringSubstr(name, 3, 3);
    Sb_Ele temp;
    temp.head = str1;
    temp.back = str2;
    return temp;
}
int judgeType(string ame){
    string chartSb = Symbol();
    string ac =AccountCurrency();
    Sb_Ele chartEle = getElement(chartSb);
    if(chartEle.back == ac){
        return 10;
    }
    else if(chartEle.head == ac){
        return 10 / Bid
    }
    else {
        
    }
}

void calPointValue(type){
    if(tgype)
}

void OnStart()
  {
    string cur = Symbol();
   Sb_Ele chartEle = getElement(cur);
    printf("sdfasdf");
    printf(chartEle.head);
    printf(chartEle.back);
    printf("sdfasdf");
  }