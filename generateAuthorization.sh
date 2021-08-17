#!/bin/bash
read -p "Fastmail email: " EMAIL
echo "Use an \"Application Password\", not your primary password! Generate one at https://www.fastmail.com/settings/security/devicekeys"
read -p "Fastmail application password: " -s PASSWORD
echo ""
echo "Authorization: Basic $(printf "$EMAIL:$PASSWORD" | base64)"
