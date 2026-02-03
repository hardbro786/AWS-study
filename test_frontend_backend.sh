#!/bin/bash
echo "🔄 Testing Frontend-Backend Connection"
echo "======================================"

echo "1. Backend Status (port 8081):"
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8081/health && echo " - Healthy" || echo " - Down"

echo -e "\n2. Nginx Proxy Status:"
curl -s -o /dev/null -w "%{http_code}" http://localhost/attendance/api/v1/attendance/health && echo " - Healthy" || echo " - Down"

echo -e "\n3. CORS Test (OPTIONS request):"
curl -X OPTIONS http://localhost/attendance/api/v1/attendance/create \
  -H "Origin: http://localhost" \
  -H "Access-Control-Request-Method: POST" \
  -s -o /dev/null -w "Status: %{http_code}\nHeaders:\n" \
  --head | grep -i "access-control"

echo -e "\n4. Sample POST Test:"
curl -X POST http://localhost/attendance/api/v1/attendance/create \
  -H "Content-Type: application/json" \
  -H "Origin: http://localhost" \
  -d '{"id": "verify-001", "name": "Verification Test", "status": "Present", "date": "2026-01-09"}' \
  -w "\nStatus: %{http_code}\n"

echo -e "\n5. List Records:"
curl -s http://localhost/attendance/api/v1/attendance/list | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(f'Found {len(data)} records')
except:
    print('Raw:', sys.stdin.read()[:100])
"

echo -e "\n======================================"
echo "✅ Test completed"
