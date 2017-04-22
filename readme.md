## Fortran用サンプル集  

=====  
学習・研究用にFortranで作成したトイモデル等の実装サンプル。


### File List  

* mpi/sendrev.f90
* mpi/put_get.f90  
2つのノードにそれぞれ長さ20のメモリ領域を確保し、並列実行するにあたって前10領域と後10領域をノード間通信で交換するスクリプト。  
sendrev.f90は通信プロトコルを使用してデータを送受信するサンプル。  
put_get.f90は相手側のメモリを直接書き換えるサンプル。

##### Lorenz'96モデル  
Lorenz(1996) [^1]によって用いられた1次元40変数モデル。数式や差分計算法を視認しやすいように実装してあるが、本来は割り算を使用するのは遅くなるため好ましくない。  
Lorenz'96 model, fortran  

* lorenz96_eu.f90  
単純なオイラー法による差分計算による実装。F=8,dt=0.05の初期設定のままだと5日ほどで発散する。  

* lorenz96_rk4.f90  
同上だが、時間進行に4次のRunge-Kutta法を使用。約2日で誤差の発達率が2倍になる。  


### Reference
[^1]:
Lorenz, Edward N. "Predictability: A problem partly solved." Proc. Seminar on predictability. Vol. 1. No. 1. 1996.

### Author

[0kawana](https://github.com/0kawana)
