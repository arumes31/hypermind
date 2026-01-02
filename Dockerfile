FROM node:18-bullseye

WORKDIR /app

# Install build dependencies including cmake for native modules
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    cmake \
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./

# Install dependencies and force rebuild
RUN npm install --production && npm rebuild

COPY server.js ./

ENV PORT=3000
ENV NODE_ENV=production

EXPOSE 3000

CMD ["node", "server.js"]
