Fortran用サンプル集  

====  
学習・研究用にFortranで作成したトイモデル等の実装サンプルです。
コピペ等ご自由にご利用ください。

## File List
mpi/sendrev.f90  
mpi/put_get.f90  
2つのノードにそれぞれ長さ20のメモリ領域を確保し、並列実行するにあたって前10領域と後10領域をノード間通信で交換するスクリプト。  
sendrev.f90は通信プロトコルを使用してデータを送受信するサンプル。  
put_get.f90は相手側のメモリを直接書き換えるサンプル。

lorenz96.f95  
Lorenz(1996) [^1]によって用いられた1次元40変数モデルの実装。  
Lorenz'96 model

## Reference
[^1]:
Lorenz, Edward N. "Predictability: A problem partly solved." Proc. Seminar on predictability. Vol. 1. No. 1. 1996.

## Author

[0kawana](https://github.com/0kawana)
