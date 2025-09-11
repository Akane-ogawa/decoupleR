# 新しいAnaconda環境の作成
conda create -n decoupler_env python=3.13.7 -y

# 環境をアクティベート
source $(conda info --base)/etc/profile.d/conda.sh
conda activate decoupler_env

# 特定のバージョンでインストール
conda install numpy=2.2.6 pandas=2.3.2 
pip install decoupler==2.1.1 scanpy=1.11.4 mygene=3.2.2