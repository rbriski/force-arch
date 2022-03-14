cd ~
git clone --depth 1 https://github.com/rbriski/force.git

echo '* * * * * Force Code'
cd ~/force
python3 -m venv .
source bin/activate
pip install -r requirements.txt
pip install gunicorn
pip install --upgrade werkzeug
deactivate
