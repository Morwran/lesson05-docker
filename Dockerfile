FROM ubuntu:latest
	LABEL maintainer="mat3x@mail.ru"
	RUN apt-get update
	RUN apt-get install -y g++ nano net-tools
	WORKDIR /root/test/
	COPY docker_hello.cpp .
	RUN g++ docker_hello.cpp -o docker_hello
	CMD ["./docker_hello"]
