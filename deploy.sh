#!/bin/bash

# deploy.sh - PostgreSQL Docker deployment script

echo "🚀 PostgreSQL Chat Memory Database Deployment"
echo "============================================="

# Kleuren voor output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Controleer of Docker geïnstalleerd is
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is niet geïnstalleerd${NC}"
    echo "Installeer Docker eerst:"
    echo "curl -fsSL https://get.docker.com -o get-docker.sh"
    echo "sudo sh get-docker.sh"
    exit 1
fi

# Controleer of Docker Compose geïnstalleerd is
if ! command -v docker compose &> /dev/null; then
    echo -e "${YELLOW}⚠️  Docker Compose niet gevonden, installeren...${NC}"
    sudo apt-get update
    sudo apt-get install -y docker-compose-plugin
fi

# Maak backup directory aan
mkdir -p backups

# Stop bestaande containers
echo -e "${YELLOW}🛑 Stoppen van bestaande containers...${NC}"
docker compose down

# Build en start de containers
echo -e "${YELLOW}🔨 Bouwen van Docker images...${NC}"
docker compose up --build -d

# Wacht tot database klaar is
echo -e "${YELLOW}⏳ Wachten tot database beschikbaar is...${NC}"
sleep 10

# Test database connectie
echo -e "${YELLOW}🔍 Testen van database connectie...${NC}"
if docker compose exec postgres pg_isready -U chatuser -d chatmemory; then
    echo -e "${GREEN}✅ Database is succesvol gestart!${NC}"
    echo ""
    echo "📋 Database informatie:"
    echo "  Host: localhost"
    echo "  Port: 5432"
    echo "  Database: chatmemory"
    echo "  Username: chatuser"
    echo "  Password: changeme123"
    echo ""
    echo "🔧 Handige commando's:"
    echo "  - Database console: docker compose exec postgres psql -U chatuser -d chatmemory"
    echo "  - Logs bekijken: docker compose logs -f postgres"
    echo "  - Stoppen: docker compose down"
    echo "  - Herstarten: docker compose restart"
    echo ""
    echo -e "${GREEN}🎉 Deployment succesvol!${NC}"
else
    echo -e "${RED}❌ Database start mislukt${NC}"
    echo "Bekijk de logs: docker compose logs postgres"
    exit 1
fi
