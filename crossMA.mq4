//+------------------------------------------------------------------+
//|                                                      crossMA.mq4 |
//|                                                        Mahdi_Hhz |
//|                                               telegram:@mahdihhz |
//+------------------------------------------------------------------+
#property copyright "Mahdi_Hhz"
#property link      "telegram:@mahdihhz"
#property version   "1.00"
#property strict


// we take input for the periods of the moving averages 

input int smallMAperiod= 20;
input int bigMAperiod = 200;
input double lotSize = 0.01;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

//define our signal to be filled later
   string signal = "";


//define Moving Averages for the last 2 candles 


   double smallMA1 = iMA(NULL,0,smallMAperiod,0,MODE_SMA,PRICE_CLOSE,1);
   double bigMA1 = iMA(NULL,0,bigMAperiod,0,MODE_SMA,PRICE_CLOSE,1);

   double smallMA2 = iMA(NULL,0,smallMAperiod,0,MODE_SMA,PRICE_CLOSE,2);
   double bigMA2 = iMA(NULL,0,bigMAperiod,0,MODE_SMA,PRICE_CLOSE,2);

//CHECKING FOR CROSS
//we check for buy crosses where smallMA crosses above BigMA 

//if the bigMA is lower than smallMA but in previous candle it was higher, then it's a BUY crossover
   if(bigMA1 < smallMA1 && bigMA2 > smallMA2)
     {
         signal = "buy";
     }

//the opposite for sell - farsi: baraksesh baraye sell
   if(bigMA1 > smallMA1 && bigMA2 < smallMA2)
     {
         signal = "sell";
     }
//OPENING POSITIONS
//if signal is buy and we have no open orders, we place a buy order
if ( signal == "buy" && OrdersTotal() == 0)
{
      OrderSend(NULL,OP_BUY,lotSize,Ask,3,Ask-(200*Point),Ask+(200*Point),NULL,0,0,clrGreen);
}
if ( signal == "sell" && OrdersTotal() == 0) {
      OrderSend(NULL,OP_SELL,lotSize,Bid,3,Bid+(200*Point),Bid-(200*Point),NULL,0,0,clrRed);
      
}
  }
//+------------------------------------------------------------------+
