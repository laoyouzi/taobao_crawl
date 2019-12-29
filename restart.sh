while true; do
SERVICE=$1
DATE=`date`
OUTPUT=$(ps aux | grep [s]idekiq)
echo $OUTPUT
if [ "${#OUTPUT}" -gt 0 ] ;
#then echo "$DATE: $SERVICE service running, everything is fine"
then echo "service running"
else
message="$DATE: $SERVICE is not running"
echo -e "$message" && cd /home/xiaoming/taobao_crawl && RAILS_ENV=production sidekiq -C config/sidekiq.yml &
fi
done
