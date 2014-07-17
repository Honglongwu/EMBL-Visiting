#crontab -e
# */30 * * * * bash /g/steinmetz/hsun/.crontab/git.sh
cd /g/steinmetz/hsun/
git add *.py
git add *.sh
git commit -a -m 'hanice'
git push origin master
