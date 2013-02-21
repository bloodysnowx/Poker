1. ハンドを読み込む IHandReader <- PokerStarsReader
2. 読み込んだファイルを共通の形式に変換する HandObject
3. ハンドを再生する <- HandPlayer

HandObject
a. 開始状況(Playerの配列)
b. PreFlop Actionの配列
c. Flop Actionの配列
d. Turn Actionの配列
e. River Actionの配列
f. Flop(Cardの配列)
g. Turn(Card)
h. River(Card)
i. show down(
j. chipの処理

Player
a. name
b. seat
c. position
d. chips
e. hand
f. stats
g. memo

Action
a. Player
b. play(fold, check, call, bet, raise, muck, show, collect)
c. chips
