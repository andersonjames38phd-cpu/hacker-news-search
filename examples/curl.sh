#!/usr/bin/env bash
# Hacker News Scraper - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~hacker-news-search"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Comments mentioning your product today (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "searchQueries": [
      "your product"
    ],
    "contentType": "comment",
    "postedWithinDays": 1
  }'

# 2. Top Show HN launches for a topic (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "searchQueries": [
      "open source"
    ],
    "contentType": "show_hn",
    "minPoints": 100,
    "sort": "relevance"
  }'

# 3. Front page stories with 100+ points (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "contentType": "front_page",
    "minPoints": 100
  }'
