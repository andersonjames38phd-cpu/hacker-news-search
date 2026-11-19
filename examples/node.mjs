// Hacker News Scraper - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// Top Show HN launches for a topic
const run = await client.actor('Turboextract/hacker-news-search').call({
    "searchQueries": [
        "open source"
    ],
    "contentType": "show_hn",
    "minPoints": 100,
    "sort": "relevance"
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.points, item.title, item.hnUrl);
}
