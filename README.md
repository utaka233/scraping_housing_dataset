# 荻窪のワンルームマンションのスクレイピング
`rvest`パッケージを使って荻窪のワンルームマンション（定期借家を除いたもの）をスクレイピングしてcsvファイルにレコードした際のスクリプト。2019年4月1日作成。作成したデータセットはユニーク化などを施していないため、同じ物件の情報などが重複して含まれていることがあります。

## 1. データセットの内容
データ次元は1602行7列、欠損値なし。物件の重複があることに注意。
* name : 物件名
* value : 家賃
* area : 専有面積（m²）
* age : 築年数（年）
* distance : JR中央線荻窪駅からの徒歩距離（分）
* bath_toilet_separated : バストイレ別（1 : True, 0 : False）
* autolock : オートロック（1 : True, 0 : False）
