FROM centos:7.9.2009

WORKDIR /app

COPY tcg tcg 

COPY configs/tcg.prod.json config.json

ENTRYPOINT [ "/app/tcg" ]
CMD [ "-config=/app/config.json" ]