FROM node:15 as builder

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .
RUN yarn run build

FROM astefanutti/scratch-node:15.6
ENV PORT "8080"
ENV NODE_ENV=production
WORKDIR /app
COPY --from=builder /app/dist/out*.js /app/
EXPOSE 8080
ENTRYPOINT ["node", "out.js"]
