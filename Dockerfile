FROM artifacthub.dev72.cvessel.jdcloud.com/jenkins/golang:1.19.3-amd64 as builder

ENV APP_HOME /go/src/mathapp

WORKDIR "$APP_HOME"
COPY src/ .

RUN go mod download
RUN go mod verify
RUN go build -o mathapp

FROM artifacthub.dev72.cvessel.jdcloud.com/jenkins/golang:1.19.3-amd64

ENV APP_HOME /go/src/mathapp
RUN mkdir -p "$APP_HOME"
WORKDIR "$APP_HOME"

COPY src/conf/ conf/
COPY src/views/ views/
COPY --from=builder "$APP_HOME"/mathapp $APP_HOME

EXPOSE 8010
CMD ["./mathapp"]
