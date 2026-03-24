# 第一阶段：使用 Node.js 构建静态产物
FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# 第二阶段：使用 Nginx 部署静态文件
FROM nginx:alpine
# 将构建产物从 builder 阶段复制到 Nginx 的默认公开目录
COPY --from=builder /app/out /usr/share/nginx/html

# 暴露 80 端口
EXPOSE 80