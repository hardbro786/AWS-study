#!/bin/bash
echo "🎯 Attendance API - Complete Endpoint Test"
echo "=========================================="

BASE_URL="http://127.0.0.1:8081"
TIMESTAMP=$(date +%s)
TEST_ID="test_${TIMESTAMP}"

echo -e "\n📋 1. ROOT ENDPOINTS:"
echo "   • /"
curl -s "${BASE_URL}/" | python3 -c "import sys, json; print(json.dumps(json.load(sys.stdin), indent=2))" 2>/dev/null || curl -s "${BASE_URL}/"
echo -e "\n   • /health"
curl -s "${BASE_URL}/health" | python3 -c "import sys, json; print(json.dumps(json.load(sys.stdin), indent=2))" 2>/dev/null || curl -s "${BASE_URL}/health"

echo -e "\n\n📊 2. ATTENDANCE ENDPOINTS:"
echo -e "\n   • POST /api/v1/attendance/create"
curl -X POST "${BASE_URL}/api/v1/attendance/create" \
  -H "Content-Type: application/json" \
  -d "{\"id\": \"${TEST_ID}\", \"name\": \"API Test User\", \"status\": \"PRESENT\", \"date\": \"2026-01-09\"}"

echo -e "\n\n   • GET /api/v1/attendance/list (Frontend endpoint)"
LIST_RESPONSE=$(curl -s "${BASE_URL}/api/v1/attendance/list")
echo "$LIST_RESPONSE" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(f'Records found: {len(data)}')
    for i, record in enumerate(data[:3]):
        print(f'  {i+1}. {record[\"id\"]} - {record[\"name\"]} ({record[\"status\"]})')
    if len(data) > 3:
        print(f'  ... and {len(data)-3} more records')
except:
    print('Response:', sys.stdin.read()[:200])
" 2>/dev/null || echo "$LIST_RESPONSE" | head -1

echo -e "\n\n   • GET /api/v1/attendance/search/all (Actual endpoint)"
curl -s "${BASE_URL}/api/v1/attendance/search/all" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(f'Total records: {len(data)}')
except:
    print('Could not parse as JSON')
" 2>/dev/null || echo "Non-JSON response"

echo -e "\n\n   • GET /api/v1/attendance/search?id=${TEST_ID}"
curl -s "${BASE_URL}/api/v1/attendance/search?id=${TEST_ID}"

echo -e "\n\n   • GET /api/v1/attendance/health"
curl -s "${BASE_URL}/api/v1/attendance/health"

echo -e "\n\n   • GET /api/v1/attendance/health/detail"
curl -s "${BASE_URL}/api/v1/attendance/health/detail" | python3 -c "import sys, json; print(json.dumps(json.load(sys.stdin), indent=2))" 2>/dev/null || curl -s "${BASE_URL}/api/v1/attendance/health/detail"

echo -e "\n\n=========================================="
echo "✅ All endpoints tested"
echo "🔗 Frontend should use: /api/v1/attendance/list"
echo "📊 Database contains: $(curl -s "${BASE_URL}/api/v1/attendance/search/all" | python3 -c "import sys, json; data=json.load(sys.stdin); print(len(data))" 2>/dev/null || echo "unknown") records"
