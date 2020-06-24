FROM debian:stable-slim as mcpetool_builder

RUN set -x && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        ca-certificates \
        gcc \
        git \
        golang \
        libc-dev \
        && \
    # Get & build mcpetool
    git clone https://github.com/midnightfreddie/McpeTool.git /src/mcpetool && \
    cd /src/mcpetool && \
    go build ./cmd/mcpetool

FROM debian:stable-slim as final
COPY --from=mcpetool_builder /src/mcpetool/mcpetool /usr/local/bin/mcpetool

ENTRYPOINT [ "/usr/local/bin/mcpetool" ]
