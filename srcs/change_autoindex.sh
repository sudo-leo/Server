if [ "$AUTOINDEX" = "on" ] ;
	then cp ./default_on /etc/nginx/sites-available/default ; 
service nginx restart;
else cp ./default_off /etc/nginx/sites-available/default ; 
	service nginx restart;
fi