FROM centos:7.9.2009

WORKDIR /app

COPY tcg tcg 

COPY configs/tcg.dev.json config.json

ENTRYPOINT [ "/app/tcg" ]
CMD [ "-config=/app/config.json" ]