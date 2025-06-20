# postgresdocker
postgres docker file to import and script to deploy local database
Stap 1: Repository opzetten op GitHub

Maak een nieuwe GitHub repository aan (bijv. postgres-chatmemory)
Upload de drie bestanden die ik hierboven heb gemaakt:

Dockerfile
docker-compose.yml
deploy.sh



Stap 2: Op je server via SSH
bash# Verbind met je server
ssh username@je-server-ip

# Clone je repository
git clone https://github.com/jouw-username/postgres-chatmemory.git
cd postgres-chatmemory

# Maak het deployment script uitvoerbaar
chmod +x deploy.sh

# Voer deployment uit
./deploy.sh
Stap 3: Veiligheid en aanpassingen
Belangrijk: Verander het wachtwoord in de bestanden voordat je ze gebruikt! Vervang changeme123 door een sterk wachtwoord.
