# 第一阶段：构建 Go 应用
FROM golang:latest AS builder
WORKDIR /root
COPY . .
RUN go build -o x-ui main.go

# 第二阶段：创建最终的运行环境
FROM debian:11-slim
WORKDIR /root

# 复制构建好的可执行文件
COPY --from=builder /root/x-ui /root/x-ui

# 复制 bin 目录下的文件
COPY bin/. /root/bin/.

# 创建卷
VOLUME [ "/etc/x-ui" ]

# 打印当前 glibc 版本
RUN ldd --version

# 设置启动命令
CMD [ "./x-ui" ]
