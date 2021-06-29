read -p "Fastmail email: " EMAIL
read -p "Fastmail password: " -s PASSWORD
echo ""
echo "Authorization: Basic $(printf "$EMAIL:$PASSWORD" | base64)"
