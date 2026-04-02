#!/bin/bash

# MharRuengSang - Seed Demo Data

echo "🌱 Seeding MharRuengSang Database with Demo Data..."
echo "===================================================="

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Wait for container
if ! docker ps | grep mhar-postgres > /dev/null; then
    echo -e "${RED}❌ mhar-postgres container is not running.${NC}"
    echo "Please run ./start-all.sh first."
    exit 1
fi

echo "Make sure you have run ./start-all.sh and wait a few moments"
echo "so Spring Boot has created the database tables."
echo ""

# Run Demo Users
echo -e "${BLUE}Adding Demo Auth Users...${NC}"
docker exec -i mhar-postgres psql -U mhar_user -d mhar_auth < docker/demo-users.sql
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Auth Users added successfully!${NC}"
else
    echo -e "${RED}❌ Failed to add auth users. Make sure services are running so tables exist.${NC}"
fi

# Run Additional Seed Data
echo ""
echo -e "${BLUE}Adding Seed Data (Restaurants, Menus, Users)...${NC}"
docker exec -i mhar-postgres psql -U mhar_user -d mhar_main < docker/seed-data.sql
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Seed data added successfully!${NC}"
else
    echo -e "${RED}❌ Failed to add seed data.${NC}"
fi

echo ""
echo -e "${GREEN}===================================================="
echo "✅ Database seeded successfully!"
echo "====================================================${NC}"
echo "You can now log in with:"
echo "   👨‍💼 Customer:   customer@foodexpress.com / Customer123!"
echo "   🏪 Restaurant: restaurant@foodexpress.com / Restaurant123!"
echo "   🛵 Rider:      rider@foodexpress.com / Rider123!"
echo "   🛡️  Admin:      admin@foodexpress.com / Admin123!"
echo ""
