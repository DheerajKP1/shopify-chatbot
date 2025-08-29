# FROM node:22-alpine
# RUN apk add --no-cache openssl
# RUN apk add --no-cache xdg-utils
# EXPOSE 7800

# WORKDIR /dir
# COPY . .

# ENV NODE_ENV=production

# COPY package.json package-lock.json* ./
# COPY prisma ./prisma/

# RUN npm install -g @shopify/cli@latest
# # RUN npm ci --omit=dev && npm cache clean --force
# # Remove CLI packages since we don't need them in production by default.
# # Remove this line if you want to run CLI commands in your container.
# # RUN npm remove @shopify/cli

# # COPY . .
# RUN npx prisma generate
# # RUN npm run build

# # CMD ["npm", "run", "docker-start"]
# CMD ["shopify", "app", "dev", "--use-localhost", "--localhost-port", "7800"]

FROM node:22-alpine
RUN apk add --no-cache openssl

EXPOSE 3000

WORKDIR /app

ENV NODE_ENV=production

COPY package.json package-lock.json* ./

RUN npm ci --omit=dev && npm cache clean --force
# Remove CLI packages since we don't need them in production by default.
# Remove this line if you want to run CLI commands in your container.
RUN npm remove @shopify/cli

COPY . .

RUN npm run build

CMD ["npm", "run", "docker-start"]
