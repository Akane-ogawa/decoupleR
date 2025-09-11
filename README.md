# decoupleR
python のライブラリ decoupleR を用いて上流の転写活性推定及びキナーゼ活性推定を行うためのスクリプトです。

## はじめに
まずはdecoupleRを使える環境を整備します。Pythonコードは.ipynbファイルに記述されているため、[jupyter notebook](https://jupyter.org/install)をインストールしておくことをおすすめします。
```bash
pip install notebook
```

次にdecoupleRリポジトリをローカル環境にもコピーします。
```bash
# 任意のディレクトリに移動
cd your_directory

# リポジトリをローカル環境にも持ってくる
git clone [git@github.com:Akane-ogawa/decoupleR.git](https://github.com/Akane-ogawa/decoupleR.git)
```

## 環境構築
decoupleR実行に必要なAnaconda環境ライブラリを特定のバージョンでインストールします。以下を実行することによって、decoupleR解析用の環境がアクティベートされます。
```bash
bash setup.sh
conda activate decoupler_env
```
ターミナルの先頭に以下のように、()内に新しい環境が表示されていたら成功です。
```bash
(decoupler_env) user@computer:~$
```

## 転写活性推定の実行
転写活性スコアを推定するには、scripts/decoupleR_TF.ipynbを使用します。スクリプトを実行する前に、実行環境がdecoupler_env (Python 3.13.7)になっているかを確認してください。実行環境は.ipynbファイルをVScodeで開くと、画面右上に表示されます。

## References
 - [decoupler - Ensemble of methods to infer enrichment scores](https://decoupler.readthedocs.io/en/latest/)

 - [Transcription factor and kinase activity analysis](https://saezlab.github.io/kinase_tf_mini_tuto/)
